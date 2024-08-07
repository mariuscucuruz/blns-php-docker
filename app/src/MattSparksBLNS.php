<?php

namespace VanillaPHP;

use MattSparks\BLNS\BLNS;

class MattSparksBLNS
{
    public BLNS $blns;
    private array $list = [];
    private array $list64 = [];

    public function __construct()
    {
        $this->blns = new BLNS();

        $this->list = $this->getList();
        $this->list64 = $this->getBase64List();
    }

    public function getBase64List(): array
    {
        return $this->blns->getBase64List();
    }

    public function getList(): array
    {
        return $this->blns->getList();
    }
}
