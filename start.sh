#!/usr/bin/env bash
chmod -R 0777 ./app;
IFS=', ' read -a array <<< "$BOLT_EXT"
for element in "${array[@]}"
do
    echo "Installing extestion $element";
    ./vendor/bin/nut extensions:install "$element";
done