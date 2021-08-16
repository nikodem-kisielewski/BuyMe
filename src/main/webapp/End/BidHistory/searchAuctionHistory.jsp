<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Auction Bid History</title>
		<style>
			table {
				border: 1px solid black;
				border-collapse: collapse;	
				width: 100%
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
			<a href='../endMain.jsp'>Go back to BuyMe Main Page</a>
		</div>
		
		<br/>
		
		<h3>Site-wide Auction History</h3>
		
		<table>
		
			<tr>
				<td><b>Auction ID</b></td>
				<td><b>User</b></td>
				<td><b>Bid Amount</b></td>
				<td><b>Date</b></td>
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