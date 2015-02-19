<?php

include_once("autoloader.php");

$queries = New Queries("127.0.0.1","web_production","root","mysql");

if (isset($_REQUEST["search_parameter"])) {
	echo(json_encode($queries->pageSearch($_REQUEST["search_parameter"])));
} elseif (isset($_REQUEST["url_alias"])) {
	echo(json_encode($queries->getPageFromUrl($_REQUEST["url_alias"])));
} else {
	echo(json_encode($queries->getPages()));
}