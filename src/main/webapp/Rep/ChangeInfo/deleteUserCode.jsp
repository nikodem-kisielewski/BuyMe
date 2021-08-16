<%@ page import ="java.sql.*" %>
<%
    String username = request.getParameter("username");   
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + username + "'" +"and acct_type='end'");
    
    // Check if the username already exists
    if (!rs.next()) {
    	out.println("User does not exist <div><a href='deleteUser.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "DELETE FROM users WHERE username='"+username+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
		out.print("Deletion of User " +"'"+username+ "'" +" was successful");
		%>
		</br>
		<a href='deleteUser.jsp'>Go back to User Deletion Page</a><%
    }
%>