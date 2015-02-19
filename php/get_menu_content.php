<?php

include_once("autoloader.php");

$queries = New Queries("127.0.0.1","web_production","root","mysql");

if (isset($_REQUEST["menu_machine_name"])) {
  echo(json_encode($queries->getMenuLinks($_REQUEST["menu_machine_name"])));
} else {
  echo(json_encode($queries->getMenus()));
}