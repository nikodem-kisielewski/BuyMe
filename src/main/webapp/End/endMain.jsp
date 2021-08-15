<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

String user = (String)session.getAttribute("user");
rs = st.executeQuery("select distinct a.alert_message from alerts a, users u where u.last_login > a.alert_time and a.username = u.username and a.username = '" + user + "'");

%>

<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Main Page</title>
		<style>
			table {
				border: 1px solid black;
				border-collapse: collapse;	
				width: 50%
			}
			table.center {
  				margin-left: auto; 
  				margin-right: auto;
			}
			th, td {
				text-align: left;
				padding: 15px;
			}	
			tr:nth-child(even) {
				background-color: #f2f2f2;
			}
		</style>
	</head>
	<body>
		<h1>BuyMe Main Page</h1>
		<h2>Welcome <% out.print(session.getAttribute("user").toString());%></h2>
		<div>
			<a href='CreateAuction/itemType.jsp'>Create new listing</a><br/>
			<a href='BrowseAuctions/searchItemType.jsp'>Browse active listings</a><br/>
			<a href='BrowseItems/searchItemType.jsp'>Browse Items</a><br/>
			<a href='searchAuctionHistory.jsp'>Browse Auction Bid Histories</a><br/>
			<a href='searchUserHistory.jsp'>Browse User Histories</a><br/>
			<a href='endCustomerService.jsp'>Customer Service</a><br/>
			<a href='endProfile.jsp'>Profile</a><br/>
			
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
			
			
			
			<a href='../logout.jsp'>Log out</a>
		</div>
	</body>
</html>