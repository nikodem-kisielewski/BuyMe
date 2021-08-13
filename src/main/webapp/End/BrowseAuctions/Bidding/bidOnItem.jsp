<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
String auctionID = request.getParameter("auctionID");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Bid on item</title>
		<style>
			table {
				border: 1px solid black;
				border-collapse: collapse;	
				width: 100%
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
	<h1>Bidding</h1>
	<div>
		<p>You can place a bid on this item directly. You will be notified if you are outbid or
			if you win this item. Alternatively you can also set up autobidding. Autobidding
			will bid on the item automatically as you get outbid. You can set your bid increment
			and the maximum price you are willing to pay.
		</p>
	</div>
	<div>
		<p> If you do not wish to set up autobidding, please leave the autobid fields blank.<p>
		
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
		Statement st = con.createStatement();
		ResultSet rs;
		
		String thisAuctionID = request.getParameter("auctionID");
		
		// Check which kind of item the user is trying to bid on and display it
		String isShirt = "select * from auctions a natural join (select * from items i natural join shirts s" + 
				" where i.item_id = s.item_id) s where a.auction_id = '" + thisAuctionID + "' and a.item_id = s.item_id";
		rs = st.executeQuery(isShirt);
		
		if (rs.next()) { %>
			<table>
			<tr>
				<td><b>Name</b></td>
				<td><b>Condition</b></td>
				<td><b>Brand</b></td>
				<td><b>Color</b></td>
				<td><b>Material</b></td>
				<!-- <td><b>Size</b></td> -->
				<td><b>Gender</b></td>
				<td><b>Current Price</b></td>
			</tr>
			<tr>
				<td><%= rs.getString("name") %></td>
					
				<!-- Make text user friendly for item condition -->
				<% if (rs.getString("item_condition").equals("brandnew")) {
					%> <td>Brand New</td> <% 
				} else if (rs.getString("item_condition").equals("good")) {
					%> <td>Good</td> <%
				} else {
					%> <td>Fair</td> <%
				} %>
					
				<td><%= rs.getString("brand") %></td>
				<td><%= rs.getString("color") %></td>
				<td><%= rs.getString("material") %></td>
				<td><%= rs.getString("shirt_size") %></td>
				<td><%= rs.getString("gender") %></td>
				<td>$<%= rs.getString("current_price") %></td>
			</tr>
			</table>
		<% }
		
		String isPants = "select * from auctions a natural join (select * from items i natural join pants p" + 
			" where i.item_id = p.item_id) p where a.auction_id = '" + thisAuctionID + "' and a.item_id = p.item_id";
		rs = st.executeQuery(isPants);
		
		if (rs.next()) { %>
			<table>
			<tr>
				<td><b>Name</b></td>
				<td><b>Condition</b></td>
				<td><b>Brand</b></td>
				<td><b>Color</b></td>
				<td><b>Material</b></td>
				<td><b>Size</b></td>
				<td><b>Pants Type</b></td>
				<td><b>Pants Style</b></td>
				<td><b>Gender</b></td>
				<td><b>Current Price</b></td>
			</tr>
			<tr>
				<td><%= rs.getString("name") %></td>
				
					<!-- Make text user friendly for item condition -->
					<% if (rs.getString("item_condition").equals("brandnew")) {
						%> <td>Brand New</td> <% 
					} else if (rs.getString("item_condition").equals("good")) {
						%> <td>Good</td> <%
					} else {
						%> <td>Fair</td> <%
					} %>
					
				<td><%= rs.getString("brand") %></td>
				<td><%= rs.getString("color") %></td>
				<td><%= rs.getString("material") %></td>
				<td><%= rs.getString("pants_size") %></td>
				<td><%= rs.getString("pants_type") %></td>
				<td><%= rs.getString("style") %></td>
				<td><%= rs.getString("gender") %></td>
				<td>$<%= rs.getString("current_price") %></td>
			</tr>
		</table>
		<% }
		
		String isShoes = "select * from auctions a natural join (select * from items i natural join footwear s" + 
			" where i.item_id = s.item_id) s where a.auction_id = '" + thisAuctionID + "' and a.item_id = s.item_id";
		rs = st.executeQuery(isShoes);
		
		if (rs.next()) { %>
			<table>
			<tr>
				<td><b>Name</b></td>
				<td><b>Condition</b></td>
				<td><b>Brand</b></td>
				<td><b>Color</b></td>
				<td><b>Material</b></td>
				<td><b>Size</b></td>
				<td><b>Width</b>
				<td><b>Securing Method</b></td>
				<td><b>Purpose</b></td>
				<td><b>Gender</b></td>
				<td><b>Current Price</b></td>
			</tr>
			<tr>
				<td><%= rs.getString("name") %></td>
				
					<!-- Make text user friendly for item condition -->
					<% if (rs.getString("item_condition").equals("brandnew")) {
						%> <td>Brand New</td> <% 
					} else if (rs.getString("item_condition").equals("good")) {
						%> <td>Good</td> <%
					} else {
						%> <td>Fair</td> <%
					} %>
					
				<td><%= rs.getString("brand") %></td>
				<td><%= rs.getString("color") %></td>
				<td><%= rs.getString("material") %></td>
				<td><%= rs.getString("shoe_size") %></td>
				<td><%= rs.getString("width") %></td>
				<td><%= rs.getString("securing_method") %></td>
				<td><%= rs.getString("purpose") %></td>
				<td><%= rs.getString("gender") %></td>
				<td>$<%= rs.getString("current_price") %></td>
			</tr>
			</table>
		<% } %>
		
		<h2>Normal bid</h2>
		<p>This will submit a normal bid. You will be alerted if you are outbid.</p>
		<form action="checkRegBid.jsp" method="POST">
			<input type="number" step="0.01" name="bidAmount"><br>
			<input type="hidden" name="auctionID" value="auctionID">
			<input type="submit" value="Submit Bid">
		</form>
		<h2>Autobid</h2>
		<p>Autobids are like normal bids that are automated for you. If you are outbid on an auction, the autobid system will automatically place a new bid for you.
		This system will continue to bid for you until the current bid on the item exceeds the maximum price of your desired maximum bid.<p>
		<form action="checkAutoBid.jsp" method="POST">
			<p>This field determines how much your bids will increment with each autobid made on the item.</p>
			Bid increment: <input type="number" step="0.01" name="bidIncrement"><br>
			<p>This field determines the maximum price the autobid will bid on an item.</p>
			Maximum price: <input type="number" step="0.01" name="maxPrice"><br>
			<input type="hidden" name="auctionID" value="<%= thisAuctionID %>">
			<input type="submit" value="Create Autobid">
		</form>
	</div>
</html>










