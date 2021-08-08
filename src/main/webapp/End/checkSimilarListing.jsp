<%@ page import ="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Similar Listings</title>
	</head>
<%

// Get all of the parameters that the user entered
String itemID = request.getParameter("item_id");
String itemName = request.getParameter("name");
String itemCondition = request.getParameter("condition");
String manLoc = request.getParameter("loc");
String brand = request.getParameter("brand");
String color = request.getParameter("color");
String material = request.getParameter("material");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

Statement st = con.createStatement();
ResultSet rs;

// Create the query and insert the proper values afterwards
String query = "select * from items where item_condition = ? and manufacturing_location = ? and brand = ?" +
			"and color = ? and material = ?";

// Fill the prepared statement with the proper values
PreparedStatement ps = con.prepareStatement(query);
ps.setString(1, itemCondition);
ps.setString(2, manLoc);
ps.setString(3, brand);
ps.setString(4, color);
ps.setString(5, material);

// Execute the prepared query
rs = ps.executeQuery();

%>

<!-- Make a table to show similar items in the database -->
	<body>
		<table>
			<tr>
				<td><b>Item ID</b></td>
				<td><b>Name</b></td>
				<td><b>Condition</b></td>
				<td><b>Manufacturing Location</b></td>
				<td><b>Brand</b></td>
				<td><b>Color</b></td>
				<td><b>Material</b></td>
			</tr>
			<% while (rs.next()) { %>
				<tr>
					<td> <%= rs.getString("item_id") %></td>
					<td> <%= rs.getString("name") %></td>
					<td> <%= rs.getString("item_condition") %></td>
					<td> <%= rs.getString("manufacturing_location") %></td>
					<td> <%= rs.getString("brand") %></td>
					<td> <%= rs.getString("color") %></td>
					<td> <%= rs.getString("material") %></td>
				</tr>
			<% } %>
		</table>
		
	</body>
</html>