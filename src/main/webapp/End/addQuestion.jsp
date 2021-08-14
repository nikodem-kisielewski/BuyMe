<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

// Get all of the parameters that the user entered
String question = request.getParameter("question");
System.out.println(question);

if (question.equals("")) {
	out.println("Your question was blank. <div><a href='endCustomerService.jsp'>Try again</a></div>");
} else {
	
	String username = (String)session.getAttribute("user");
	
	String query = "insert into ask (customer_username, representative_username, date, question) values(?, ?, now(), ?)";
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1, username);
	ps.setString(2, username);
	ps.setString(3, question);

	System.out.println(ps);
	
	ps.executeUpdate();
	
	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();
	out.print("Question asked!");
	%>
	<a href='endCustomerService.jsp'>Go back to Customer Service Page</a>
	<% 
}
%>
