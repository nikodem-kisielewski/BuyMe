<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Customer Service</title>
	</head>
	<body>
	
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

			Statement stmt = con.createStatement();
			String query = "SELECT * from bidOn";

			ResultSet rs = stmt.executeQuery(query);
			
		%>
	
		<h1>Auction History Search</h1>
		<div>
		<form action="auctionHistory.jsp" method="POST">
			Auction ID:	<input type="text" name="term"/><br/><br/>
			
			<input type="submit" value="Submit"/>
			</form>
			<a href='endMain.jsp'>Go back to BuyMe Main Page</a>
		</div>
		
		<br/>
		
		<h4>Site-wide Auction History</h4>
		
		<table>
		
			<tr>
				<td>AuctionID</td>
				<td>User</td>
				<td>Amount</td>
				<td>Date</td>
			</tr>
		
			<% while (rs.next()) { %>
			
				<tr>
					<td><%= rs.getInt("auction_id") %></td>
					<td><%= rs.getString("username") %></td>
					<td><%= rs.getFloat("amount") %></td>
					<td><%= rs.getDate("date") %></td>					
				</tr>
				
			<% }
			//close the connection.
			con.close();
			%>
		
		</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
	</body>
</html>