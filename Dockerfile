FROM lsiobase/alpine.nginx:3.5
MAINTAINER Sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# add repositories
RUN \
 echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
 echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \

# install packages
 apk add --no-cache \
	ffmpeg && \
 apk add --no-cache \
	imagemagick@edge \
	libwebp@edge && \
 apk add --no-cache \
	php7-gd@community \
	php7-imagick@community && \

# configure php
echo "[www]" >> /etc/php7/php-fpm.conf && \
echo "php_admin_value[upload_max_filesize] = 10M" >> /etc/php7/php-fpm.conf && \
echo "php_admin_value[post_max_size] = 10M" >> /etc/php7/php-fpm.conf && \
echo "php_admin_value[memory_limit] = 64M" >> /etc/php7/php-fpm.conf && \
echo "php_admin_value[max_execution_time] = 15" >> /etc/php7/php-fpm.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /Thumbs /Pictures
