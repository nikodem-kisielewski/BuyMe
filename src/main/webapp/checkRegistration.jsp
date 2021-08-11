<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + userid + "'");
    
    // Check if the username already exists
    if (rs.next()) {
    	out.println("Username already taken <div><a href='register.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
    else if (pwd.length() < 1 || userid.length() < 1 || pwd.contains(" ") || userid.contains(" ")) {
        	out.println("Invalid username or password <div><a href='register.jsp'>Try again</a></div>");
    }
    
    // Insert the new user into the database
    else {
    	String query = "insert into users (username, password, acct_type) values (?, ?, ?)";
    	PreparedStatement ps = con.prepareStatement(query);
    	
		ps.setString(1, userid);
		ps.setString(2, pwd);
		// User account type is end user by default
		ps.setString(3, "end");
		ps.executeUpdate();
		con.close();
		
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<div><a href='logout.jsp'>Log out</a></div>");
        response.sendRedirect("End/endMain.jsp");
    }
%>