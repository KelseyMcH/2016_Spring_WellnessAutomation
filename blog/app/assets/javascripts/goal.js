
	
	completeFunction = function(data){
	    			window.location.reload();
		};
	//update the goal
	$('#sbmt').click(function(){
		userid = $('#userid').text();
		usergoal = $('#goal').val();
		$.ajaxSetup({
   			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
   			complete: completeFunction
});
		$.post('/goal', { id : parseInt(userid), goal : usergoal });
	    	
	});
