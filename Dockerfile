FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.13

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PHOTOSHOW_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	fbida-exiftran \
	ffmpeg \
	imagemagick \
	jq \
	php7-exif \
	php7-gd \
	php7-imagick \
	zip && \
 echo "**** Tag this image with current version ****" && \
 if [ -z ${PHOTOSHOW_COMMIT+x} ]; then \
        PHOTOSHOW_COMMIT=$(curl -sX GET https://api.github.com/repos/thibaud-rohmer/PhotoShow/commits/master \
        | jq -r '. | .sha'); \
 fi && \
 echo ${PHOTOSHOW_COMMIT} > /version.txt && \
 echo "**** configure php ****" && \
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
