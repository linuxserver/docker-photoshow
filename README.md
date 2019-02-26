[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/photoshow](https://github.com/linuxserver/docker-photoshow)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/photoshow.svg)](https://microbadger.com/images/linuxserver/photoshow "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/photoshow.svg)](https://microbadger.com/images/linuxserver/photoshow "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/photoshow.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/photoshow.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-photoshow/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-photoshow/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/photoshow/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/photoshow/latest/index.html)

[Photoshow](https://github.com/thibaud-rohmer/PhotoShow) is gallery software at its easiest, it doesn't even require a database.

[![photoshow](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/photoshow-icon.png)](https://github.com/thibaud-rohmer/PhotoShow)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/photoshow` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=photoshow \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v <path to data>:/config \
  -v <path to pictures>:/Pictures:ro \
  -v <path to store thumbs>:/Thumbs \
  --restart unless-stopped \
  linuxserver/photoshow
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  photoshow:
    image: linuxserver/photoshow
    container_name: photoshow
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
      - <path to pictures>:/Pictures:ro
      - <path to store thumbs>:/Thumbs
    ports:
      - 80:80
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | WebUI |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Stores config and logs for nginx base. |
| `-v /Pictures:ro` | Your local folder of photos you wish to share. |
| `-v /Thumbs` | Local folder to store thumbnails of your images. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

On first run create an admin account, any folder and its subfolders that you map to /Pictures will be presented as a webgallery. Config settings are persistent and stored as a subfolder of the /Thumbs mapping.



## Support Info

* Shell access whilst the container is running: `docker exec -it photoshow /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f photoshow`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' photoshow`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/photoshow`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/photoshow`
* Stop the running container: `docker stop photoshow`
* Delete the container: `docker rm photoshow`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start photoshow`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/photoshow`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **22.02.19:** - Rebasing to alpine 3.9.
* **16.01.19:** - Add pipeline logic and multi arch.
* **05.09.18:** - Rebase to alpine 3.8.
* **07.01.18:** - Rebase to alpine 3.7.
* **25.05.17:** - Rebase to alpine 3.6.
* **03.05.17:** - Use repo pinning to better solve dependencies, use repo version of php7-imagick.
* **14.02.17:** - Rebase to alpine 3.5.
* **14.10.16:** - Add version layer information.
* **30.09.16:** - Rebase to alpine linux.
* **11.09.16:** - Add layer badges to README.
* **21.08.15:** - Use patched keybaord js from fork of photoshow.
* **21.08.15:** - Initial Release.
