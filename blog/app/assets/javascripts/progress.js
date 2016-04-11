
	//fetch user data
	userId = parseInt($('#userid').text());
	
	$.get('/useractions', { id : userId}, 
	    function(data){

	        //data is the actions to build the  graph from
	        console.log(data);

	        something = new Map();

	        //append
	        svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    		svg.setAttribute('width', '110');
    		svg.setAttribute('height', '500');


    		//map data into each attribute
			$.each(data, function(item) {

				var count = 0;
				if(something.has(data[item].activity_id)){
					count = something.get(data[item].activity_id);
				}
				count += 1;
				something.set(data[item].activity_id, count);
				console.log(data[item].activity_id);
			});

			var x = 0;
			//for each attribute create a legend and a line
			something.forEach(function(i,val){
				console.log("hello");
				var aLine = document.createElementNS('http://www.w3.org/2000/svg', 'line');
    			aLine.setAttribute('x1', x);
    			aLine.setAttribute('y1', 0);
   				aLine.setAttribute('x2', (x+val*10));
    			aLine.setAttribute('y2', 0);
    			aLine.setAttribute('style', 'stroke:blue; stroke-width: 10;');
    			svg.appendChild(aLine);

    			x = x+ val*10;
			});
	  	    $('.graphhere').append(svg);
		}, "json" );