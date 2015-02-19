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
