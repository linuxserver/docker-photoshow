FROM lsiobase/alpine.nginx
MAINTAINER Sparklyballs

# install packages
RUN \
 apk add --no-cache \
	ffmpeg \
	php5-gd && \

# configure php
echo "[www]" >> /defaults/nginx-fpm.conf && \
echo "php_admin_value[upload_max_filesize] = 10M" >> /defaults/nginx-fpm.conf && \
echo "php_admin_value[post_max_size] = 10M" >> /defaults/nginx-fpm.conf && \
echo "php_admin_value[memory_limit] = 64M" >> /defaults/nginx-fpm.conf && \
echo "php_admin_value[max_execution_time] = 15" >> /defaults/nginx-fpm.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /Thumbs /Pictures
