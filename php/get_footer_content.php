<?php

include_once("autoloader.php");

$queries = New Queries("127.0.0.1","web_production","root","mysql");

 echo(json_encode($queries->getFooterContent()));