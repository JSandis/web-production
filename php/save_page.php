<?php

include_once("autoloader.php");

$queries = New Queries("127.0.0.1","web_production","root","mysql");

if (isset($_REQUEST["page_data"])) {
  echo(json_encode($queries->saveNewPage($_REQUEST["page_data"])));
}