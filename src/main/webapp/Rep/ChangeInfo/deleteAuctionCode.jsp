<%@ page import ="java.sql.*" %>
<%
    String auction_id = request.getParameter("auction_id");   
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from auctions where auction_id='" + auction_id + "'");
    
    // Check if the auction exists
    if (!rs.next()) {
    	out.println("Auction does not exist <div><a href='deleteAuction.jsp'>Try again</a></div>");
    }
   
    // Delete the auction
    else {
    	String query = "DELETE FROM auctions WHERE  auction_id='"+auction_id+"'";
    	PreparedStatement ps = con.prepareStatement(query);
		ps.executeUpdate();
		con.close();
		out.print("Deletion of Auction " +"'"+auction_id + "'" +" was successful");
		%>
		</br>
		<a href='deleteAuction.jsp'>Go back to Auction Removal Page</a><%
    }
%>