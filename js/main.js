$(function() {

	pushPopListeners();

	$(".search-form").submit(function() {
		var searchParameter = $(this).find('input[type="text"]').val();
		getPages(searchParameter);

		return false;
	});

	
});

