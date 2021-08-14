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

String shoeSize = request.getParameter("shoeSize");
if (shoeSize.equals("")) {
	shoeSize = "shoe_size";
} else {
	shoeSize = "'" + shoeSize + "'";
}

String shoeWidth = request.getParameter("width");
if (shoeWidth.equals("any")) {
	shoeWidth = "width";
} else {
	shoeWidth = "'" + shoeWidth + "'";
}

Boolean insole;
String insoleString = request.getParameter("insole");
if (insoleString.equals("False")) {
	insole = false;
} else {
	insole = true;
}

String method = request.getParameter("method");
if (method.equals("")) {
	method = "securing_method";
} else {
	method = "'" + method + "'";
}

String purpose = request.getParameter("purpose");
if (purpose.equals("")) {
	purpose = "purpose";
} else {
	purpose = "'" + purpose + "'";
}

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

if (maxPrice.equals("")) {
	maxPrice = "current_price";
}

// Create the query and insert the proper values afterwards
String similarQuery = "select * from auctions a natural join (select * from items i natural join footwear f" + 
	" where i.item_id = f.item_id) f where a.item_id = f.item_id and now() < end_date and item_condition = " + itemCondition +
	" and brand = " + brand + " and color = " + color + " and material = " + material + " and shoe_size = " + shoeSize +
	" and current_price <= " + maxPrice + " and gender = " + "'" + gender + "' and shoe_size = " + shoeSize +
	" and width = " + shoeWidth + " and in_sole = " + insole + " and securing_method = " + method + " and purpose = " + purpose;

// Execute the prepared query
rs = st.executeQuery(similarQuery);

	
// If there exists a similar item, update its quantity and create a new auction with that item
if (rs.next()) { %>
	<h1>List of footwear auctions</h1>
		<form action="Bidding/bidOnItem.jsp" method="POST">
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
					<td><%= rs.getString("shoe_size") %></td>
					<td><%= rs.getString("width") %></td>
					<td><%= rs.getString("securing_method") %></td>
					<td><%= rs.getString("purpose") %></td>
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
		"<div><a href='endFootwearParameters.jsp'>Try again</a></div>");
}
%>