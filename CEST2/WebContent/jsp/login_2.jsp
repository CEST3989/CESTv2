<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!doctype html>
<html lang="us">
<head>
	<meta charset="utf-8">
	<title>jQuery UI </title>
	<script src="../js/jquery.js"></script>
	<script src="../js/jquery-ui.js"></script>
	<link href="../css/jquery-ui.css" rel="stylesheet">
	<link rel="stylesheet" href="../css/validationEngine.jquery.css" type="text/css"/>
 
	<script src="../js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8">
	</script>
	<script src="../js/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
	</script>

<style>
.lg-center {
    width: 28%;
    margin: 120px auto;
}

</style>




</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="lg-center" >
 

<!-- Accordion -->
<div id="accordion" style="width:361px">
	<h3>Login</h3>
	<div>
			<form action="" id="lgFm" onsubmit="return jQuery(this).validationEngine('validate');">
			<table border="0" >
				<tr>
					<td><label>UserName : </label></td>
					<td> <input type="text" class="validate[required] text-input" name="username" /></td>
				</tr>
				<tr>
					<td><label>Password :</label> </td>
					<td>
						<input type="password" class="validate[required] text-input" name="password" />
					</td>
				</tr>
				<tr >
					<td colspan="2"> 
						<button type="submit" id="button" onclick="jQuery('#lgFm').submit();" style="margin: 11px 0px 0px 125px;">Login</button>
					
					</td>
				</tr>
			</table>
			
			
			
			
				
			</form>
	</div>
	
</div>

</div>

<script>

$( "#accordion" ).accordion();
$( "#button" ).button();
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
	jQuery("#lgFm").validationEngine({
		onFormSuccess:formSuccess,
		onFormFailure:formFailure
		
	});
});
</script>
</body>
</html>
