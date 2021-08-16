<%@ page import ="java.sql.*" %>
<% 
	String username = session.getAttribute("user").toString();
	String password = request.getParameter("pass");  
	String new_name = request.getParameter("name");  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + username + "'" +"and password='" + password+"'");
    
    // Check if the username already exists
    if (!rs.next()) {
    	out.println("Incorrect Password <div><a href='endProfile.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "UPDATE users SET name='" + new_name + "'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
		out.println("Your name has been updated to '" + new_name +"'");
		%>
		<br>
		<a href='endProfile.jsp'>Go back to Your Profile Page</a><%
    }
%>