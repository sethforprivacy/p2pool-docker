# Select Ubuntu 20.04LTS for the build image base
FROM ubuntu:20.04 as build
LABEL author="sethsimmons@pm.me" \
      maintainer="sethsimmons@pm.me"

# Dependency list from https://github.com/monero-project/monero#compiling-monero-from-source
# Added DEBIAN_FRONTEND=noninteractive to workaround tzdata prompt on installation
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends git \
    build-essential cmake libuv1-dev libzmq3-dev libsodium-dev libpgm-dev libnorm-dev \
    libgss-dev ca-certificates\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV CFLAGS='-fPIC'
ENV CXXFLAGS='-fPIC'
ENV USE_SINGLE_BUILDDIR 1
ENV BOOST_DEBUG         1

# Switch to Monero source directory
WORKDIR /p2pool

# Git pull Monero source at specified tag/branch
RUN git clone --recursive https://github.com/SChernykh/p2pool .

# Make static Monero binaries
ARG NPROC
RUN test -z "$NPROC" && nproc > /nproc || echo -n "$NPROC" > /nproc && mkdir build && cd build && cmake .. && make -j"$(cat /nproc)"

# Select Ubuntu 20.04LTS for the image base
FROM ubuntu:20.04

# Install remaining dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y libuv1-dev libzmq3-dev libsodium-dev libpgm-dev libnorm-dev libgss-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add user and setup directories for monerod
RUN useradd -ms /bin/bash p2pool
USER p2pool

# Switch to home directory and install newly built monerod binary
WORKDIR /home/p2pool
COPY --chown=p2pool:p2pool --from=build /p2pool/build/p2pool /usr/local/bin/p2pool

# Expose p2p and restricted RPC ports
EXPOSE 3333
EXPOSE 37889

# Start monerod with required --non-interactive flag and sane defaults that are overridden by user input (if applicable)
ENTRYPOINT ["p2pool"]
CMD ["--host monerod", "--stratum 0.0.0.0:3333", "--p2p 0.0.0.0:37889", "--addpeers 65.21.227.114:37889", "--addpeers node.sethforprivacy.com:37889"]
