<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Service</title>
	</head>
	<body>
		<% try {
	
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

			String term = request.getParameter("term");
			String likeTerm = "%" + term + "%";
			String query = "SELECT * FROM ask WHERE question LIKE ?";
			
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, likeTerm);

			System.out.println(ps);
			
			ResultSet rs = ps.executeQuery();
			
		%>
		
		<h1>Search Results</h1>
		<a href="browseQuestions.jsp">New search</a>
		<br/>
		
		<p>Search Query: <%=term %></p>
		
		<h4>Search Results</h4>
		
		<table>
		
			<tr>
				<td>Question</td>
				<td>Answer</td>
			</tr>
		
			<% while (rs.next()) { %>
			
				<% String answer = (String)rs.getString("answer"); %>
			
				<tr>
					<td><%= rs.getString("question") %></td>
					
					<td>
						<% if (answer == null){ %>
							N/A
						<% }else{ %>
							<%= answer %>
						<% } %>
					</td>
					
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