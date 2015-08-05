# set base os
FROM linuxserver/baseimage.nginx

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# Set correct environment variables
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# set ports
EXPOSE 80

# set volumes
VOLUME /Thumbs /Pictures

# Set the locale
RUN locale-gen en_US.UTF-8

# update apt and install dependencies
RUN add-apt-repository ppa:kirillshkrogalev/ffmpeg-next && \
apt-get update && \
apt-get install \
git-core \
php5-gd \
ffmpeg -y && \

# clean up
cd / && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Adding Custom files
ADD defaults/photoshow.fpm /etc/php5/fpm/pool.d/photoshow.conf
ADD defaults/photoshow.www /defaults/photoshow
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/my_init.d/*.sh

