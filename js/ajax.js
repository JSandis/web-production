function getPages(searchParameter) {
  $.ajax({
    url: "php/get_content.php",
    type: "get",
    dataType: "json",
    data: {
      "search_parameter": searchParameter
    },
    success: listPages,
    error: function(data) {
      console.log("getPages error: ", data.responseText);
    }
  });
}

function getCurrentPage(href) {
  $.ajax({
    url: "php/get_content.php",
    dataType: "json",
    data: {
      url_alias: href
    },
    success: showPageContent,
    error: function(data) {
      console.log("getCurrentPage error: ", data.responseText);
    }
  });
}

function getMenuLinks(menu_machine_name, successFunction) {
  $.ajax({
    url: "php/get_menu_content.php",
    type: "get",
    dataType: "json",
    data: {
      "menu_machine_name": menu_machine_name
    },
    success: successFunction,
    error: function(data) {
      console.log("getMenuLinks error: ", data.responseText);
    }
  });
}

function saveNewPage(pageFormData) {
  $.ajax({
    url: "php/save_page.php",
    type: "post",
    dataType: "json",
    data: {
      "page_data" : pageFormData
    },
    success: function(data) {
      goToPage("page-list");
    },
    error: function(data) {
      console.log("saveNewPage error: ", data);
    }
  });
}

function getFooterContent(searchParameter) {
  $.ajax({
    url: "php/get_footer_content.php",
    dataType: "json",
    data: {
      "search_parameter": searchParameter
    },
    success: showFooterContent,
    error: function(data) {
      console.log("getFooterContent error: ", data.responseText);
    }
  });
}