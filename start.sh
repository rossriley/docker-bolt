#!/bin/sh
chmod -R 0777 ./app;
echo "BOLT_EXT is $BOLT_EXT";
IFS=","
set -- $BOLT_EXT
for element in $@
do
    echo "Installing extestion $element";
    ./vendor/bin/nut extensions:install "$element";
done