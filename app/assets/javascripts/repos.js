//

$(function() {
	var getRepoData = function (request, response) {
    	$.getJSON(
            "https://api.github.com/search/repositories?q=" + request.term,
        	function (data) {
        		var repo_list = [];
        		// restrict the result shown
        		var limit = 50;
            	$.each(data.items, function(){
            		
            		repo_list.push(this.name);
            		limit -= 1;
            		if (limit === 0) {
            			return false;
            		}
            	});
            	response(repo_list);
            }
        );
    };
	// Triggered when an item is selected form the manu
	// action: replace the text field's value with the value of the selected item
	var selectRepoItem = function (event, ui) {
	    $("#repo_name").val(ui.item.value);
	    return false;
	};

	$("#repo_name").autocomplete({
	    source: getRepoData,
	    select: selectRepoItem,
	    minLength: 4
	});

	var getOwnerData = function (request, response) {
    	$.getJSON(
            "https://api.github.com/search/users?q=" + request.term,
        	function (data) {
        		var user_list = [];
            	$.each(data.items, function(){
					user_list.push(this.login);	
            	});
            	response(user_list);
            }
        );
    };
	// Triggered when an item is selected form the manu
	// action: replace the text field's value with the value of the selected item
	var selectOwnerItem = function (event, ui) {
	    $("#repo_owner").val(ui.item.value);
	    return false;
	};

	$("#repo_owner").autocomplete({
	    source: getOwnerData,
	    select: selectOwnerItem,
	    minLength: 3
	});
});

