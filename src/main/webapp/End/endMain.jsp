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
		<div>
		<ul>
			<li><a href='CreateAuction/itemType.jsp' class='dropdown'>Create new listing</a></li>
			<li><a href='BrowseAuctions/searchItemType.jsp'>Browse active listings</a></li>
			<li><a href='BrowseItems/searchItemType.jsp'>Browse Items</a></li>
			<li><a href='BidHistory/searchAuctionHistory.jsp'>Browse Auction Bid Histories</a></li>
			<li><a href='UserHistory/searchUserHistory.jsp'>Browse User Histories</a></li>
			<li><a href='CustService/endCustomerService.jsp'>Customer Service</a></li>
			<li><a href='Profile/endProfile.jsp'>Profile</a></li>
			<li style='float:right'><a href='../logout.jsp'>Log out</a></li>
		</ul>
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