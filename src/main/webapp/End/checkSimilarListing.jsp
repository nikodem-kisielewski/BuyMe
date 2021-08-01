<%@ page import ="java.sql.*" %>
<%

String itemCondition = request.getParameter("condition");
String manLoc = request.getParameter("loc");
String brand = request.getParameter("brand");
String color = request.getParameter("color");
String material = request.getParameter("material");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");

Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from items where condition='" + itemCondition +
	"', manufacturing_location='" + manLoc + "', brand='" + brand +
	"', color='" + color + "', material='" + material + "'");





%>