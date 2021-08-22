<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
Statement newst = con.createStatement();
Statement newerst = con.createStatement();
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
boolean child;
if (childString.equals("false")) {
	child = false;
} else {
	child = true;
}
String pantsSize = request.getParameter("size");
String type = request.getParameter("type");
String style = request.getParameter("style");
String gender = request.getParameter("gender");

String endDate = request.getParameter("endDate");

if (endDate.equals("")) {
	out.println("Auction end date is invalid, please try again. <div><a href='pantsListing.jsp'>Try again</a></div>");
} else {
	String dateQuery = "select now() < ? properDate";
	PreparedStatement ps = con.prepareStatement(dateQuery);
	ps.setString(1, endDate);
	rs = ps.executeQuery();
	rs.next();
	Boolean properDate = rs.getBoolean("properDate");

	String reservePrice = request.getParameter("reservePrice");

	if (manLoc.equals("") || brand.equals("") || color.equals("") || material.equals("") || endDate.equals("") || reservePrice.equals("")
				|| type.equals("") || style.equals("") || reservePrice.equals("0")) {
		out.println("One of your entry fields is empty, please try again. <div><a href='pantsListing.jsp'>Try again</a></div>");
	} else if (!properDate) {
		out.println("Auction end date is invalid, please try again. <div><a href='pantsListing.jsp'>Try again</a></div>");
	} else {
		// Create the query and insert the proper values afterwards
		String similarQuery = "select * from items natural left join pants where item_condition = ? and manufacturing_location = ? and brand = ?" +
					"and color = ? and material = ? and child = ? and pants_size= ? and pants_type = ? and gender = ?";

		// Fill the prepared statement with the proper values
		ps = con.prepareStatement(similarQuery);
		ps.setString(1, itemCondition);
		ps.setString(2, manLoc);
		ps.setString(3, brand);
		ps.setString(4, color);
		ps.setString(5, material);
		ps.setBoolean(6, child);
		ps.setString(7, pantsSize);
		ps.setString(8, type);
		ps.setString(9, gender);

		// Execute the prepared query
		rs = ps.executeQuery();

					
		// If there exists a similar item, update its quantity and create a new auction with that item
		if (rs.next()) {
			int similarItemID = rs.getInt("item_id");
			st.executeUpdate("update items set quantity = quantity + 1 where item_id = " + similarItemID);
			
			// Check to see if anyone was looking for the item and alert them
			ResultSet simAlert = newst.executeQuery("select username, name from desiredItems natural join items where item_id = " + similarItemID);
			while (simAlert.next()) {
				newerst.executeUpdate("insert into alerts values('" + simAlert.getString("username") + "', 'Your desired item, " + simAlert.getString("name") + " is now available for bidding!', 'item', now())");
				newerst.executeUpdate("delete from desiredItems where item_id = " + similarItemID + ", '" + simAlert.getString("username") + "'");
			}
			
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
			
			out.println("Your item has been listed. <a href='../../endMain.jsp'> Return to the main page.");
				
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
			
			String addPantsQuery = "insert into pants values(?, ?, ?, ?, ?, ?)";
			PreparedStatement addPantsStatement = con.prepareStatement(addPantsQuery);
			addPantsStatement.setInt(1, newItemID);
			addPantsStatement.setBoolean(2, child);
			addPantsStatement.setString(3, pantsSize);
			addPantsStatement.setString(4, type);
			addPantsStatement.setString(5, style);
			addPantsStatement.setString(6, gender);
			
			addPantsStatement.executeUpdate();
			
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
			
			out.println("Your item has been listed. <a href='../../endMain.jsp'> Return to the main page.");
			
		}
	}	
}

%>