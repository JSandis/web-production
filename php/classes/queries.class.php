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

  public function saveNewPage($pageData) {

    $pageData[':user_id'] = 1;//$this->userInfo["user_id"];

    $path = $pageData[':path'];
    unset($pageData[":path"]);

    $menuData = $pageData['menuData'];
    unset($pageData['menuData']);

    $sql = "INSERT INTO pages (title, body, user_id) VALUES (:title, :body, :user_id)";
    $this->query($sql, $pageData);

    $sql2 = "SELECT id FROM pages ORDER BY created DESC LIMIT 1";
    $pageId = $this->query($sql2);
    $pageId = $pageId[0]['id'];

    $sql3 = "INSERT INTO url_alias (path, page_id) VALUES (:path, :page_id)";
    $urlAliasData = array(
      ':path' => $path, 
      ':page_id' => $pageId);
    $this->query($sql3, $urlAliasData);

    if (isset($menuData)) {
      $sql4 = "INSERT INTO menu_links (title, path, menu_machine_name, menu_link_id, weight) VALUES (:title, :path, :menu_machine_name, :menu_link_id, :weight)";
      $menuData = array(
        ':title' => $menuData['title'],
        ':path' => $path,
        ':menu_machine_name' => $menuData['parent']['menu_machine_name'],
        ':menu_link_id' => $menuData['parent']['id'] ? $menuData['parent']['id'] : null,
        ':weight' => $menuData["weight"]
      );
      $this->query($sql4, $menuData);
    }

    return true;
  }

  public function getFooterContent() {

    $dataArray = array();

    $sql = "SELECT * FROM users INNER JOIN user_data ON users.id = user_data.user_id WHERE users.id = :user_id";
    $userData = array(":user_id" => 1); //User with user id 1 is the company owner (for now)
    $footerData = $this->query($sql, $userData);

    $dataArray["footer_data"] = $footerData;

    return $dataArray;
  }
}
