<%@ page import ="java.sql.*" %>
<%
	// Get the users information
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
    Statement st = con.createStatement();
    Statement newst = con.createStatement();
    ResultSet rs;
    
    rs = st.executeQuery("select last_login from users where username = '" + (String)session.getAttribute("user") + "'");
    
    // Auctions that did not have any bids
    String noBids = "select * from auctions natural join items where now() > end_date and current_price = 0 and (select last_login from users where username = '"
    	+ (String)session.getAttribute("user") + "') < end_date";
    rs = st.executeQuery(noBids);
    String seller, itemName;
    int thisAuction;
    
    while(rs.next()) {
    	seller = rs.getString("seller");
    	itemName = rs.getString("name");
    	
    	newst.executeUpdate("insert into alerts values('" + seller + "', 'Your item, " + itemName + " did not reach your minimum price.', 'notsold', now())");
    }
    
    
    // Update all other auction information
    String doneAuctionQuery = "select * from auctions a natural join bidOn b natural join items where now() > a.end_date and a.auction_id = b.auction_id and current_price = amount and (select last_login from users where username = '"
        	+ (String)session.getAttribute("user") + "') < end_date";
    rs = st.executeQuery(doneAuctionQuery);
    String winner;
    int soldItem;
    float reserve, currentPrice;
    
    while (rs.next()) {
    	itemName = rs.getString("name");
    	soldItem = rs.getInt("item_id");
    	seller = rs.getString("seller");
    	winner = rs.getString("username");
    	thisAuction = rs.getInt("auction_id");
    	currentPrice = rs.getFloat("current_price");
    	reserve = rs.getFloat("reserve_price");
    	
    	// If the item did not reach it's minumum price
    	if (currentPrice < reserve) {
    		
    		// Set the current price of the auction to 0
    		newst.executeUpdate("update auctions set current_price = 0 where auction_id = " + thisAuction);
    		
    		// Alert the seller that his item did not sell
    		newst.executeUpdate("insert into alerts ('" + seller + "', 'Your item, " + itemName + " did not reach your minimum price.', 'notsold', now())");
    		
    		// Alert the buyer that he did not win the item
    		newst.executeUpdate("insert into alerts ('" + winner + "', 'You did not win " + itemName + " since your bid did not surpass the minimum price of the auction.', 'notwon', now())");
    		
    	} else {
    		
    		// Insert the winner into the sold table
    		newst.executeUpdate("insert into sold values(" + seller + ", " + winner + ", " + thisAuction + ", " + currentPrice + ")");
    		
    		// Alert the winner of the auction
    		newst.executeUpdate("insert into alerts values (" + winner + ", You have won " + itemName + "for $" + currentPrice + "!, 'won', now())");
    				
    		// Update the item quantity of the item that has been sold
    		newst.executeUpdate("update items set quantity = quantity - 1 where item_id = " + soldItem);
    				
    		// Make all of the autobids on the auction inacitve
    		newst.executeUpdate("update autoBid set active_status = false where auction_id = " + thisAuction);
    	}
    }
    
    rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
    
    // Check if the username and corresponding password are in the database
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        
        // Update when the customer last logged in
        newst.executeUpdate("update users set last_login = now() where username = '" + (String)session.getAttribute("user") + "'");
        
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