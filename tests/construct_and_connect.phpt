--TEST--
Construct Zookeeper and connect
--SKIPIF--
<?php if (!extension('zookeeper')) print $skip; ?>
--FILE--
<?php
$client = new Zookeeper('localhost:2181');
echo get_class($client);
--EXPECT--
Zookeeper
