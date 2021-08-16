<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

// Get the information from the previous page
String bidder = (String)session.getAttribute("user");
String bidAmount = request.getParameter("bidAmount");
float amountFloat = Float.parseFloat(bidAmount);
String thisAuctionString = request.getParameter("auctionID");
int thisAuction = Integer.parseInt(thisAuctionString);

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

// Make a query to get all the necessary parameters
String params = "select seller, name, current_price, now() < end_date goodTime from auctions natural join items where auction_id = " + thisAuction;
rs = st.executeQuery(params);
rs.next();

// Store the parameters
String seller = rs.getString("seller");
String itemName = rs.getString("name");
float currentPrice = Float.parseFloat(rs.getString("current_price"));
boolean goodTime = rs.getBoolean("goodTime");

// Check if the user is bidding on their own auction
if (seller.equals((String)session.getAttribute("user"))) {
	out.println("Error: You cannot bid on your own auction. <div><a href='../searchItemType.jsp'>Return to the search page.</a>");

// If the auction has expired while the user was browsing, reject the bid
} else if (!goodTime) {
	out.println("Error: This auction has ended. <div><a href='../searchItemType.jsp'>Return to the search page.</a>");
	
// If the bid is not larger than the current bid, reject it
} else if (amountFloat <= currentPrice) {
	out.println("Your bid must be larger than the current price of the auction. <div><a href='bidOnItem.jsp?auctionID="
		+ thisAuctionString + "'Try again.</a></div>");
	
// If the bid is valid, update the auction
} else {
	
	String addBid = "insert into bidOn values(?, ?, now(), ?)";
	PreparedStatement ps = con.prepareStatement(addBid);
	ps.setString(1, bidder);
	ps.setInt(2, thisAuction);
	ps.setFloat(3, amountFloat);
	ps.executeUpdate();
	
	String updatePrice = "update auctions set current_price = ? where auction_id = ?";
	ps = con.prepareStatement(updatePrice);
	ps.setFloat(1, amountFloat);
	ps.setInt(2, thisAuction);
	ps.executeUpdate();
	
	currentPrice = amountFloat;
	
	out.println("Your bid has been successfully placed. <a href='../../endMain.jsp'>Return to the main page.</a>");
	
}

//Find the current highest bidder among all of the autobids and make them the new highest bidder, if there are no autobidders, do nothing
rs = st.executeQuery("select count(username) autoBidders from autoBid b, auctions a where b.active_status = true and a.auction_id = " + thisAuction + " and a.auction_id = b.auction_id");
rs.next();

