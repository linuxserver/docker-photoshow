# set base os
FROM phusion/baseimage:0.9.17
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive 
ENV HOME /root 
ENV TERM screen
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
nginx \
php5-fpm \
php5-gd \
libgd2-xpm-dev \
supervisor \
ffmpeg -y && \

# clean up
cd / && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Adduser abc
RUN useradd -u 911 -U -s /bin/false abc
RUN usermod -G users abc

#Adding Custom files
ADD defaults/photoshow.conf /etc/php5/fpm/pool.d/photoshow.conf
ADD defaults/www.conf /etc/php5/fpm/pool.d/www.conf 
ADD defaults/supervisord.conf /root/supervisord.conf
ADD defaults/nginx.conf /etc/nginx/nginx.conf
ADD defaults/photoshow.www /etc/nginx/sites-available/photoshow
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/my_init.d/*.sh

# remove nginx default site and link our site to sites-enabled
RUN rm -f /etc/nginx/sites-enabled/default && \
ln -s /etc/nginx/sites-available/photoshow /etc/nginx/sites-enabled/photoshow 

# set daemon off in php-fpm
RUN sed -i -e 's/^.\+daemonize.\+$/daemonize = no/' /etc/php5/fpm/php-fpm.conf
