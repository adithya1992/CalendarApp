$(document).ready(function() {
	for(var i=0; i<=12; i++) {
		var txt = moment({hour: i + 9}).format('h:mm A');
		txt = txt.split(' ');
		$('#labels').append('<p class="label"><span class="bold">' + txt[0] + '</span> ' + txt[1] + '</p>');
		if (i < 12) {
			txt = moment({hour: i + 9, minute: 30}).format('h:mm');
			$('#labels').append('<p class="label">' + txt + '</p>');	
		}
	};
	var c = document.getElementById("calendar");
	var ctx = c.getContext("2d");

	var allotments = [
      {"id": 1, "start": 60, "end": 120},
      {"id": 2, "start": 100, "end": 240},
      {"id": 3, "start": 110, "end": 270},
      {"id": 4, "start": 250, "end": 300},
      {"id": 5, "start": 350, "end": 400},
      {"id": 6, "start": 400, "end": 800}
  ];
	$.ajax({
		url: '/api/events', 
		type: 'POST',
		data: JSON.stringify({allotments: allotments}),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json'
	})
		.done(function(data) {
			data.forEach(function(e, i) {
				ctx.fillStyle = "gray";
				ctx.fillRect(e.left, e.top, e.width, e.height);
				
				ctx.fillStyle = "white";
				ctx.fillRect(e.left + 2, e.top + 2, e.width - 4, e.height - 4);
				
				ctx.fillStyle = "#385D8D";
				ctx.fillRect(e.left, e.top, 10, e.height);
				
				ctx.textBaseline = "top";
				ctx.font = "17px Arial";
				ctx.fillText("Sample Item", e.left + 30, e.top + 10);

				ctx.font = "12px Arial";
				ctx.fillStyle = "gray";
				ctx.fillText("Sample Location", e.left + 30, e.top + 30);
			});
		});
});