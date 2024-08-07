<?php

namespace App\VanillaPHP\Tests;

use App\VanillaPHP\MattSparksBLNS as ProxyBLNS;
use PHPUnit\Framework\TestCase;

class SimpleTest extends TestCase
{
    protected static $blns;

    public static function setUpBeforeClass(): void
    {
        self::$blns = new ProxyBLNS();
    }

    public function test_that_lists_are_converted_to_array()
    {
        Assertions::assertIsArray(self::$blns->getList());
        Assertions::assertIsArray(self::$blns->getBase64List());
    }

    public function test_that_lists_arent_empty()
    {
        Assertions::assertNotEmpty(self::$blns->getList());
        Assertions::assertNotEmpty(self::$blns->getBase64List());
    }
}
