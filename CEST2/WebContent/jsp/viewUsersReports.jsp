<%@ include file="/common/taglibs.jsp"%>
<head>
	<meta charset="utf-8">
	<title>My Reports</title>
	
	<script src="../js/jquery-ui.js"></script>
	<script src="../js/jquery.validationEngine.js" type="text/javascript" charset="utf-8">	</script>
	<script src="../js/jquery.jqGrid.min.js" type="text/javascript"></script>
	<script src="../js/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8">	</script>
	<script src="../js/grid.locale-en.js" type="text/javascript"></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
	<link href="../css/ui.jqgrid.css" rel="stylesheet" type="text/css"   />
	<link href="../css/validationEngine.jquery.css" rel="stylesheet"  type="text/css"/>

	<script>
	$( function() {
	    $( "#toDate" ).datepicker({
	      showOn: "button",
	      buttonImage: "../images/calendar.gif",
	      buttonImageOnly: true,
	      buttonText: "Select date"
	    });
	    $( "#fromDate" ).datepicker({
	        showOn: "button",
	        buttonImage: "../images/calendar.gif",
	        buttonImageOnly: true,
	        buttonText: "Select date"
	      });
	  } );
	</script>
<style>
.lg-center {
 
    margin: 0px auto;
}
 
img{
margin: 0 0 -2px 6px;
}
label {
color : blue;
}
.ui-datepicker{z-index: 200 !important};
 
</style>
		 
	
</head>
<body>
<a href="../user/login.ext" title="">Back</a></br></br>
	 
 <form action="" id="usrSrcForm" onsubmit="return jQuery(this).validationEngine('validate');" >
 <fieldset  > <legend>Search Info</legend>
<table class="lg-center"  width="80%" height="auto">
	
	<tr>
		<td><label>From Date : </label></td>
		<td> <input type="text"  id="toDate" class="validate[required] text-date inputtxt" name="toDate" />
		</td>
		<td><label>To Date : </label></td>
		<td> <input type="text"  id="fromDate" class="validate[required] text-date inputtxt"  name="fromDate" /> </td>
	</tr>
<tr>
		<td colspan="6" align="right">
		 
		<input type="submit" class="ui-button ui-widget ui-corner-all"  id="search" onclick="jQuery('#usrSrcForm').submit();gridReload();"  value="Search" />
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

  


var jqgrid_data = [ {
						id : "1",
						name : "Arpit Kumar",
						loginName : "arpit-u",
						dept : "Department A",
						type : "Regular",
						zone : "Delhi",
						mobile: "8285480432"
					}, {
						id : "2",
						name : "Sanjay Kumar",
						loginName : "sanjay-e",
						dept : "Department B",
						type : "Regular BAC",
						zone : "Noida",
						mobile: "3434343433444"
					} ];

function loadDynamic(){
	<c:if test="${userInfoList != null}" >
		jqgrid_data = [ 
	   			<c:forEach var="userInfo" items="${userInfoList}">
	   				{
	   					id : "${userInfo.id}",
	   					name : "${userInfo.userId}",
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
	        		$.post("demo_test_post.asp",
			        {
			          userId: rowid
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