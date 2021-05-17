# Pilight in a docker image
[![Build Status](https://github.com/akloeckner/pilight-docker/actions/workflows/latest.yml/badge.svg)](https://github.com/akloeckner/pilight-docker/actions/workflows/latest.yml)
[![Build Status](https://github.com/akloeckner/pilight-docker/actions/workflows/nightly.yml/badge.svg)](https://github.com/akloeckner/pilight-docker/actions/workflows/nightly.yml)
[![Build Status](https://github.com/akloeckner/pilight-docker/actions/workflows/staging.yml/badge.svg)](https://github.com/akloeckner/pilight-docker/actions/workflows/staging.yml)
[![Number of pulls](https://img.shields.io/docker/pulls/akloeckner/pilight?label=Pulls%20from%20Docker%20Hub&logo=docker&logoColor=lightgray&color=blue)](https://hub.docker.com/r/akloeckner/pilight)

This packages [pilight](https://github.com/pilight/pilight) in a Docker image to be run as a container. The repository is a fork from [monsterwels/pilight](https://github.com/monsterwels/pilight) with a few tweaks. The [Dockerfile](https://github.com/akloeckner/pilight-docker/blob/master/Dockerfile) basically uses the recommended [install procedure](https://manual.pilight.org/installation.html) from the pilight documentation. The images are built and pushed to [Docker hub](https://hub.docker.com/repository/docker/akloeckner/pilight/) every night.

There are the following tags:

| Tag       | built from                   | Comments                                                                                                            |
| :-------- | :--------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| `latest`  | `stable` package repository  | This bundles the [latest release](https://github.com/pilight/pilight/releases): currently `v8.1.5` from 2 Aug 2019. |
| `nightly` | `nightly` package repository | This bundles the latest code changes in the current maintenance branch: `staging`.                                  |
| `dev`     | `staging` source code        | This builds the [current maintenance branch](https://github.com/pilight/pilight/tree/staging) from source.          |

If you want to run the image as a container, the following docker compose file might be a good starting point:
```yaml
version: '2.4'

services:
  pilight:
    image: akloeckner/pilight:nightly
    init: true # use init process, because pilight leaves behind pid file when not exited cleanly
    volumes:
    - /path/to/your/pilight/config:/etc/pilight # be sure to change the host's path to your config here
    ports:
    - 5000:5000 # usual daemon port
    - 5001:5001 # usual HTTP port
    - 5002:5002 # usual HTTPS port
    devices:
    - /dev/ttyUSB0:/dev/ttyUSB0 # if you have a 433nano device
    restart: unless-stopped # if you want to auto-restart the container
```
