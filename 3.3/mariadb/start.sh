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

eval "./vendor/bin/nut config:set database/driver mysql";
if [[ $APP_USER ]]
then
    eval "./vendor/bin/nut config:set database/username '$APP_USER'";
    eval "./vendor/bin/nut config:set database/databasename '$APP_USER'";
fi

if [[ $APP_PASSWORD ]]
then
    eval "./vendor/bin/nut config:set database/password '$APP_PASSWORD'";
fi

rm -f /var/run/apache2/apache2.pid
exec apache2-foreground