if (rs.getInt("autoBidders") == 1) {
	
	rs = st.executeQuery("select name, bid_interval, highest_price, username "
		+ "from autoBid natural join auctions natural join items where auction_id = " + thisAuction);
	rs.next();
	
	float incCheck = rs.getFloat("bid_interval");
	float maxPrice = rs.getFloat("highest_price");
	String autoBidder = rs.getString("username");
	itemName = rs.getString("name");
	
	
	if (currentPrice + incCheck <= maxPrice) {
		st.executeUpdate("insert into bidOn values('" + autoBidder + "', " + thisAuction + ", now(), " + (incCheck + currentPrice) + ")");
		st.executeUpdate("update auctions set current_price = " + (currentPrice + incCheck) + " where auction_id = " + thisAuction);
	} else if (currentPrice < maxPrice) {
		st.executeUpdate("insert into bidOn values('" + autoBidder + "', " + thisAuction + ", now(), " + maxPrice + ")");
		st.executeUpdate("update auctions set current_price = " + maxPrice + " where auction_id = " + thisAuction);
	} else {
		
		// Alert the autobidder that someone has bid higher than their max bid
		st.executeUpdate("insert into alerts values('" + autoBidder + "', 'Someone has bid higher than your maximum on " + itemName + "!', 'outbid', now())");
		
		// Change the active status of the autobidder
		st.executeUpdate("update autoBid set active_status = false where username = '" + autoBidder + "' and auction_id = " + thisAuction);
	}
	

} else if (rs.getInt("autoBidders") > 1) {
	
	// Get the second highest autobidder
	String secondHighest = "select username, highest_price from autoBid where auction_id = " + thisAuction + " and highest_price = (select max(highest_price) from autoBid " +
		"where highest_price < (select max(highest_price) from autoBid))";
	rs = st.executeQuery(secondHighest);
	rs.next();
	String secondHighestUsername = rs.getString("username");
	float secondHighestMaxPrice = rs.getFloat("highest_price");
	
	// Insert the second highest autobidder's bid
	st.executeUpdate("insert into bidOn values('" + secondHighestUsername + "', " + thisAuction + ", now(), " + secondHighestMaxPrice + ")");
	
	// Change the active status of the second highest autobidder
	st.executeUpdate("update autoBid set active_status = false where username = '" + secondHighestUsername + "' and auction_id = " + thisAuction);
	
	
	// Get the highest autobidder
	String highest = "select username, highest_price, bid_interval from autoBid where auction_id = " + thisAuction + " and highest_price = (select max(highest_price) from autoBid)";
	rs = st.executeQuery(highest);
	rs.next();
	String highestAutoBidder = rs.getString("username");
	float thisMax, thisIncrement;
	thisMax = rs.getFloat("highest_price");
	thisIncrement = rs.getFloat("bid_interval");
	
	// Compute the proper bid of the highest autobidder
	if (secondHighestMaxPrice + thisIncrement <= thisMax) {
		st.executeUpdate("insert into bidOn values('" + highestAutoBidder + "', " + thisAuction + ", now(), " + (secondHighestMaxPrice + thisIncrement) + ")");
		st.executeUpdate("update auctions set current_price = " + (secondHighestMaxPrice + thisIncrement) + " where auction_id = " + thisAuction);
	} else {
		st.executeUpdate("insert into bidOn values('" + highestAutoBidder + "', " + thisAuction + ", now(), " + thisMax + ")");
		st.executeUpdate("update auctions set current_price = " + thisMax + " where auction_id = " + thisAuction);
	}
	
	// Alert the second highest bidder that he has been outbid
	st.executeUpdate("insert into alerts values('" + secondHighestUsername + "', 'Someone has bid higher than your maximum on " + itemName + "!', 'outbid', now())");
	
	// Change the active status of the second highest autobidder
	st.executeUpdate("update autoBid set active_status = false where auction_id = " + thisAuction + " and username = " + secondHighestUsername);
	
}

//Find all of the users that have been outbid
String outBidUser, outBidQuery;
outBidQuery = "select distinct b.username from bidOn b where b.auction_id = "
	+ thisAuction + " and b.username not in (select username from bidOn where amount = (select max(amount) from bidOn)) "
	+ "and b.username not in (select username from autoBid where auction_id = " + thisAuction + ")";
rs = st.executeQuery(outBidQuery);

//Make an alert for all of the users that have been outbid
ArrayList<String> bidders = new ArrayList<String>();
ArrayList<String> items = new ArrayList<String>();
while (rs.next()) {
	outBidUser = rs.getString("username");
	itemName = rs.getString("name");
	bidders.add(outBidUser);
	items.add(itemName);
}

for (int i = 0; i < bidders.size(); i++) {
	st.executeUpdate("update autoBid set active_status = false where username = '" + bidders.get(i) + "' and auction_id = " + thisAuction);
	String outBidString = "insert into alerts values('" + bidders.get(i) + "', 'You have been outbid on " + items.get(i) + "!', 'outbid', now())";
	st.executeUpdate(outBidString);
}

// Remove all of the inactive autobidders (this allows the user to set up a new autobid)
String inactive = "delete from autoBid where active_status = false";
st.executeUpdate(inactive);

%>