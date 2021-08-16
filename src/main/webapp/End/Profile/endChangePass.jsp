<%@ page import ="java.sql.*" %>
<%
    String username=session.getAttribute("user").toString();  
	String old_password =request.getParameter("old_pass");
	String new_password1 = request.getParameter("new_pass1");  
	String new_password2 = request.getParameter("new_pass2");  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + username + "'" +"and password='"+old_password+"'");
    
    // Check if the username already exists
    if (!rs.next()) {
    	out.println("Incorrect Password <div><a href='endProfile.jsp'>Try again</a></div>");
    }
    else if(!new_password1.equals(new_password2)){
    	out.println("New Passwords do not match <div><a href='endProfile.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "UPDATE users SET password='" + new_password1 +"' where username= '" +username+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
		out.println("Your password has been updated to '"+new_password1+"'");
		%>
		<br>
		<a href='endProfile.jsp'>Go back to Profile Page</a><%
    }
%>