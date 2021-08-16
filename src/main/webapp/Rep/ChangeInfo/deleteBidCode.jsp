<%@ page import ="java.sql.*" %>
<%
    String auction_id = request.getParameter("key");   
	String username = request.getParameter("username");   
	String bid_amount = request.getParameter("bid_amount");   
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    Statement st2 = con.createStatement();
    Statement st3 = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from bidOn where username='" + username+ "' and auction_id='" + auction_id + "' and amount='"+ bid_amount+"'");
    
    // Check if the username already exists
    if (!rs.next()) {
    	out.println("Bid does not exist <div><a href='deleteBid.jsp'>Try again</a></div>");
    }
    
    // Check to see if the entered username and password are valid
    // Usernames and passwords cannot be blank and cannot contain spaces
   
    // Insert the new user into the database
    else {
    	String query = "delete from bidOn where username='" + username+ "' and auction_id='" + auction_id + "' and amount='"+ bid_amount+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		ResultSet rs2=st2.executeQuery("select max(amount) m from bidOn where auction_id= '" + auction_id+"'");
		ResultSet rs3=st3.executeQuery("select current_price from auctions where auction_id= '" + auction_id+"'");
		if(rs2.next() && rs3.next()){
			if(Float.parseFloat(rs2.getString("m")) < Float.parseFloat(rs3.getString("current_price"))){
				st.executeUpdate("update auctions set current_price="+Float.parseFloat(rs2.getString("m"))+" where auction_id='"+auction_id+"'");
			}
		}
		con.close();
		out.print("Deletion of Bid from Auction: " +"'"+auction_id + "' by User: '"+ username+"' with bid amount: '" +bid_amount +"' was successful");
		%>
		<br>
		<a href='deleteBid.jsp'>Go back to Bid Removal Page</a><%
    }
%>