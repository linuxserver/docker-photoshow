#!/bin/bash
if [ ! -f "/var/www/PhotoShow/config.php" ]; then
echo "fetching photoshow files from github"
git clone https://github.com/thibaud-rohmer/PhotoShow.git /var/www/PhotoShow
sed -i -e 's/$config->photos_dir.\+/$config->photos_dir = "\/Pictures";/' /var/www/PhotoShow/config.php
sed -i -e 's/$config->ps_generated.\+/$config->ps_generated = "\/Thumbs";/' /var/www/PhotoShow/config.php
else
echo "checking for updates"
cd /var/www/PhotoShow
git pull
fi
sed -i -e "s@\$config->timezone.*@\$config->timezone = \"${TZ}\"@g" /var/www/PhotoShow/config.php
chown -R abc:abc /var/www/PhotoShow /Thumbs
