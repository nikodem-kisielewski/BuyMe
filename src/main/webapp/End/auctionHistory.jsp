<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Auction History</title>
	</head>
	<body>
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

			String term = request.getParameter("term");
			String query = "SELECT * FROM bidOn WHERE auction_id = ?";
			
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, term);
			
			ResultSet rs = ps.executeQuery();
			
		%>
		
		<h1>Search Results</h1>
		<a href="searchAuctionHistory.jsp">New search</a>
		<br/>
		
		<p>Search Query: <%=term %></p>
		
		<table>
		
			<tr>
				<td>User</td>
				<td>Amount</td>
				<td>Date</td>
			</tr>
		
			<% while (rs.next()) { %>
			
				<tr>
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