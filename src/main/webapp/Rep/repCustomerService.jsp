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
			String query = "SELECT * from ask WHERE answer IS NULL";

			ResultSet rs = stmt.executeQuery(query);
			
		%>
		
		<h1>Customer Service</h1>
		<div>
			<a>Unanswered Questions</a><br/>
			<a href="repAnsweredQuestions.jsp">My Answered Questions</a><br/>
		</div>
		
		
		<ul>
		
			<% while (rs.next()) { %>
			
				<% String question = rs.getString("question"); %>

				<li>
				
					<div>
						<% System.out.println(question); %>
						<% out.print(question); %>
						<form action="answerQuestion.jsp" method="POST">
							Answer:	<input type="text" maxlength="200" size="130" name="answer"/><br/><br/>
						
						<input name="question" type="hidden" value='<%= question %>'>
						<input type="submit" value="Submit"/>
			</form>
					</div>
				
				
				</li>
				
			<% }
			//close the connection.
			con.close();
			%>
		
		</ul>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>