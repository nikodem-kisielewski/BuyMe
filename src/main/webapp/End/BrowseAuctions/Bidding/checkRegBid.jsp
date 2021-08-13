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

if (amountFloat <= currentPrice) {
	
	out.println("Your bid must be larger than the current price of the auction. <div><a href='bidOnItem.jsp?auctionID=" +
		thisAuctionString + "'</a>Try again.</div>");
	
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
	
	// TODO: Alerts
	
	out.prinln("Your bid has been successfully placed. <a href'../../endMain.jsp'></a>Return to the main page");
	
}

%>