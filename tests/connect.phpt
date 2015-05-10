--TEST--
Should connect on Zookeeper
--SKIPIF--
<?php if (!extension('zookeeper')) print $skip; ?>
--FILE--
<?php
$client = new Zookeeper();
echo gettype($client->connect('localhost:2181'));
--EXPECT--
NULL
