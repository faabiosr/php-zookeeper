#!/bin/sh -e

phpize
./configure $@
make
make install

echo "extension=zookeeper.so" >> $(php -i | grep /.+/php.ini -oE)
php --ri zookeeper
