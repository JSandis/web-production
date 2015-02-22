<?php

include_once("autoloader.php");

$queries = New Queries("127.0.0.1","web_production","root","mysql");

if (isset($_REQUEST["image_data"])) {
  echo(json_encode($queries->uploadImage($_REQUEST["image_data"])));
}