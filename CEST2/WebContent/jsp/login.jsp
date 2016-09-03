<%@ include file="/common/taglibs.jsp"%>
<head>
	
 	 <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
	<script src="../js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8">
	</script>
	<script src="../js/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
	</script>
 	 
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/start/jquery-ui.css">
	
	<link rel="stylesheet" href="../css/validationEngine.jquery.css" type="text/css"/>
 

<style>
.lg-center {
    width: 28%;
    margin: 50px 258px;
}
.ui-accordion-content {
	height : 106.6px ! important;
}
.errors{
	color : red;
}
</style>

</head>

<body>
<div class="lg-center" >
 

<!-- Accordion -->
<div id="accordion" style="width:361px;">
	
	<h3>Login</h3>
	<div>
			<form action="../user/login.ext" id="lgFm" onsubmit="return jQuery(this).validationEngine('validate');">
			<s:if test="hasActionErrors()">
   				<div class="errors">
    				<s:actionerror/>
   				</div>
			</s:if>
			
			<table border="0" >
				<tr>
					<td><label>UserId : </label></td>
					<td> <input type="text" class="validate[required] text-input" name="userInfo.userId" /></td>
				</tr>
				<tr>
					<td><label>Password :</label> </td>
					<td>
						<input type="password" class="validate[required] text-input" name="userInfo.password" />
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
	$( "#accordion" ).accordion();
	$( "#button" ).button();
});
</script>

</body>