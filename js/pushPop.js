function onPopAndStart(){
  var url = location.href;
  var pageName = url.substring(url.lastIndexOf("/")+1);
  pageName = pageName || false;

  showPage(pageName);
}

function showPage(pageUrl) {

  if (!pageUrl || pageUrl == "home") {
    pageUrl = "test-page";
  }

  getMenuLinks("menu-main-menu", createMainMenu);

  if (pageUrl == "page-list") {
    getPages();
  } else if (pageUrl == "page-form") {
    $("#page-form .menu-link-fields").hide();
    getMenuLinks("menu-main-menu", createFormMenuSelect);
  } else { 
    getCurrentPage(pageUrl);
    pageUrl = "page";
  }

  $("main .row").children().hide();

  $("main .row #side-bar").show();

  $('section#'+pageUrl).fadeIn(500);

  $(".nav li").removeClass("active");

  $("body").find('a[href="'+pageUrl+'"]').each(function() {
    $(this).parent("li").addClass("active");
  });
}

function pushPopListeners() {
  
  $(document).on("click","a",function(event){

    if ($(this).attr("href").indexOf("://") >=0) {
      return;
    }

    if ($(this).attr("href") && $(this).attr("href") !== "#") {
      goToPage($(this).attr("href"));
    }

    event.preventDefault();
  });

  addEventListener("popstate", onPopAndStart);
  onPopAndStart(); 
}

function goToPage(href) {
  showPage(href);
  history.pushState(null,null,href);
}