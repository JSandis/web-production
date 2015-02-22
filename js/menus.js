function createMainMenu(data) {
  var menuItems = createMenuTree(data);
  var mainMenuHtml = $('<ul class="nav navbar-nav main-menu"/>');
  
  mainMenuHtml = buildMainSubMenus(mainMenuHtml, menuItems);

  $("header .navbar-collapse").find(".main-menu").remove();
  $("header .navbar-collapse").prepend(mainMenuHtml);
}

function buildMainSubMenus(mainMenuHtml, menuItems) {
  for (var i = 0; i < menuItems.length; i++) {
    var menuLink;
    
    if (menuItems[i].children.length < 1) {
      menuLink = $('<li><a href="'+menuItems[i].path+'">'+menuItems[i].title+'</a></li>');
    } else {
      menuLink = $('<li class="dropdown"><a href="'+menuItems[i].path+'">'+menuItems[i].title+'</a></li>');
      var dropDownMenu = $('<ul class="dropdown-menu"/>');
      menuLink.prepend(dropDownMenu);
      buildMainSubMenus(dropDownMenu, menuItems[i].children);
    }
    mainMenuHtml.append(menuLink);
  }
  return mainMenuHtml;
}

function createMenuTree(menuData) {
  var menuTree = [];

  menuData.sort(function(x,y){
    return x.weight > y.weight;
  });

  var hash = {};

  menuData.forEach(function(link) {
    link.children = [];
    hash["_"+link.id] = link;

    if(link.menu_link_id === null){
      menuTree.push(link);
      return;
    }
  });

  for(var i in hash){
    link = hash[i];

    if(!link.menu_link_id){continue;}
    hash["_"+link.menu_link_id].children.push(link);
  }
  return menuTree;
}

function createFormMenuSelect(data) {
  var menuTree = createMenuTree(data);
  var selectHtml = $('<select class="form-control"/>');
  var topOption = $('<option value="">Top</option>');

  topOption.data("menu-item", {id: null, menu: "menu-main-menu"});
  selectHtml.append(topOption);
  selectHtml = buildSelectOptions(selectHtml, menuTree, 0);

  $("#page-form .menu-select").html(selectHtml);
}

function buildSelectOptions(selectHtml, menuItems, level) {
  for (var i = 0; i < menuItems.length; i++) {
    var depthIndicator = "-";

    for (var j = 0; j < level; j++) {
      depthIndicator += "-";
    }

    var option = $('<option value="'+menuItems[i].id+'">'+depthIndicator+" "+menuItems[i].title+'</option>');
    option.data("menu-item", menuItems[i]);
    selectHtml.append(option);

    if (menuItems[i].children.length > 0) {
      selectHtml = buildSelectOptions(selectHtml, menuItems[i].children, level+1);
    }
  }
  return selectHtml;
}
