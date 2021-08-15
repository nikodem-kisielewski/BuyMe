<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

String bidder = (String)session.getAttribute("user");

String bidAmount = request.getParameter("bidAmount");
float amountFloat = Float.parseFloat(bidAmount);

String thisAuctionString = request.getParameter("auctionID");
int thisAuction = Integer.parseInt(thisAuctionString);

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

String checkPrice = "select current_price from auctions where auction_id = " + thisAuction;
rs = st.executeQuery(checkPrice);
rs.next();
float currentPrice = Float.parseFloat(rs.getString("current_price"));

String timeQuery = "select now() < a.end_date goodTime from auctions a where auction_id = " + thisAuction;
rs = st.executeQuery(timeQuery);
rs.next();

if (rs.getString("goodTime").equals("0")) {
	out.println("Error: this auction has ended. <div><a href'../../endMain.jsp'>Return to the main page.</a>");
}

if (amountFloat <= currentPrice) {
	
	out.println("Your bid must be larger than the current price of the auction. <div><a href='bidOnItem.jsp?auctionID=" +
		thisAuctionString + "'Try again.</a></div>");


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
	
	rs = st.executeQuery("select * from autoBid where auction_id = " + thisAuction);
	rs.next();
	
	float incCheck = rs.getFloat("bid_interval");
	float maxPrice = rs.getFloat("highest_price");
	String autoBidder = rs.getString("username");
	
	if (currentPrice + incCheck <= maxPrice) {
		st.executeUpdate("insert into bidOn values('" + autoBidder + "', " + thisAuction + ", now(), " + (incCheck + currentPrice) + ")");
		st.executeUpdate("update auctions set current_price = " + (currentPrice + incCheck) + " where auction_id = " + thisAuction);
	} else if (currentPrice < maxPrice) {
		st.executeUpdate("insert into bidOn values('" + autoBidder + "', " + thisAuction + ", now(), " + maxPrice + ")");
		st.executeUpdate("update auctions set current_price = " + maxPrice + " where auction_id = " + thisAuction);
	}
	

} else if (rs.getInt("autoBidders") > 1) {
	// Get the second highest autobidder
	String secondHighest = "select username, highest_price from autoBid where auction_id = " + thisAuction + " and highest_price = (select max(highest_price) from autoBid " +
		"where highest_price < (select max(highest_price) from autoBid))";
	rs = st.executeQuery(secondHighest);
	rs.next();
	String secondHighestUsername = rs.getString("username");
	float secondHighestMaxPrice = rs.getFloat("highest_price");
	
	// Get the highest autobidder
	String highest = "select username, highest_price, bid_interval from autoBid where auction_id = " + thisAuction + " and highest_price = (select max(highest_price) from autoBid)";
	rs = st.executeQuery(highest);
	rs.next();
	String highestAutoBidder = rs.getString("username");
	float thisMax, thisIncrement;
	thisMax = rs.getFloat("highest_price");
	thisIncrement = rs.getFloat("bid_interval");
	
	if (secondHighestMaxPrice + thisIncrement <= thisMax) {
		st.executeUpdate("insert into bidOn values('" + highestAutoBidder + "', " + thisAuction + ", now(), " + (secondHighestMaxPrice + thisIncrement) + ")");
		st.executeUpdate("update auctions set current_price = " + (secondHighestMaxPrice + thisIncrement) + " where auction_id = " + thisAuction);
	} else {
		st.executeUpdate("insert into bidOn values('" + highestAutoBidder + "', " + thisAuction + ", now(), " + thisMax + ")");
		st.executeUpdate("update auctions set current_price = " + thisMax + " where auction_id = " + thisAuction);
	}
}

Statement newst = con.createStatement();
ResultSet newRS = st.executeQuery("select username, highest_price from autoBid where auction_id = " + thisAuction + " and active_status = 1 and highest_price < (select max(highest_price) from autoBid)");
String help;
float yes;
while (newRS.next()) {
	help = newRS.getString("username");
	yes = newRS.getFloat("highest_price");
	newst.executeUpdate("insert into bidOn values('" + help + "', " + thisAuction + ", now(), " + yes + ")");
}

//Find all of the users that have been outbid
String outBidUser, itemName, outBidQuery;
outBidQuery = "select distinct b.username, itemName.name, b.auction_id from bidOn b natural join (select name, a.auction_id from auctions a, items i where a.auction_id = "
	+ thisAuction + " and a.item_id = i.item_id) itemName where b.username not in (select username from bidOn where amount = (select max(amount) from bidOn));";
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


%>