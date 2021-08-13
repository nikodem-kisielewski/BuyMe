<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username");   
    if(userid.equals("rep")){
    	%>Hello There</br><%
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + userid + "'and acct_type='rep'");
    
    // Check if the username already exists
    if (!rs.next()) {
    	out.println("Customer Representative does not exist <div><a href='deleteRep.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "DELETE FROM users WHERE username='"+userid+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
		out.print("Deletion of Customer Representative " +"'"+userid + "'" +" was successful");
		%>
		</br>
		<a href='../adminMain.jsp'>Go back to Admin Main Page</a><%
    }
%>