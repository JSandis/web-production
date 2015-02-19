function showPageContent(data) {
  $("#page").html("");
  var pageHtml = $('<article class="page-list"/>');
  pageHtml.append("<h2>"+data["page_data"][0]["title"]+"</h2>");
  pageHtml.append(data["page_data"][0]["body"]);
  pageHtml.append("<em>Created on: "+data["page_data"][0]["created"]+", by: "+data["author_data"][0]["author"]+"</em>");
  $("#page").html(pageHtml);
}

function listPages(data) {
  $("#page-list table tr").not(".table-heads").remove();
  for (var i = 0; i < data.length; i++) {
    var tableRow = $("<tr/>");
    tableRow.append('<td><span class="badge">'+data[i].id+"</span></td>");
    tableRow.append('<td><strong>'+data[i].title+"</strong></td>");
    tableRow.append('<td>'+data[i].author+"</td>");
    tableRow.append('<td>'+data[i].created+"</td>");
    tableRow.data("page", data[i]);

    var adminButtons = $('<td/>');
    adminButtons.append('<div class="btn-group btn-group-xs"/>');
    adminButtons.find(".btn-group").append('<button type="button" class="btn btn-default trashBtn" title="Trash"><span class="glyphicon glyphicon-trash"></span></button>');
    tableRow.append(adminButtons);

    $("#page-list table").append(tableRow);
  }
}