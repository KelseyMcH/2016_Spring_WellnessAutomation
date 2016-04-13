
	

	//make sure goal is not something baaaaad
	function isNormalInteger(str) {
    	return /^\+?(0|[1-9]\d*)$/.test(str);
	}

	completeFunction = function(data){
	    			window.location.reload();
		};
	//update the goal
	$('#sbmt').click(function(){
		userid = $('#userid').text();
		usergoal = $('#goal').val();

		if(isNormalInteger(usergoal)){
				$.ajaxSetup({
		   			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		   			complete: completeFunction
				});
				$.post('/goal', { id : parseInt(userid), goal : usergoal });
		}
	    	
	});
