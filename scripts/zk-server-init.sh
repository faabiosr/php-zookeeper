#!/bin/sh -e
# start instances
for i in $(ls /etc/zk/conf/node*.cfg); do
    /usr/local/zookeeper/bin/zkServer.sh start ${i}
done

exit 0
