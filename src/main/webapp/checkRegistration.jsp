<%@ page import ="java.sql.*" %>
<%

String userid = request.getParameter("username");   
String pwd = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

//Check if the username already exists
rs = st.executeQuery("select * from users where username='" + userid + "'");

if (rs.next()) {
	out.println("Username already taken <div><a href='register.jsp'>Try again</a></div>");
	
	con.close();
	
// Check to see if the entered username and password are valid
// Usernames and passwords cannot be blank and cannot contain spaces
} else if (pwd.length() < 1 || userid.length() < 1 || pwd.contains(" ") || userid.contains(" ")) {
	out.println("Invalid username or password <div><a href='register.jsp'>Try again</a></div>");
	
	con.close();

// Insert the new user into the database
} else {
	
	String query = "insert into users values(?, ?, ?, ?, now())";
	PreparedStatement ps = con.prepareStatement(query);
	
	ps.setString(1, userid);
	ps.setString(2, pwd);
	ps.setString(3, null);
	ps.setString(4, "end");
	ps.executeUpdate();
	con.close();
	
	// Store the username in the session
	session.setAttribute("user", userid);
	response.sendRedirect("End/endMain.jsp");
	
	con.close();
	
}

%>