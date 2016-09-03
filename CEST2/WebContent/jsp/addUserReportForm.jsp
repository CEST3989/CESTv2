<%@ include file="/common/taglibs.jsp"%>
<head>
	<meta charset="utf-8">
	<title>New Reports</title>
	<script src="../js/jquery-ui.js"></script>
	<script src="../js/jquery.validationEngine.js" type="text/javascript" charset="utf-8">	</script>
	<script src="../js/jquery.jqGrid.min.js" type="text/javascript"></script>
	<script src="../js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8">	</script>
	<script src="../js/grid.locale-en.js" type="text/javascript"></script>
	
	<script async defer 
					src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAiTyF_dY0BsI4SxBHvHHJvAQwS-bfeWEY"></script>
	
 
	<link href="../css/ui.jqgrid.css" rel="stylesheet" type="text/css"   />
	<link href="../css/validationEngine.jquery.css" rel="stylesheet"  type="text/css"/>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
	
<style>
.lg-center {
 
    margin: 0px auto;
}
.inputtxt , select{
width:50%
}
label {
color : blue;
}
</style>
		
<script type="text/javascript">
jQuery(document).ready(function(){
	
var x = document.getElementById("mapArea");

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
	var latlon = position.coords.latitude + "," + position.coords.longitude;

	document.getElementById("latitude").value = position.coords.latitude;
	document.getElementById("longitude").value = position.coords.longitude;
	
	document.getElementById("mapArea").innerHTML = "your location is: " + latlon;
	disableButton(false);
}

function loadMap(lat, lon) {
  var latlng = new google.maps.LatLng(lat, lon);
  var myOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("mapArea"),myOptions);
	
  var marker = new google.maps.Marker({
    position: latlng, 
    map: map, 
    title:"Your Location"
  }); 

}



function disableButton(flag) {
	if(flag == true){
		$('#save').prop('disabled', true);
	}else{
		$('#save').prop('disabled', false);
	}
}

function showError(error) {
	disableButton(true);
    switch(error.code) {
        case error.PERMISSION_DENIED:
            x.innerHTML = "User denied the request for Geolocation."
            break;
        case error.POSITION_UNAVAILABLE:
            x.innerHTML = "Location information is unavailable."
            break;
        case error.TIMEOUT:
            x.innerHTML = "The request to get user location timed out."
            break;
        case error.UNKNOWN_ERROR:
            x.innerHTML = "An unknown error occurred."
            break;
    }
}
getLocation();
});
</script>
		 
	
</head>
<body>
  

<b><a href="../user/viewUserReports.ext"> Report </a> >>  Add Report </b>
 <hr >
 
<s:if test="hasActionErrors()">
		<div class="errors">
			<s:actionerror/>
		</div>
</s:if>
 
<s:if test="hasFieldErrors()">
		<div class="errors">
			<s:fielderror/>
		</div>
</s:if>
 <s:form action="../user/addUserReport.ext" id="usrForm" onsubmit="return jQuery(this).validationEngine('validate');" method="POST" enctype="multipart/form-data"> 
 <fieldset  > <legend>User Info</legend>
<table  style="padding: 20px; margin: 20px">
	<input type="hidden" name="report.id"/>
	
	<tr>
		<td><label>Unit : </label></td>
		<td> <select  class="validate[required] text-select" id="unit" name="report.unit"><option value="unit1">unit1</option> <option value="unit2">unit2</option>  </select></td>
		<td></td>
		<td><label>Year : </label></td>
		<td> <select  class="validate[required] text-select" id="year" name="report.year"><option value="2016-2015">2016-2015</option> <option value="2015-2014">2015-2014</option>  <option value="2014-2013">2014-2013</option>  </select></td>
		<td></td>
	</tr>
	
	<tr>
		<td> <label>Select File : </label></td>
		<td colspan="2"> <s:file name="reportFile" id="reportFile"/> </td>
		<td colspan="3"><br></td>
	</tr>
	<tr>
		<td><label>Comment : </label></td>
		<td colspan="5"><textarea class="validate[required] text-password inputtxt"  name="report.comment"   style="height:90px;width:400px;" ></textarea></td>
	</tr>
	<tr>
		<td colspan="1"> <input type="hidden" name="latitude" id="latitude" />
		<input type="hidden" name="longitude"  id="longitude"/></td>
		<td colspan="4"><div id="mapArea"></div> </td>
		<td colspan="1"> </td>
	</tr>
	<tr>
		<td colspan="6" align="center">
		<br>
		<input type="submit" class="ui-button ui-widget ui-corner-all"  id="save" onclick="jQuery('#usrForm').submit();"  disabled="true" value="Save3" />
		<input type="reset"  class="ui-button ui-widget ui-corner-all"  id="reset" onclick="jQuery('#usrForm').validationEngine('hide')" value="Reset"></input>			 
		
		</td>
	</tr>
</table>
</fieldset>
  
</s:form>

<script>

$( "#datepicker" ).datepicker({
	
});
$( "#unit" ).selectmenu();
$( "#year" ).selectmenu();
function validate() {
	alert('Succesdsdsdsdsss!');
}
function formSuccess() {
	alert('Success!');
}

function formFailure() {
	alert('Failure!');
}
jQuery(document).ready(function(){
	// binds form submission and fields to the validation engine
	jQuery("#usrForm").validationEngine({
		onFormSuccess:formSuccess,
		onFormFailure:formFailure
		
	});
});

	 
</script>
</body>
