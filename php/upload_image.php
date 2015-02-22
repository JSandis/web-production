<?php

include_once("autoloader.php");


if (isset($_REQUEST["image_data"])) {
  echo(json_encode($queries->uploadImage($_REQUEST["image_data"])));
}