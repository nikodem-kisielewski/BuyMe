<%@ page import ="java.sql.*" %>
<%
	// Get the users information
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
    
    // Check if the username and corresponding password are in the database
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        
        // Check the users account type and redirect them to the proper page
        String type = rs.getString("acct_type");
        if (type.equals("end")) {
        	response.sendRedirect("End/endMain.jsp");	
        } else if (type == "rep") {
        	response.sendRedirect("rep/repMain.jsp");
        } else {
        	response.sendRedirect("admin/adminMain.jsp");
        }
        
    // If not in the database, give the user an error message
    } else {
        out.println("Invalid username or password <div><a href='login.jsp'>Try again</a></div>");
    }
%>