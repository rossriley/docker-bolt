<?php
require_once "../vendor/autoload.php";
$config = require_once "../.bolt.php";
$app = $config['application'];

$app->run();