<?php 

class Queries extends PDOHelper {
	
	public function getPages() {
    	$sql = "SELECT pages.id, pages.title, pages.body, pages.created, CONCAT(user_data.first_name, ' ', user_data.last_name) AS author FROM pages, user_data ORDER BY pages.id DESC";
    	return $this->query($sql);
  	}

  	public function getPageFromUrl($urlAlias) {

    	$dataArray = array();

    	$sql = "SELECT * FROM pages LEFT JOIN url_alias ON pages.id = url_alias.page_id 
    		AND url_alias.path = :path ORDER BY url_alias.id";
    	$pageData = array(":path" => $urlAlias);
    	$pageData = $this->query($sql, $pageData);

	    $dataArray["page_data"] = $pageData;

    	$sql2 = "SELECT CONCAT(first_name, ' ', last_name) AS author FROM user_data WHERE user_id = :user_id";
    	$userData = array(":user_id" => $dataArray["page_data"][0]["user_id"]);
    	$author = $this->query($sql2, $userData);

	    $dataArray["author_data"] = $author;

    	return $dataArray;
  	}

  	public function pageSearch($searchParameter) {
    	$searchParameter = array(":search_parameter" => "%".$searchParameter."%");
    	$sql = "SELECT pages.id, pages.title, pages.body, pages.created, CONCAT(user_data.first_name, ' ', user_data.last_name) AS author FROM pages, user_data WHERE pages.title LIKE :search_parameter";
    	return $this->query($sql, $searchParameter);
  	}

  	public function getMenus() {
  		$sql = "SELECT * FROM menus";
  		return $this->query($sql);
  	}

  	public function getMenuLinks($menuMachineName) {
  		$menuMachineName = array(":menu_machine_name" => $menuMachineName);
  		$sql = "SELECT * FROM menu_links WHERE menu_machine_name = :menu_machine_name";

  		return $this->query($sql, $menuMachineName);
  	}
}
