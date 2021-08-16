<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

String user = (String)session.getAttribute("user");
rs = st.executeQuery("select a.alert_message from alerts a where a.username = '" + user + "'");

%>

<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" href="../stylesheet.css">
		<title>BuyMe Main Page</title>
	</head>
	<body>
		<div class = 'navbar'>
			<div class = 'dropdown'>
				<button class='dropbtn'>Create a new listing</button>
				<div class='dropdown-content'>
					<a href='CreateAuction/Footwear/footwearListing.jsp'>Footwear</a>
					<a href='CreateAuction/Pants/pantsListing.jsp'>Pants</a>
					<a href='CreateAuction/Shirts/shirtsListing.jsp'>Shirts</a>
				</div>
			</div>
			<div>
				<button class='dropbtn'>Browse active listings</button>
				<div class='dropdown-content'>
					<a href='BrowseAuctions/endFootwearParameters.jsp'>Footwear</a>
					<a href='BrowseAuctions/Pants/endPantsParameters.jsp'>Pants</a>
					<a href='BrowseAuction/Shirts/shirtsListing.jsp'>Shirts</a>
				</div>
			</div>
			<a href='BrowseAuctions/searchItemType.jsp'>Browse active listings</a>
			<a href='BrowseItems/searchItemType.jsp'>Browse Items</a>
			<a href='BidHistory/searchAuctionHistory.jsp'>Browse Auction Bid Histories</a>
			<a href='UserHistory/searchUserHistory.jsp'>Browse User Histories</a>
			<a href='CustService/endCustomerService.jsp'>Customer Service</a>
			<a href='Profile/endProfile.jsp'>Profile</a>
			<a href='../logout.jsp' style='float:right'>Log out</a>
		</div>
		<h1>BuyMe Main Page</h1>
		<h2>Welcome, <% out.print(session.getAttribute("user").toString());%></h2>
		<div>
		<table class="center">
			<tr>
				<td><b>Alerts</b></td>
			</tr>
			<% while (rs.next()) { %>
			<tr>
				<td><%= rs.getString("alert_message") %></td>
			</tr>
			<% } %>
		</table>
		</div>
	</body>
</html>