# Pilight in a docker image
This packages [pilight](https://github.com/pilight/pilight) in a Docker image to be run as a container. The repository is a fork from [monsterwels/pilight](https://github.com/monsterwels/pilight) with a few tweaks. The [Dockerfile](https://github.com/akloeckner/pilight-docker/blob/master/Dockerfile) basically uses the recommended [install procedure](https://manual.pilight.org/installation.html) from the pilight documentation. The images are built and pushed to [Docker hub](https://hub.docker.com/repository/docker/akloeckner/pilight/) every night.

There are the following tags:
| Tag     | `pilight` branch | build from                  |
| :------ | :----------------| :-------------------------- |
| latest  | `master`         | official package repository |
| nightly | `staging`        | official package repository |
| dev     | `staging`        | source                      |

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
