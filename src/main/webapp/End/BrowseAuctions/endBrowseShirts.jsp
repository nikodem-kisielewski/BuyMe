<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Live Auctions</title>
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
</html>

<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

// Get all of the parameters that the user entered
String itemCondition = request.getParameter("condition");
String brand = request.getParameter("brand");
String color = request.getParameter("color");
String material = request.getParameter("material");

String childString = request.getParameter("child");
boolean child;
if (childString.equals("false")) {
	child = false;
} else {
	child = true;
}
String shirtSize = request.getParameter("size");
String gender = request.getParameter("gender");
String maxPrice = request.getParameter("maxPrice");

// Create the strings to fill the query
if (itemCondition.equals("any")) {
	itemCondition = "item_condition";
} else {
	itemCondition = "'"+ itemCondition + "'";
}

if (brand.equals("")) {
	brand = "brand";
} else {
	brand = "'"+ brand + "'";
}

if (color.equals("")) {
	color = "color";
} else {
	color = "'"+ color + "'";
}

if (material.equals("")) {
	material = "material";
} else {
	material = "'" + material + "'";
}

if (shirtSize.equals("any")) {
	shirtSize = "shirt_size";
} else {
	shirtSize = "'" + shirtSize + "'";
}

if (maxPrice.equals("")) {
	maxPrice = "current_price";
}

// Create the query and insert the proper values afterwards
String similarQuery = "select * from auctions a natural join (select * from items i natural join shirts s" + 
	" where i.item_id = s.item_id) s where a.item_id = s.item_id and now() < end_date and item_condition = " + itemCondition +
	" and brand = " + brand + " and color = " + color + " and material = " + material + " and shirt_size = " + shirtSize +
	" and current_price <= " + maxPrice + " and gender = " + "'" + gender + "'";

// Execute the prepared query
rs = st.executeQuery(similarQuery);

	
// If there exists a similar item, update its quantity and create a new auction with that item
if (rs.next()) { %>
	<html>
	<h1>List of shirt auctions</h1>
		<form action="Bidding/bidOnItem.jsp" method="POST">
		<table>
			<tr>
				<td><b>Name</b></td>
				<td><b>Condition</b></td>
				<td><b>Brand</b></td>
				<td><b>Color</b></td>
				<td><b>Material</b></td>
				<td><b>Size</b></td>
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
				<td><input type="hidden" name="auctionID" value="<%= rs.getString("auction_id") %>">
					<input type="submit" value="Bid">
				</td>
			</tr>
			<% while (rs.next()) { %>
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
					<td><input type="hidden" name="auctionID" value="<%= rs.getString("auction_id") %>">
						<input type="submit" value="Bid">
					</td>
				</tr>
			<% } %>
		</table>
		</form>
	</html>
	
<% } else {
	out.println("We could not find an auction with the parameters you specified, please try again." + 
		"<div><a href='endShirtParameters.jsp'>Try again</a></div>");
}
%>