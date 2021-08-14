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

			Statement stmt = con.createStatement();
			String query = "SELECT * from ask";

			ResultSet rs = stmt.executeQuery(query);
			
		%>
		
		<h1>Customer Service</h1>
		<div>

			<form action="searchQuestions.jsp" method="POST">
				Search Query: <input type="text" maxlength="200" name="term"/><br/><br/>
				
				<input type="submit" value="Submit"/>
			</form>
			
		</div>
		<br/>
		
		<h4>All Questions</h4>
		
		<table>
		
			<tr>
				<td>Question          </td>
				<td>Answer</td>
			</tr>
		
			<% while (rs.next()) { %>
			
				<% String answer = (String)rs.getString("answer"); %>
			
				<tr>
					<td><%= rs.getString("question") %></td>
					
					<td>
						<% if (answer ==null){ %>
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
	
		<a href='endCustomerService.jsp'>Go back to Customer Service Page</a>
	</body>
</html>