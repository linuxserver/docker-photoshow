# set base os
FROM linuxserver/baseimage.nginx

MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

# Set correct environment variables
ENV APTLIST="ffmpeg git-core php5-gd"
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

# Set the locale
RUN locale-gen en_US.UTF-8

# update apt and install dependencies
RUN add-apt-repository ppa:kirillshkrogalev/ffmpeg-next && \
apt-get update && \
apt-get install \
$APTLIST -qy && \

# clean up
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Adding Custom files
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \
mv defaults/photoshow.fpm /etc/php5/fpm/pool.d/photoshow.conf

# set volumes and ports
EXPOSE 80
VOLUME /config /Thumbs /Pictures 
