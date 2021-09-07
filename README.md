# p2pool-docker
A simple and straightforward Dockerized [p2pool](https://github.com/SChernykh/p2pool) built from source and exposing standard ports.

## Actions

[![Daily Update Rebuild](https://github.com/sethsimmons/p2pool-docker//actions/workflows/update-daily.yml/badge.svg)](https://github.com/sethsimmons/p2pool-docker/actions/workflows/update-daily.yml)  
[![Weekly Update Rebuild](https://github.com/sethsimmons/p2pool-docker//actions/workflows/update-base-image.yml/badge.svg)](https://github.com/sethsimmons/p2pool-docker/actions/workflows/update-base-image.yml)  
[![Latest Dockerfile build](https://github.com/sethsimmons/p2pool-docker//actions/workflows/update-image-on-push.yml/badge.svg)](https://github.com/sethsimmons/p2pool-docker/actions/workflows/update-image-on-push.yml)  
[![Container security scan with Trivy](https://github.com/sethsimmons/p2pool-docker//actions/workflows/trivy-analysis.yml/badge.svg)](https://github.com/sethsimmons/p2pool-docker/actions/workflows/trivy-analysis.yml)

## Docker

![Docker Pulls](https://img.shields.io/docker/pulls/sethsimmons/p2pool)  
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/sethsimmons/p2pool)  
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/sethsimmons/p2pool)  

# Docker Hub
This repo is used to build the images available at:

https://hub.docker.com/r/sethsimmons/p2pool

# Tags

`latest`: The daily rebuild from source at https://github.com/SChernykh/p2pool

# Recommended usage

```bash
docker run -d --name="p2pool" -p 3333:3333 -p 37889:37889 -v p2pool-data:/home/p2pool sethsimmons/p2pool:latest --host node.sethforprivacy.com --rpc-port 18089 --wallet MoneroAddress --stratum 0.0.0.0:3333 --p2p 0.0.0.0:37889 --addpeers 65.21.227.114:37889 --addpeers node.sethforprivacy.com:37889
```

# Copyrights

Code from this repository is released under MIT license. [Monero License](https://github.com/monero-project/monero/blob/master/LICENSE), [@leonardochaia License](https://github.com/leonardochaia/docker-monerod/blob/master/LICENSE)

# Credits
The base for the Dockerfile was pulled from:

https://github.com/leonardochaia/docker-monerod
