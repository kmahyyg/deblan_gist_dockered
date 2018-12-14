#!/bin/bash

cd /opt/gistpb
composer install
cp -f /data/gistpb/propel.yaml propel.yaml
ln -fs /data/gistpb/data /opt/gistpb/data
ln -fs /data/gistpb/caddyssl /root/.caddy
mkdir -p /opt/gistpb/data/git
mkdir -p /opt/gistpb/data/cache
chown -R www-data:www-data data
make propel
cp -f /data/gistpb/app/config/config.yml /opt/gistpb/app/config/config.yml
npm install
apt-get purge -y --auto-remove
rm -rf /var/lib/apt/lists/*

