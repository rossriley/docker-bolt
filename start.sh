#! /bin/bash
chmod -R 0777 ./app;
IFS=', ' read -a array <<< "$BOLT_EXT"
for element in "${array[@]}"
do
    ./vendor/bin/nut extensions:install "$element"
done