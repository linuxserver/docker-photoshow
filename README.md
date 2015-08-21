![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/photoshow

Photo gallery software at its easiest, doesn't even require a database. 

## Usage

```
docker create --name=photoshow -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -v <path to pictures>:/Pictures:ro -v <path to store thumbs>:/Thumbs -e PGID=<gid> -e PUID=<uid> -e TZ=<timezone> -p 80:80 linuxserver/photoshow
```

**Parameters**

* `-p 80` - port for the webui
* `-v /etc/localhost` for timesync - *optional*
* `-v /config` - stores config and logs for nginx base
* `-v /Pictures` - your local folder of photos you wish to share
* `-v /Thumbs` - local folder to store thumbnails of your images
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` - for timezone information *eg Europe/London, etc*

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it photoshow /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

On first run create an admin account, any folder its subfolders that you map to /Pictures will be presented as a webgallery. Config settings are persistent and stored as a subfolder of the /Thumbs mapping. 


## Updates

* Upgrade to the latest version simply `docker restart photoshow`.
* To monitor the logs of the container in realtime `docker logs -f photoshow`.



## Versions

+ **21.08.2015:** Initial Release. 
