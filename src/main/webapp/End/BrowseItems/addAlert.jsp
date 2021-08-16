<%@ page import="java.sql.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();

int itemID = Integer.parseInt(request.getParameter("itemID"));

String username = (String)session.getAttribute("user");

st.executeUpdate("insert into desiredItems values(" + itemID + ", '" + username + "')");

out.println("You will be alerted when the desired item becomes available. <a href='../endMain.jsp'>Return to main page</a>");

%>