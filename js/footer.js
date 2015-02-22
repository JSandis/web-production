function showFooterContent(data) {
  $("#footer-div").html("");
  var pageHtml = $('<div class="footer-content"/>');
  pageHtml.append("<p>&copy;"+data["footer_data"][0]["description"]+"</p>");
  pageHtml.append("<p>"+data["footer_data"][0]["address"]+"</p>");
  pageHtml.append("<p>"+data["footer_data"][0]["phone"]+"</p>");
  pageHtml.append("<p>"+data["footer_data"][0]["user_name"]+"</p>");
  $("#footer-div").html(pageHtml);
}