<%@ include file="/common/taglibs.jsp"%>
	<script type="text/javascript">
	function initMap() {

		var broadway = {
			info: '<strong>sanjay</strong><br>\
						Janta travels<br> 13-06-2016 12:50<br>\
						<a href="#">Get Report</a>',
			lat: 41.976816,
			long: -87.659916
		};

		var belmont = {
			info: '<strong>saurav</strong><br>\
						1025 W Belmont Ave<br> Chicago, IL 60657<br>\
						<a href="#">Get Report</a>',
			lat: 41.939670,
			long: -87.655167
		};

		var sheridan = {
			info: '<strong>arvind</strong><br>\r\
						6600 N Sheridan Rd<br> Chicago, IL 60626<br>\
						<a href="#">Get Report</a>',
			lat: 42.002707,
			long: -87.661236
		};

		var locations = [
	      [broadway.info, broadway.lat, broadway.long, 0],
	      [belmont.info, belmont.lat, belmont.long, 1],
	      [sheridan.info, sheridan.lat, sheridan.long, 2],
	    ];

		var map = new google.maps.Map(document.getElementById('map'), {
			zoom: 13,
			center: new google.maps.LatLng(41.976816, -87.659916),
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});

		var infowindow = new google.maps.InfoWindow({});

		var marker, i;

		for (i = 0; i < locations.length; i++) {
			marker = new google.maps.Marker({
				position: new google.maps.LatLng(locations[i][1], locations[i][2]),
				map: map
			});

			google.maps.event.addListener(marker, 'click', (function (marker, i) {
				return function () {
					infowindow.setContent(locations[i][0]);
					infowindow.open(map, marker);
				}
			})(marker, i));


			google.maps.event.addListener(marker, 'mouseover', (function (marker, i) {
				return function () {
					infowindow.setContent(locations[i][0]);
					infowindow.open(map, marker);
				}
			})(marker, i));
		}
	}

	 
		   
		    
		 
	
	</script>

<body>
<a href="../user/login.ext" title="">Back</a></br></br>
	<div id="map" style="width: 800px; height: 500px"></div>

	<script async defer 
					src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAiTyF_dY0BsI4SxBHvHHJvAQwS-bfeWEY&callback=initMap"></script>
</body>