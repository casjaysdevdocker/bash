# bash Readme 👋

base alpine image with bash and tmux

## Run container

dockermgr install bash

### via command line

```shell
docker run -d \
--restart always \
--name bash \
--hostname casjaysdev-bash \
-e TZ=${TIMEZONE:-America/New_York} \
-v $PWD/bash/data:/root \
-v $PWD/bash/config:/config \
casjaysdev/bash:latest
```

### via docker-compose

```yaml
version: "2"
services:
  bash:
    image: casjaysdevdocker/bash
    container_name: bash
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-bash
    volumes:
      - $HOME/.local/share/docker/storage/bash/data:/root
      - $HOME/.local/share/docker/storage/bash/config:/config
    restart: 
      - always
```

## Authors  

🤖 Casjay: [Github](https://github.com/casjay) [Docker](https://hub.docker.com/casjay) 🤖  
⛵ CasjaysDev: [Github](https://github.com/casjaysdev) [Docker](https://hub.docker.com/casjaysdev) ⛵  
