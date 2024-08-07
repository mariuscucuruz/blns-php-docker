#!/usr/bin/env php
<?php

use App\VanillaPHP\MattSparksBLNS;

require_once __DIR__ . '/vendor/autoload.php';

$mattsBlns = new MattSparksBLNS();

echo 'List: ' . count($mattsBlns->getList()) . PHP_EOL;
echo 'Base64 List: ' . count($mattsBlns->getBase64List()) . PHP_EOL;
