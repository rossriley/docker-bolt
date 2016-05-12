<?php
require_once "../vendor/autoload.php";
$configuration = new Bolt\Configuration\Composer(dirname(__DIR__));
$configuration->setPath("web","public");
$configuration->setPath("files","public/files");
$configuration->setPath("themebase","public/theme");
$configuration->getVerifier()->removeCheck('apache');
$configuration->verify();
$app = new Bolt\Application(array('resources'=>$configuration));
$app->initialize();
$app->run();