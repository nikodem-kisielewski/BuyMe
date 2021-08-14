<%@ page import ="java.sql.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
String username = (String)session.getAttribute("user");
st.executeUpdate("delete from alerts where username = '" + username + "'");

session.invalidate();
// session.getAttribute("user");   //this will throw an error
response.sendRedirect("login.jsp");
 
%>