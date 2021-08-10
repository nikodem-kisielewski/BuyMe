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
	<style>
		table, th, td {
			border: 1px solid black;
			border-collapse: collapse;
			padding: 10px;
		}
	</style>
<%

// Get all of the parameters that the user entered
String itemCondition = request.getParameter("condition");
String manLoc = request.getParameter("loc");
String brand = request.getParameter("brand");
String color = request.getParameter("color");
String material = request.getParameter("material");
String child = request.getParameter("child");
String shirt_size = request.getParameter("size");
String gender = request.getParameter("gender");

System.out.println(child);

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

// Create the query and insert the proper values afterwards
String query = "select * from items natural left join shirts where item_condition = ? and manufacturing_location = ? and brand = ?" +
			"and color = ? and material = ? and child = ? and shirt_size= ? and gender = ?";

// Fill the prepared statement with the proper values
PreparedStatement ps = con.prepareStatement(query);
ps.setString(1, itemCondition);
ps.setString(2, manLoc);
ps.setString(3, brand);
ps.setString(4, color);
ps.setString(5, material);
ps.setString(6, child);
ps.setString(7, shirt_size);
ps.setString(8, gender);

// Execute the prepared query
rs = ps.executeQuery();
%>

<!-- Make a table to show similar items in the database -->
	<body>
	<h2> Are any of the following items similar to your listing?</h2>
	<p>If not, please click the link at the end of the page.</p>
		<table style= "width:100%">
			<tr>
				<td><b>Name</b></td>
				<td><b>Condition</b></td>
				<td><b>Manufacturing Location</b></td>
				<td><b>Brand</b></td>
				<td><b>Color</b></td>
				<td><b>Material</b></td>
				<td><b>Child?</b></td>
				<td><b>Size</b></td>
				<td><b>Gender</b></td>
				<td><b>Similar?</b></td>
			</tr>
			<form action="addNewListing.jsp" method="POST">
			<% while (rs.next()) { %>
				<tr>
					<td> <%= rs.getString("name") %></td>
					<td> <% if (rs.getString("item_condition").equals("brandnew")) %> Brand New
						 <% if (rs.getString("item_condition").equals("good")) %> Used: Good
						 <% if (rs.getString("item_condition").equals("fair")) %> Used: Fair
					</td>
					<td> <%= rs.getString("manufacturing_location") %></td>
					<td> <%= rs.getString("brand") %></td>
					<td> <%= rs.getString("color") %></td>
					<td> <%= rs.getString("material") %></td>
					<td> <% if (rs.getString("child").equals("0")) %> No
						 <% if (rs.getString("child").equals("1")) %> Yes
					</td>
					<td> <%= rs.getString("shirt_size") %></td>
					<td> <% if (rs.getString("gender").equals("male")) %> Male
						 <% if (rs.getString("gender").equals("female")) %> Female
					</td>
					<td><input type="radio" id="similarID" name="similarID" value="<%= rs.getString("item_id")%>"></td>
				</tr>
			<% } %>
			</form>
		</table>
		<a href="addNewListing.jsp">None of these items are similar to my item.</a>
	</body>
</html>