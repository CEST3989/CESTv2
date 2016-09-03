<%@ include file="/common/taglibs.jsp"%>
<head>

<script src="../js/jquery-ui.js"></script>
	<link href="../css/jquery-ui.css" rel="stylesheet" />
 	
	 <script>
  $( function() {
    $( "#menu" ).menu();
  } );
  </script>
  <style>
  .ui-menu { width: 150px; }
  </style>
</head>

<body>
 
	
	<!-- <ul id="menu">
  <li class="ui-state-disabled"><div>Toys (n/a)</div></li>
  <li><div>Books</div></li>
  <li><div>Clothing</div></li>
  <li><div>Electronics</div>
    <ul>
      <li class="ui-state-disabled"><div>Home Entertainment</div></li>
      <li><div>Car Hifi</div></li>
      <li><div>Utilities</div></li>
    </ul>
  </li>
  <li><div>Movies</div></li>
  <li><div>Music</div>
    <ul>
      <li><div>Rock</div>
        <ul>
          <li><div>Alternative</div></li>
          <li><div>Classic</div></li>
        </ul>
      </li>
      <li><div>Jazz</div>
        <ul>
          <li><div>Freejazz</div></li>
          <li><div>Big Band</div></li>
          <li><div>Modern</div></li>
        </ul>
      </li>
      <li><div>Pop</div></li>
    </ul>
  </li>
  <li class="ui-state-disabled"><div>Specials (n/a)</div></li>
</ul>
	 -->
	
<div style="padding-bottom 10px">
	 
<b>User: <%=session.getAttribute("username") %> </b>
	</br>
	<c:if test="${role == 'A'}">
				<a href="../user/viewUsers.ext" title="list of all users">List of User </a></br></br>
				<a href="../user/viewOnMap.ext" title="view the last location of users">View On Map </a></br></br></br></br>						
	</c:if>
	<c:if test="${role == 'U'}">
				<a href="../user/viewUserReports.ext" title="list of all My Reports">My Reports </a></br></br>
				<a href="../user/addUserReportForm.ext" title="Add a new reports">New Report</a>	</br></br>
	</c:if>
	<a href="../user/viewUsers.ext" title="" class="dialogify">Change Password</a>	</br></br>
	<a href="../jsp/logout.jsp" title="Logout">Logout</a></br></br></br></br>
	</div>
	
	<div id="dialog">
	change password for
	</div>
<script>
		/*
		 * jQuery UI Dialog: Load Content via AJAX
		 * http://salman-w.blogspot.com/2013/05/jquery-ui-dialog-examples.html
		 */
		 jQuery(document).ready(function() {
			$("#dialog").dialog({
				autoOpen: false,
				modal: true,
				width: 600,
				height: 300,
				buttons: {
					"Dismiss": function() {
						$(this).dialog("close");
					}
				}
			});
			
			$(".dialogify").on("click", function(e) {
				alert('al');
				e.preventDefault();
				$("#dialog").html("");
				$("#dialog").dialog("option", "title", "Loading...").dialog("open");
				$("#dialog").load(this.href, function() {
					$(this).dialog("option", "title", "Change Password");
				});
			});
			
			
			
		});
	</script>
</body>