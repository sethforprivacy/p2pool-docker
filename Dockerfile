# renovate: datasource=github-releases depName=SChernykh/p2pool
ARG P2POOL_BRANCH=v4.17

# Pin to the latest Ubuntu LTS for the build image base (kept current by Renovate)
FROM ubuntu:26.04 as build
LABEL author="sethforprivacy@protonmail.com" \
      maintainer="sethforprivacy@protonmail.com"

# Dependency list from https://github.com/SChernykh/p2pool#ubuntu-2004
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends git \
    build-essential cmake libuv1-dev libzmq3-dev libsodium-dev libpgm-dev libnorm-dev \
    libgss-dev libcurl4-openssl-dev libidn2-0-dev ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV CFLAGS='-fPIC'
ENV CXXFLAGS='-fPIC'
ENV USE_SINGLE_BUILDDIR 1
ENV BOOST_DEBUG         1

# Switch to p2pool source directory
WORKDIR /p2pool

# Git pull p2pool source at specified tag/branch
ARG P2POOL_BRANCH
RUN git clone --recursive --depth 1 --shallow-submodules --branch ${P2POOL_BRANCH} https://github.com/SChernykh/p2pool .

# Make static p2pool binary
ARG NPROC
RUN test -z "$NPROC" && nproc > /nproc || echo -n "$NPROC" > /nproc && mkdir build && cd build && cmake .. && make -j"$(cat /nproc)"

# Pin to the latest Ubuntu LTS for the image base (kept current by Renovate)
FROM ubuntu:26.04

# Install only the runtime shared libraries that the p2pool binary links against
# (runtime equivalents of the build-stage -dev packages, verified via ldd on the
# built binary against the pinned Ubuntu 24.04 base)
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y libuv1t64 libzmq5 libsodium23 \
    libpgm-5.3-0t64 libnorm1t64 libgssapi-krb5-2 libcurl4t64 libidn2-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add user and setup directories for p2pool
RUN useradd -ms /bin/bash p2pool
USER p2pool

# Switch to home directory and install newly built p2pool binary
WORKDIR /home/p2pool
COPY --chown=p2pool:p2pool --from=build /p2pool/build/p2pool /usr/local/bin/p2pool

# Expose p2p and restricted RPC ports
EXPOSE 3333
EXPOSE 37889

# Start p2pool with required --non-interactive flag and sane defaults that are overridden by user input (if applicable)
ENTRYPOINT ["p2pool"]
CMD ["--host p2pool", "--stratum 0.0.0.0:3333", "--p2p 0.0.0.0:37889", "--addpeers 65.21.227.114:37889", "--addpeers node.sethforprivacy.com:37889"]
