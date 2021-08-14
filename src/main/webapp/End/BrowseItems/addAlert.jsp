<%@ page import="java.sql.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();

String itemIDString = request.getParameter("itemID");
System.out.println(itemIDString);
int itemID = Integer.parseInt(itemIDString);

String username = (String)session.getAttribute("user");

st.executeUpdate("insert into desiredItems values(" + itemID + ", '" + username + "')");

out.println("You will be alerted when the desired item becomes available. <a href='../endMain.jsp'>Return to main page</a>");

%>