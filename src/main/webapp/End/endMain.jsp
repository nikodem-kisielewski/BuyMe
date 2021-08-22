<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs, rs2;

String user = (String)session.getAttribute("user");
rs = st.executeQuery("select a.alert_message from alerts a where a.username = '" + user + "'");
rs2 = st2.executeQuery("select name, current_price, end_date from auctions natural join items "
	+ "where end_date > now() and seller = '" + user + "'");

%>

<!DOCTYPE html>
<html>
	<head>
	<link rel='stylesheet' href='../CSS/main.css'>
	<link rel='stylesheet' href='../CSS/navbar.css'>
		<title>BuyMe Main Page</title>
	</head>
	<body>
		<div class = 'navbar'>
			<a href='endMain.jsp' class='active'>Home</a>
			<div class = 'dropdown'>
				<button class='dropbtn'>Create a new listing</button>
					<div class='dropdown-content'>
						<a href='CreateAuction/footwearListing.jsp'>Footwear</a>
						<a href='CreateAuction/pantsListing.jsp'>Pants</a>
						<a href='CreateAuction/shirtListing.jsp'>Shirts</a>
					</div>
			</div>
			<div class='dropdown'>
				<button class='dropbtn'>Browse active listings</button>
				<div class='dropdown-content'>
					<a href='BrowseAuctions/endFootwearParameters.jsp'>Footwear</a>
					<a href='BrowseAuctions/endPantsParameters.jsp'>Pants</a>
					<a href='BrowseAuctions/endShirtParameters.jsp'>Shirts</a>
				</div>
			</div>
			<div class='dropdown'>
				<button class='dropbtn'>Browse Items</button>
				<div class='dropdown-content'>
					<a href='BrowseItems/endFootwearParameters.jsp'>Footwear</a>
					<a href='BrowseItems/endPantsParameters.jsp'>Pants</a>
					<a href='BrowseItems/endShirtParameters.jsp'>Shirts</a>
				</div>
			</div>
			<a href='BidHistory/searchAuctionHistory.jsp'>Browse Auction Bid Histories</a>
			<a href='UserHistory/searchUserHistory.jsp'>Browse User Histories</a>
			<a href='CustService/endCustomerService.jsp'>Customer Service</a>
			<a href='Profile/endProfile.jsp'>Profile</a>
			<a href='../logout.jsp' style='float:right'>Log out</a>
		</div>
		<h1>BuyMe Main Page</h1>
		<h2>Welcome, <% out.print(session.getAttribute("user").toString());%></h2>
		<div class='center-collapse'>
			<button class='collapsible'>Your Alerts</button>
			<div class='collapsible-content'>
			<% if (!rs.isBeforeFirst() ) { %>
				<p>You have no alerts at this time.</p>
			<% } else { %>
				<table>
					<% while (rs.next()) { %>
					<tr>
						<td><%= rs.getString("alert_message") %></td>
					</tr>
					<% } %>
				</table>
			<% } %>
			</div>
			<button class='collapsible' class='text-center'>Your Auctions</button>
			<div class='collapsible-content'>
			<% if (!rs2.isBeforeFirst() ) { %>
				<p>You currently have no live auctions.</p>
			<% } else { %>
				<table>
					<tr>
						<th>Item</th>
						<th>Current Bid</th>
						<th>End Date</th>
					<tr>
					<% while (rs2.next()) { %>
					<tr>
						<td><%= rs2.getString("name") %></td>
						<td>$<%= rs2.getString("current_price") %></td>
						<td><%= rs2.getString("end_date") %></td>
					</tr>
					<% } %>
				</table>
			<% } %>
			</div>
		</div>
		<script>
		var coll = document.getElementsByClassName("collapsible");
		var i;

		for (i = 0; i < coll.length; i++) {
		  coll[i].addEventListener("click", function() {
		    var content = this.nextElementSibling;
		    if (content.style.maxHeight){
		      content.style.maxHeight = null;
		    } else {
		      content.style.maxHeight = content.scrollHeight + "px";
		    } 
		  });
		}
		</script>
	</body>
</html>