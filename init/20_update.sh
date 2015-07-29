#!/bin/bash

apt-get update -qq
apt-get --only-upgrade install \
git-core \
nginx \
php5-fpm \
php5-gd \
libgd2-xpm-dev \
supervisor \
ffmpeg -qqy
