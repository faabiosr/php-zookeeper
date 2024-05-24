#!/bin/sh -e
__CURRENT__=$(cd "$(dirname "$0")";pwd)
__DIR__=$(cd "$(dirname "${__CURRENT__}")";pwd)
__ZK_VERSION__=$1

mkdir -p ${__DIR__}/tmp
wget -qqO - "https://archive.apache.org/dist/zookeeper/zookeeper-${__ZK_VERSION__}/apache-zookeeper-${__ZK_VERSION__}.tar.gz" \
  | tar -xzf - --directory ${__DIR__}/tmp
cd ${__DIR__}/tmp/apache-zookeeper-${__ZK_VERSION__}
mvn -pl zookeeper-jute compile
cd ./zookeeper-client/zookeeper-client-c
autoreconf -if
./configure --prefix=/opt/libzookeeper
make
make install
