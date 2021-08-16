<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Your Answered Questions</title>
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

			String username = (String)session.getAttribute("user");
			String query = "SELECT * FROM ask WHERE representative_username = ? and answer IS NOT NULL";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, username);

			ResultSet rs = ps.executeQuery();
			
		%>
		<h1>Your Answered Questions</h1>
		<table>
		
			<tr>
				<th>Question</th>
				<th>Answer</th>
			</tr>
		
			<% while (rs.next()) { %>
			
				<tr>
					<td><%= rs.getString("question") %></td>
					<td><%= rs.getString("answer") %></td>
				</tr>
				
			<% }
			//close the connection.
			con.close();
			%>
		
		</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		<a href='repCustomerService.jsp'>Go back to Customer Service Page</a>

	</body>
</html>