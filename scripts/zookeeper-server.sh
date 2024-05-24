#!/bin/sh -e
__CURRENT__=$(cd "$(dirname "$0")";pwd)
__DIR__=$(cd "$(dirname "${__CURRENT__}")";pwd)
__ZK_VERSION__=$1

mkdir -p ${__DIR__}/tmp
wget -qqO - "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=zookeeper/zookeeper-${__ZK_VERSION__}/apache-zookeeper-${__ZK_VERSION__}.tar.gz" \
  | tar -xzf - --directory ${__DIR__}/tmp

__ZK_BIN__=${__DIR__}/tmp/apache-zookeeper-${__ZK_VERSION__}-bin

# setup instances
for i in `seq 1 3`; do
  __ZK_HOME__=${__DIR__}/tmp/zk${i}
  mkdir -p ${__ZK_HOME__}
  echo "${i}" > ${__ZK_HOME__}/myid
  cp ${__ZK_BIN__}/conf/zoo_sample.cfg ${__ZK_BIN__}/conf/zoo${i}.cfg
  sed -i "s|/tmp/zookeeper|${__ZK_HOME__}|g" ${__ZK_BIN__}/conf/zoo${i}.cfg
  sed -i "s/=2181/=218${i}/g" ${__ZK_BIN__}/conf/zoo${i}.cfg
  echo "standaloneEnabled=false" >> ${__ZK_BIN__}/conf/zoo${i}.cfg
  echo "reconfigEnabled=true" >> ${__ZK_BIN__}/conf/zoo${i}.cfg
  echo "DigestAuthenticationProvider.superDigest=timandes:8dxIww9kuQFupwX/wdccu2gU4w8=" >> ${__ZK_BIN__}/conf/zoo${i}.cfg
  echo "server.1=localhost:2888:3888;2181" >> ${__ZK_BIN__}/conf/zoo${i}.cfg
done

echo "server.2=localhost:2889:3889;2182" >> ${__ZK_BIN__}/conf/zoo2.cfg
echo "server.2=localhost:2889:3889;2182\nserver.3=localhost:2890:3890;2183" >> ${__ZK_BIN__}/conf/zoo3.cfg

# start instances
for i in `seq 1 3`; do
    ${__ZK_BIN__}/bin/zkServer.sh start ${__ZK_BIN__}/conf/zoo${i}.cfg
done

exit 0
