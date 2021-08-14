<%@ page import ="java.sql.*" %>
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

ResultSet timeSet;
String timeQuery = "select now() < a.end_date goodTime from auctions a where auction_id = " + thisAuction;
timeSet = st.executeQuery(timeQuery);
timeSet.next();

if (timeSet.getString("goodTime").equals("0")) {
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
	
	// Find the current highest bidder among all of the autobids
	ResultSet numAuto = st.executeQuery("select count(username) autoBidders from autobid b, auctions a where a.auction_id = b.auction_id");
	numAuto.next();
	if (rs.getInt("autoBidders") < 2) {
		
	}
	
	// Find all of the users that have been outbid
	String outBidUser, itemName;
	ResultSet outBidSet = st.executeQuery("select distinct username from bidOn where amount < (select max(amount) from bidOn) and username not in autoBid");
	ResultSet itemSet = st.executeQuery("select name from auctions a, items i where a.auction_id = " + thisAuction + "and a.item_id = i.item_id");
	itemSet.next();
	
	// Make an alert for all of the users that have been outbid
	while (outBidSet.next()) {
		itemName = itemSet.getString("name");
		outBidUser = outBidSet.getString("username");
		st.executeUpdate("insert into alerts values(" + outBidUser + ", You have been outbid on " + itemName + "!, 'outbid'");
	}
	
	out.println("Your bid has been successfully placed. <a href='../../endMain.jsp'>Return to the main page.</a>");
	
}

%>