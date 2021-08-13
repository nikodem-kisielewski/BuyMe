<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

//Get the username of the seller
String seller = (String)session.getAttribute("user");

// Get all of the parameters that the user entered
String itemName = request.getParameter("name");
String itemCondition = request.getParameter("condition");
String manLoc = request.getParameter("loc");
String brand = request.getParameter("brand");
String color = request.getParameter("color");
String design = request.getParameter("design");
String material = request.getParameter("material");

String childString = request.getParameter("child");
boolean child, insole;
if (childString.equals("false")) {
	child = false;
} else {
	child = true;
}

String shoeSize = request.getParameter("shoeSize");
String shoeWidth = request.getParameter("width");

String insoleString = request.getParameter("insole");
if (insoleString.equals("false")) {
	insole = false;
} else {
	insole = true;
}

String method = request.getParameter("method");
String purpose = request.getParameter("purpose");
String gender = request.getParameter("gender");

String endDate = request.getParameter("endDate");
String dateQuery = "select now() < ? properDate";
PreparedStatement ps = con.prepareStatement(dateQuery);
ps.setString(1, endDate);
rs = ps.executeQuery();
rs.next();
Boolean properDate = rs.getBoolean("properDate");

String reservePrice = request.getParameter("reservePrice");

if (manLoc.equals("") || brand.equals("") || color.equals("") || material.equals("") || endDate.equals("") || reservePrice.equals("")
			|| method.equals("") || purpose.equals("") || reservePrice.equals("0")) {
	out.println("One of your entry fields is empty, please try again. <div><a href='shoeListing.jsp'>Try again</a></div>");
} else if (!properDate) {
	out.println("Auction end date is invalid, please try again. <div><a href='shoeListing.jsp'>Try again</a></div>");
} else {
	// Create the query and insert the proper values afterwards
	String similarQuery = "select * from items natural left join footwear where item_condition = ? and manufacturing_location = ? and brand = ?" +
				"and color = ? and material = ? and child = ? and shoe_size= ? and width = ? and in_sole = ? and securing_method = ? and purpose = ? and gender = ?";

	// Fill the prepared statement with the proper values
	ps = con.prepareStatement(similarQuery);
	ps.setString(1, itemCondition);
	ps.setString(2, manLoc);
	ps.setString(3, brand);
	ps.setString(4, color);
	ps.setString(5, material);
	ps.setBoolean(6, child);
	ps.setString(7, shoeSize);
	ps.setString(8, shoeWidth);
	ps.setBoolean(9, insole);
	ps.setString(10, method);
	ps.setString(11, purpose);
	ps.setString(12, gender);

	// Execute the prepared query
	rs = ps.executeQuery();

				
	// If there exists a similar item, update its quantity and create a new auction with that item
	if (rs.next()) {
		int similarItemID = rs.getInt("item_id");
		st.executeUpdate("update items set quantity = quantity + 1 where item_id = " + similarItemID);
		
		// Find the highest ID number from the auctions table and create a new ID that is larger than it
		ResultSet lastID = st.executeQuery("select max(auction_id) highest from auctions");
		lastID.next();
		Integer newAuctionID = lastID.getInt("highest");
		if (newAuctionID == null) {
			newAuctionID = 0;
		}
		newAuctionID += 1;
		
		String addAuctionQuery = "insert into auctions values(?, ?, ?, ?, 0, now(), convert(?, datetime))";
		PreparedStatement addAuctionStatement = con.prepareStatement(addAuctionQuery);
		addAuctionStatement.setString(1, seller);
		addAuctionStatement.setInt(2, newAuctionID);
		addAuctionStatement.setInt(3, similarItemID);
		addAuctionStatement.setString(4, reservePrice);
		addAuctionStatement.setString(5, endDate);
		
		addAuctionStatement.executeUpdate();
			
	} else {
		
		// Find the highest ID number from the items table and create a new ID that is larger than it
		Integer newItemID, newAuctionID;
		ResultSet lastID = st.executeQuery("select max(item_id) highest from items");
		lastID.next();
		newItemID = lastID.getInt("highest");
		if (newItemID == null) {
			newItemID = 0;
		}
		newItemID += 1;
		
		String addItemQuery = "insert into items values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement addItemStatement = con.prepareStatement(addItemQuery);
		addItemStatement.setInt(1, newItemID);
		addItemStatement.setString(2, itemName);
		addItemStatement.setString(3, itemCondition);
		addItemStatement.setString(4, manLoc);
		addItemStatement.setString(5, brand);
		addItemStatement.setString(6, color);
		addItemStatement.setString(7, design);
		addItemStatement.setString(8, material);
		addItemStatement.setInt(9, 1);
		
		addItemStatement.executeUpdate();
		
		String addShoeQuery = "insert into footwear values(?, ?, convert(?, decimal(3, 1)), ?, ?, ?, ?, ?)";
		PreparedStatement addShoeStatement = con.prepareStatement(addShoeQuery);
		addShoeStatement.setInt(1, newItemID);
		addShoeStatement.setBoolean(2, child);
		addShoeStatement.setString(3, shoeSize);
		addShoeStatement.setString(4, shoeWidth);
		addShoeStatement.setBoolean(5, insole);
		addShoeStatement.setString(6, method);
		addShoeStatement.setString(7, purpose);
		addShoeStatement.setString(8, gender);
		
		addShoeStatement.executeUpdate();
		
		lastID = st.executeQuery("select max(auction_id) highest from auctions");
		lastID.next();
		newAuctionID = lastID.getInt("highest");
		if (newAuctionID == null) {
			newAuctionID = 0;
		}
		newAuctionID += 1;
		
		String addAuctionQuery = "insert into auctions values(?, ?, ?, convert(?, decimal(9,2)), 0, now(), convert(?, datetime))";
		PreparedStatement addAuctionStatement = con.prepareStatement(addAuctionQuery);
		addAuctionStatement.setString(1, seller);
		addAuctionStatement.setInt(2, newAuctionID);
		addAuctionStatement.setInt(3, newItemID);
		addAuctionStatement.setString(4, reservePrice);
		addAuctionStatement.setString(5, endDate);
		
		addAuctionStatement.executeUpdate();
	}
}

out.println("Your item has been listed. <a href='../../endMain.jsp'> Return to the main page");

%>