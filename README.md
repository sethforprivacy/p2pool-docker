# p2pool-docker
A simple and straightforward Dockerized [p2pool](https://github.com/SChernykh/p2pool) built from source and exposing standard ports.

## Actions

[![Latest Dockerfile build on push](https://github.com/sethforprivacy/p2pool-docker/actions/workflows/update-image-on-push.yml/badge.svg)](https://github.com/sethforprivacy/p2pool-docker/actions/workflows/update-image-on-push.yml)  

# Docker Hub
This repo is used to build the images available here on GHCR.

# Tags

`latest`: The latest version of p2pool built from source at https://github.com/SChernykh/p2pool; the image is rebuilt only when the Dockerfile changes

# Recommended usage

*NOTE: Remember to replace the host address with your own node (if desired) as well as the Monero address for the `--wallet` flag, or else you'll be making a kind hashrate donation to me.*

```bash
docker run -d --name="p2pool" -p 3333:3333 -p 37889:37889 -v p2pool-data:/home/p2pool -v /dev/hugepages:/dev/hugepages:rw ghcr.io/sethforprivacy/p2pool:latest --host 5.9.120.18 --rpc-port 18089 --wallet 468ydghFfthE3UTc53eF5MP9UyrMcUiAHP5kizVYJsej5XGaXBoAAEzUHCcUF7t3E3RrYAX8Rs1ujhBdcvMpZSbH8qkb55R --stratum 0.0.0.0:3333 --p2p 0.0.0.0:37889 --addpeers 65.21.227.114:37889,node.sethforprivacy.com:37889
```

# Copyrights

Code from this repository is released under MIT license. [Monero License](https://github.com/monero-project/monero/blob/master/LICENSE), [@leonardochaia License](https://github.com/leonardochaia/docker-monerod/blob/master/LICENSE)

# Credits
The base for the Dockerfile was pulled from:

https://github.com/leonardochaia/docker-monerod
