$(function() {

	pushPopListeners();

	$(".search-form").submit(function() {
		var searchParameter = $(this).find('input[type="text"]').val();
		getPages(searchParameter);

		return false;
	});

	$('#page-form .page-url-group input[type=checkbox]').click(function() {
		$("#page-url").attr("disabled", !$(this).is(":checked"));
		if (!$(this).is(":checked")) {
			$('#page-url').val(generateMachineName($("#page-title").val()));
		}
	});

	$("#page-title").keyup(function() {
		if (!$('#page-form .page-url-group input[type=checkbox]').is(":checked")) {
			$('#page-url').val(generateMachineName($(this).val()));
		}
	});

	$("#page-url").blur(function() {
		$(this).val(generateMachineName($(this).val()));
	});

	$('.add-parent-menu input[type="checkbox"]').click(function() {
		if ($(this).is(":checked")) {
			$("#page-form .menu-link-fields").fadeIn(500);
		} else {
			$("#page-form .menu-link-fields").fadeOut(500);
		}

		$(".add-parent-menu #menu-title").attr("required", $(this).is(":checked"));
	});

	$("#page-form form").submit(function() {
		var pageFormData = {
			":title" : $(this).find("#page-title").val(),
			":body" : $(this).find("#page-body").val(),
			":path" : $(this).find("#page-url").val()
		};

    	if ($('.add-parent-menu input[type="checkbox"]').is(":checked")) {
      		pageFormData.menuData = {};
      		pageFormData.menuData["parent"] = $('.add-parent-menu select').find(":selected").data("menu-item");
      		pageFormData.menuData["title"] = $('.add-parent-menu #menu-link-title').val();
      		pageFormData.menuData["weight"] = $('.add-parent-menu #menu-link-weight').val();
  		}

    	saveNewPage(pageFormData);
    	this.reset();
    	return false;
	});
});

function generateMachineName(inputText) {
	inputText = inputText.replace(/\W/g, ' ');
	inputText = inputText.trim();

	while (inputText.indexOf(' ') >= 0) {
		inputText = inputText.replace(" ", "-");
	}

	while (inputText.indexOf('--') >= 0) {
		inputText = inputText.replace("--", "-");
	}

	return inputText.toLowerCase();
}