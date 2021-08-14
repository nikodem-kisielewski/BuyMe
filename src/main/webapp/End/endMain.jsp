<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Main Page</title>
	</head>
	<body>
		<h1>BuyMe Main Page</h1>
		<h2>Welcome <% out.print(session.getAttribute("user").toString());%></h2>
		<div>
			<a href='CreateAuction/itemType.jsp'>Create new listing</a><br/>
			<a href='BrowseAuctions/searchItemType.jsp'>Browse active listings</a><br/>
			<a href='endCustomerService.jsp'>Customer Service</a><br/>
			<a href='endProfile.jsp'>Profile</a><br/>
			<a href='../logout.jsp'>Log out</a>
		</div>
	</body>
</html>