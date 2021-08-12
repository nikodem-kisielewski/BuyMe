<%@ page import ="java.sql.*" %>
<%
    String data_type = request.getParameter("data_type");   
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
	Statement st = con.createStatement();
	ResultSet rs;
	if(data_type.equals("total_earnings")){
		 rs = st.executeQuery("select sum(final_price) from sold");
		 print(rs);
	}
	if(data_type.equals("best_items")){
		
	}
	if(data_type.equals("best_sellers")){
		
	}
	if(data_type.equals("earnings_by_category")){
		
	}
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "DELETE FROM users WHERE username='"+userid+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
        response.sendRedirect("../adminMain.jsp");
    }
%>