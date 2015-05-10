--TEST--
Zookeeper Constructor
--SKIPIF--
<?php if (!extension('zookeeper')) print $skip; ?>
--FILE--
<?php
$client = new Zookeeper();
echo get_class($client);
--EXPECT--
Zookeeper
