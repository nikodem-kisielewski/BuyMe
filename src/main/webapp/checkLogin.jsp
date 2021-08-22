<%@ page import ="java.sql.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs, rs2;

// Update all auction information
// Auctions that did not have any bids
String noBids = "select seller, name, item_id, auction_id from auctions "
	+ "natural join items where now() > end_date and current_price = 0 "
	+ "and auction_id not in (select distinct auction_id from sold)";
rs = st.executeQuery(noBids);

String seller, itemName;
int thisAuction, thisItem;

while(rs.next()) {
	
	// Get the parameters to update tables
	seller = rs.getString("seller");
	itemName = rs.getString("name");
	thisAuction = rs.getInt("auction_id");
	thisItem = rs.getInt("item_id");
	
	// Move the auction into the sold table (item did not 'sell', but the auction has ended)
	st2.executeUpdate("insert into sold values('" + seller + "', '', " + thisAuction + ", 0)");
	
	// Alert the seller that his item has not been sold
	st2.executeUpdate("insert into alerts values('" + seller + "', 'Your item, "
		+ itemName + " has not been sold since the bids did not reach your reserve price.', 'notsold', now())");
	
	// Reduce the quantity of the item that was being sold
	st2.executeUpdate("update items set quantity = quantity - 1 where item_id = " + thisItem);
}

// Update all other auction information
String doneAuctionQuery = "select a.seller, b.username buyer, a.auction_id, "
	+ "a.reserve_price, a.current_price final_price, name, item_id "
	+ "from auctions a natural join items i natural join bidOn b "
	+ "where now() > end_date and a.current_price = b.amount "
	+ "and a.auction_id not in (select auction_id from sold)";
rs = st.executeQuery(doneAuctionQuery);

String winner;
float reservePrice, currentPrice;

while (rs.next()) {
	seller = rs.getString("seller");
	winner = rs.getString("buyer");
	thisAuction = rs.getInt("auction_id");
	reservePrice = rs.getFloat("reserve_price");
	currentPrice = rs.getFloat("final_price");
	itemName = rs.getString("name");
	thisItem = rs.getInt("item_id");
	
	// If the item did not reach it's minumum price
	if (currentPrice < reservePrice) {
		
		// Move the auction into the sold table (item did not 'sell', but the auction has ended)
		st2.executeUpdate("insert into sold values('" + seller + "', '', " + thisAuction + ", " + currentPrice + ")");
		
		// Alert the seller that his item did not sell
		st2.executeUpdate("insert into alerts values('" + seller + "', 'Your item, "
			+ itemName + " has not been sold since the bids did not reach your reserve price.', 'notsold', now())");
		
		// Reduce the quantity of the item that was being sold
		st2.executeUpdate("update items set quantity = quantity - 1 where item_id = " + thisItem);
		
	} else {
		
		// Insert the winner into the sold table
		st2.executeUpdate("insert into sold values('" + seller + "', '" + winner + "', " + thisAuction + ", " + currentPrice + ")");
		
		// Alert the winner of the auction
		st2.executeUpdate("insert into alerts values ('" + winner + "', 'You have won " + itemName + " for $" + currentPrice + "!', 'won', now())");
				
		// Update the item quantity of the item that has been sold
		st2.executeUpdate("update items set quantity = quantity - 1 where item_id = " + thisItem);
				
		// Make all of the autobids on the auction inacitve
		st2.executeUpdate("update autoBid set active_status = false where auction_id = " + thisAuction);
	}
}

// Get the users information
String userid = request.getParameter("username");   
String pwd = request.getParameter("password");

//Check if the username and corresponding password are in the database
rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");

if (rs.next()) {
	
	// Store the username in the session
	session.setAttribute("user", userid);

	// Check the users account type and redirect them to the proper page
	String type = rs.getString("acct_type");
	if (type.equals("end")) {
		response.sendRedirect("End/endMain.jsp");	
	} else if (type.equals("rep")) {
		response.sendRedirect("Rep/repMain.jsp");
	} else {
		response.sendRedirect("Admin/adminMain.jsp");
	}
	
	con.close();

// If not in the database, give the user an error message
} else {
	out.println("Invalid username or password. <div><a href='login.jsp'>Try again</a></div>");
	
	con.close();
}

%>