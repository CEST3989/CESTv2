<%@ include file="/common/taglibs.jsp"%>
<head>
	<meta charset="utf-8">
	<title>User List</title>
	
	<script src="../js/jquery-ui.js"></script>
	<script src="../js/jquery.validationEngine.js" type="text/javascript" charset="utf-8">	</script>
	<script src="../js/jquery.jqGrid.min.js" type="text/javascript"></script>
	<script src="../js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8">	</script>
	<script src="../js/grid.locale-en.js" type="text/javascript"></script>

	<!-- <link href="../css/jquery-ui.css" rel="stylesheet" /> -->
	<link href="../css/ui.jqgrid.css" rel="stylesheet" type="text/css"   />
	<link href="../css/validationEngine.jquery.css" rel="stylesheet"  type="text/css"/>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
	
<style>
.lg-center {
 
    margin: 0px auto;
}
 
 
label {
color : blue;
}

input[type="text"] {
    width: 190px;
}
 

</style>
		 
	
</head>
<body>
<a href="../user/login.ext" title="">Back</a></br></br>
	 
 <form action="searchUser.ext" id="usrSrcForm" onsubmit="return jQuery(this).validationEngine('validate');" >
 <fieldset  > <legend>Search Info</legend>
<table class="lg-center" >
	
	<tr>
		<td><label for="name" >Name : </label> </td>
		 <td><input type="text"  class="validate[custom[onlyLetterNumber]] text-input" class="inputtxt" name="userInfo.name" value='${userInfo.name}'  id="name" /></td>
		<td><label for="loginName">Login Name : </label></td>
		 <td><input type="text" class="validate[ custom[onlyLetterNumber]] text-input"  class="inputtxt" name="userInfo.userId" value='${userInfo.userId}' id="loginName" /></td>
		<td><label for="type">Type : </label> </td>
		<td><input type="text" id="type" class="validate[ custom[onlyLetterNumber]] text-input" name="userInfo.type" value='${userInfo.type}' class="inputtxt" /></td>
	</tr>
	 
	<tr>
		<td><label>Department : </label></td>
		<td><select class="selecttxt" id="dept" name="userInfo.param1" value='${userInfo.param1}' ><option>Select</option><option value="A">Department A</option> <option value="B">Department B</option> <option value="C">Department C</option>  </select></td>
		 
		<td><label>Zone : </label></td>
		<td><select class="selecttxt" id="zone" name="userInfo.zone.name" value='${userInfo.zone.name}'><option>Select</option><option value="delhi">Delhi</option> <option value="agra">Agra</option> <option value="noida">Noida</option>  </select></td>
	</tr>
		
	<tr>
		<td colspan="6" align="right">
		 
		<input type="submit" class="ui-button ui-widget ui-corner-all"  id="search" onclick="jQuery('#usrSrcForm').submit();" value="Search" >
		 
		<input type="reset"  class="ui-button ui-widget ui-corner-all"  id="clear" onclick="jQuery('#usrSrcForm').validationEngine('hide')" value="Reset"></input>			 
					 
		</td>
	</tr>
	 
</table>
</fieldset>

</form>
<br />

 
<div class="lg-center" style="width:auto">
	<table id="jqgrid"></table>
	<div id="pjqgrid"></div> 
	
</div>
</br>
</br>
</br>

<div id="dialog-confirm" title="Delete Dialog?" style="display:none;">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:1px 26px 12px 0;"></span>This record will be permanently deleted and cannot be recovered. Are you sure?</p>
</div>
 

 
 

<script>
 
 
$( ".selecttxt" ).selectmenu();
 
  
	var jqgrid_data ;
	
	function loadDynamic(){
		<c:if test="${userInfoList != null}" >
			jqgrid_data = [ 
		   			<c:forEach var="userInfo" items="${userInfoList}">
		   				{
		   					id : "${userInfo.id}",
		   					name : "${userInfo.name}",
		   					loginName : "${userInfo.userId}",
		   					dept : "${userInfo.param1}",
		   					type : "${userInfo.type}",
		   					zone : "${userInfo.zone.name}",
		   					mobile: "${userInfo.mobileNumber}"
		   				},
		   			</c:forEach>
		   			];
		</c:if>
	}
	function gridReload(){
		 
		loadDynamic();
		
		jQuery("#jqgrid")
				.jqGrid(
						{
							data : jqgrid_data,
							datatype : "local",
							height : 'auto',
							colNames : [ 'id', 'Name', 'Login Name', 'Department', 'Type', 'Zone', 'Mobile' ],
							colModel : [ {
								name : 'id',
								index : 'id',
								hidden : true
							},{
								name : 'name',
								index : 'name'
							}, {
								name : 'loginName',
								index : 'loginName'
							}, {
								name : 'dept',
								index : 'dept'
							}, {
								name : 'type',
								index : 'type'
							},{
								name : 'zone',
								index : 'zone'
							} , {
								name : 'mobile',
								index : 'mobile'
							}],
							rowNum : 10,
							rowList : [ 10, 20, 30,40,50 ],
							pager : '#pjqgrid',
							sortname : 'id',
							sortorder : "asc",
							editurl : "JQGridServlet",
							caption : "User Data <div style='float:right;margin-right:25px'><a href='../user/addUserForm.ext' > <span class='ui-icon ui-icon-plusthick'></span>Add   </a><a href='../user/addUserForm.ext' > <span class='ui-icon ui-icon-pencil'></span> Edit</a><a href='javascript:deleteRecord();' > <span class='ui-icon ui-icon-trash'></span>  Delete </a> </div>",
							multiselect : true,
							autowidth : true,
						});

		
	}
$(document).ready(function() {
	gridReload();
});


function deleteRecord(){
	$( "#dialog-confirm" ).dialog({
	      resizable: false,
	      height: "auto",
	      width: 400,
	      modal: true,
	      buttons: {
	        "Delete": function() {
	          		$( this ).dialog( "close" );
	        		var rowid;
	        		rowid = jQuery("#jqgrid").jqGrid('getGridParam','selarrrow');
	        		// alert(rowid);
	        		$.post("deleteUser.ext",
			        {
			          "userInfo.id": rowid
			        },
			        function(data,status){
			            console.log("Data: " + data + "\nStatus: " + status);
			        });
	        		$('#jqgrid').jqGrid('delRowData',rowid);
	        },
	        Cancel: function() {
	          $( this ).dialog( "close" );
	        }
	     }
	 });
}

	 
</script>
</body>
