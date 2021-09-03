# p2pool-docker
A simple and straightforward Dockerized [p2pool](https://github.com/SChernykh/p2pool) built from source and exposing standard ports.

## Actions

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
I will always release the latest Monero version under the `latest` tag.

`latest`: The latest tagged version of Monero from https://github.com/monero-project/monero/tags  

# Recommended usage

TBD

# Copyrights

Code from this repository is released under MIT license. [Monero License](https://github.com/monero-project/monero/blob/master/LICENSE), [@leonardochaia License](https://github.com/leonardochaia/docker-monerod/blob/master/LICENSE)

# Credits
The base for the Dockerfile was pulled from:

https://github.com/leonardochaia/docker-monerod
