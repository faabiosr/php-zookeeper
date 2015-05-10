--TEST--
Zookeeper Constructor with invalid parameter
--SKIPIF--
<?php if (!extension('zookeeper')) print $skip; ?>
--FILE--
<?php
$client = new Zookeeper('localhost:2181', 10);
--EXPECTF--
Warning: Zookeeper::__construct() expects parameter %d to be a valid callback, no array or string given in %s on line %d
