<%@ page import ="java.sql.*" %>
<%

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs;

String username = (String)session.getAttribute("user");
String thisPassword = request.getParameter("pass");

rs = st.executeQuery("select * from users where username = '" + username + "' and password = '" + thisPassword + "'");

if(rs.next()) {
	st2.executeUpdate("delete from users where username = '" + username + "'");
	out.println("Your account has been deleted. <div><a href='../../login.jsp'>Return to login page.</a></div>");
} else {
	out.println("The password you entered is incorrect. <div><a href='endDeleteAccount.jsp'>Try again</a></div>");
}

%>