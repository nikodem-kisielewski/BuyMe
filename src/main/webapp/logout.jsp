<%@ page import ="java.sql.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
String username = (String)session.getAttribute("user");

// Update when the customer last logged in
st.executeUpdate("update users set last_login = now() where username = '" + (String)session.getAttribute("user") + "'");

session.invalidate();
// session.getAttribute("user");   //this will throw an error
response.sendRedirect("login.jsp");
 
%>