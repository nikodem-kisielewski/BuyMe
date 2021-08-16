<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Unanswered Questions</title>
	</head>
	<body>
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

			String username = (String)session.getAttribute("user");
			String query = "SELECT * FROM ask WHERE customer_username = ? and answer IS NULL";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, username);

			ResultSet rs = ps.executeQuery();
			
		%>
		
		<ul>
		
			<% while (rs.next()) { %>
				
				<li><%= rs.getString("question") %></li>
				
			<% }
			//close the connection.
			con.close();
			%>
		
		</ul>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		<a href='endCustomerService.jsp'>Go back to Customer Service Page</a>
	

	</body>
</html>