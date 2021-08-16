<%@ page import ="java.sql.*" %>
<%
    String old_username = request.getParameter("old_user");   
	String new_username = request.getParameter("new_user");  
	String new_password = request.getParameter("pass");  
	String new_name = request.getParameter("name");  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + old_username + "'" +"and acct_type='end'");
    
    // Check if the username already exists
    if (!rs.next()) {
    	out.println("User does not exist <div><a href='editUser.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "UPDATE users SET username='" + new_username+ "', password='" +new_password+"', name='"+new_name+"' WHERE username='"+old_username+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
		out.println("The old username: '"+old_username+ "' has been updated to: '"+new_username+"'");
		out.println("The new password is: '" +new_password+"'");
		%>
		<br>
		<a href='editUser.jsp'>Go back to User Edit Page</a><%
    }
%>