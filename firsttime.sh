#!/bin/bash

cd /opt/gistpb
composer install
cp -f /data/gistpb/propel.yaml propel.yaml
ln -fs /data/gistpb/caddyssl /root/.caddy
mkdir -p /data/gistpb/data/git
mkdir -p /data/gistpb/data/cache
mkdir -p /opt/gistpb/data/cache
mkdir -p /opt/gistpb/cache
chmod -R 666 /opt/gistpb/cache
chown -R www-data:www-data data
make propel
cp -f /data/gistpb/app/config/config.yml /opt/gistpb/app/config/config.yml
npm install
apt-get purge -y --auto-remove
rm -rf /var/lib/apt/lists/*

