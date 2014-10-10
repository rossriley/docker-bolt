#!/bin/sh
chmod -R 0777 ./app;
IFS=","
set -- $BOLT_EXT
for element in $@
do
    echo "Installing extestion $element";
    eval "./vendor/bin/nut extensions:install $element";
done