#!/bin/sh -e
__CURRENT__=$(cd "$(dirname "$0")";pwd)
__DIR__=$(cd "$(dirname "${__CURRENT__}")";pwd)

pecl package
pecl install --configureoptions 'with-libzookeeper-dir="/opt/libzookeeper"' zookeeper*.tgz
echo "extension=zookeeper.so" >> $(php -i | grep /.+/php.ini -oE)
php --ri zookeeper
