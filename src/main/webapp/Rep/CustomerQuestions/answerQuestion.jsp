<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

// Get all of the parameters that the user entered
String question = request.getParameter("question");
String answer = request.getParameter("answer");
System.out.println(question);
System.out.println(answer);

if (answer.equals("")) {
	out.println("Your answer was blank. <div><a href='endCustomerService.jsp'>Try again</a></div>");
} else {
	
	String rep_username = (String)session.getAttribute("user");
	
	String query = "update ask set representative_username = ?, answer = ? where question = ?";
	
	PreparedStatement ps = con.prepareStatement(query);
	
	ps.setString(1, rep_username);
	ps.setString(2, answer);
	ps.setString(3, question);

	System.out.println(ps);
	
	ps.executeUpdate();
	
	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();
	out.print("Question answered!");
	
	response.sendRedirect("repCustomerService.jsp");
	%><a href='../repCustomerService.jsp'>Go back to Customer Service Page</a><% 

	
}
%>
