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
    
    // Update all auction information
    String doneAuctionQuery = "select * from auctions a natural join bidOn b natural join items where now() > a.end_date and a.auction_id = b.auction_id and current_price = amount";
    rs = st.executeQuery(doneAuctionQuery);
    String seller, winner, itemName;
    int thisAuction, soldItem;
    float reserve, currentPrice;
    
    while (rs.next()) {
    	itemName = rs.getString("name");
    	soldItem = rs.getInt("item_id");
    	seller = rs.getString("seller");
    	winner = rs.getString("username");
    	thisAuction = rs.getInt("auction_id");
    	currentPrice = rs.getFloat("current_price");
    	reserve = rs.getFloat("reserve_price");
    	
    	
    	if (currentPrice < reserve) {
    		st.executeUpdate("update auctions set current_price = 0 where auction_id = " + thisAuction);	
    	} else {
    		// Insert the winner into the sold table
    		st.executeUpdate("insert into sold values(" + seller + ", " + winner + ", " + thisAuction + ", " + currentPrice + ")");
    		
    		// Alert the winner of the auction
    		st.executeUpdate("insert into alerts values (" + winner + ", You have won " + itemName + "for $" + currentPrice + "!, 'won')");
    				
    		// Update the item quantity of the item that has been sold
    		st.executeUpdate("update items set quantity = quantity - 1 where item_id = " + soldItem);
    				
    		// Make all of the autobids on the auction inacitve
    		st.executeUpdate("update autoBid set active_status = false where auction_id = " + thisAuction);
    	}
    }
    
    // Check if the username and corresponding password are in the database
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        
        // Check the users account type and redirect them to the proper page
        String type = rs.getString("acct_type");
        if (type.equals("end")) {
        	response.sendRedirect("End/endMain.jsp");	
        } else if (type.equals("rep")) {
        	response.sendRedirect("Rep/repMain.jsp");
        } else {
        	response.sendRedirect("Admin/adminMain.jsp");
        }
        
    // If not in the database, give the user an error message
    } else {
        out.println("Invalid username or password <div><a href='login.jsp'>Try again</a></div>");
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
%>