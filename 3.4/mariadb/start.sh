#!/bin/bash
./vendor/bin/nut database:update;
mkdir -p ./app/cache;
mkdir -p ./app/config;
mkdir -p ./app/database;
mkdir -p ./public/extensions;
mkdir -p ./public/extensions/var;
mkdir -p ./public/files;
mkdir -p ./extensions;
chmod -R 0777 ./app;
chmod -R 0777 ./public/extensions;
chmod 0777 ./public/files;


chmod -R 0777 ./extensions;
rm -f /var/run/apache2/apache2.pid
exec apache2-foreground
