<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>User History</title>
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
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

			String user = request.getParameter("user");
			String role = request.getParameter("role");
			
			String buyerQuery = "SELECT * FROM bidOn b LEFT JOIN sold s ON b.auction_id = s.auction_id WHERE username = ?";
			String sellerQuery = "SELECT * FROM sold s WHERE seller = ?";
			/* if role is buyer, want to check username from bidOn, not buyer */
			String query = (role.equals("buyer")) ? buyerQuery : sellerQuery;
			
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, user);
			
			ResultSet rs = ps.executeQuery();
			
		%>
		
		<h1>User History Search</h1>
		
		<p>Search Query: <%=user %> is a <%=role %> </p>
		<a href="searchUserHistory.jsp">New search</a>
		
		<h4>Search Results</h4>
		
		<% if (role.equals("buyer")) { %>
		
			<table>
			
				<tr>
					<td><b>AuctionID</b></td>
					<td><b>User's Bid</b></td>
					<td><b>Final Price</b></td>
				</tr>
			
				<% while (rs.next()) { %>
				
					<% String finalPrice = (String)rs.getString("final_price"); %>
					
					<tr>
						<td><%= rs.getInt("auction_id") %></td>
						<td><%= rs.getFloat("amount") %></td>
						<td>
							<% if (finalPrice ==null){ %>
								TBD
							<% }else{ %>
								<%= finalPrice %>
							<% } %>
						</td>
					</tr>
					
				<% }
				//close the connection.
				con.close();
				%>
			
			</table>
		
		<% } else { %>
			
			<table>
			
				<tr>
					<td><b>Auction ID</b></td>
					<td><b>Final Price</b></td>
				</tr>
			
				<% while (rs.next()) { %>
				
					<tr>
						<td><%= rs.getInt("auction_id") %></td>
						<td><%= rs.getFloat("final_price") %></td>
					</tr>
					
				<% }
				//close the connection.
				con.close();
				%>
			
			</table>
			
			<% } %>
		
		
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	</body>
</html>