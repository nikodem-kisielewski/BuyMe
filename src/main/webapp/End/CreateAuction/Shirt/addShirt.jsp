<%@ page import ="java.sql.*" %>
<%

// Get all of the parameters that the user entered
String itemCondition = request.getParameter("condition");
String manLoc = request.getParameter("loc");
String brand = request.getParameter("brand");
String color = request.getParameter("color");
String material = request.getParameter("material");

String childString = request.getParameter("child");
if (childString.equals("false")) {
	boolean child = false;
} else {
	boolean child = true;
}

String shirt_size = request.getParameter("size");
String gender = request.getParameter("gender");

String endDate = request.getParameter("endDate");


String reservePrice = request.getParameter("reservePrice");

if (manLoc.equals("") || brand.equals("") || color.equals("") || material.equals("")) {
	out.println("One of your entry field is empty, please try again. <div><a href='shirtListing.jsp'>Try again</a></div>");
}

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st = con.createStatement();
ResultSet rs;

// Create the query and insert the proper values afterwards
String similarQuery = "select * from items natural left join shirts where item_condition = ? and manufacturing_location = ? and brand = ?" +
			"and color = ? and material = ? and child = ? and shirt_size= ? and gender = ?";

// Fill the prepared statement with the proper values
PreparedStatement ps = con.prepareStatement(similarQuery);
ps.setString(1, itemCondition);
ps.setString(2, manLoc);
ps.setString(3, brand);
ps.setString(4, color);
ps.setString(5, material);
ps.setString(6, child);
ps.setString(7, shirt_size);
ps.setString(8, gender);

// Execute the prepared query
rs = ps.executeQuery();

			
// If there exists a similar item, update its quantity and create a new auction with that item
if (rs.next()) {
	int similarItemID = rs.getInt("item_id");
	st.executeQuery("update items set quantity = quantity + 1 where item_id = " + similarItemID);
	
	String addAuctionQuery = "insert into auctions values(?, ?, ?, ?, ?, ?)";
	PreparedStatement addAuctionStatement = con.prepareStatement(addAuctionQuery);
	addAuctionStatement.setInt(1, similarItemID);
	addAuctionStatement.setFloat(2, reservePrice);
	addAuctionStatement.setFloat(3, reservePrice);
	addAuctionStatement.setInt(4, newID);
	addAuctionStatement.setInt(5, newID);
	addAuctionStatement.setInt(6, newID);
		
} else {
	ResultSet lastID = st.executeQuery("select max(item_id) highest from items");
	int newID = rs.getInt("highest") + 1;
	
	String addItemQuery = "insert into items values(?, ?, ?, ?, ?, ?)";
	PreparedStatement addAuctionStatement = con.prepareStatement(addItemQuery);
	addAuctionStatement.setInt(1, newID);
	addAuctionStatement.setFloat(2, reservePrice);
	addAuctionStatement.setFloat(3, reservePrice);
	addAuctionStatement.setInt(4, newID);
	addAuctionStatement.setInt(5, newID);
	addAuctionStatement.setInt(6, newID);
	
	String addAuctionQuery = "insert into auctions values(?, ?, ?, ?, ?, ?)";
	PreparedStatement addAuctionStatement = con.prepareStatement(addAuctionQuery);
	addAuctionStatement.setInt(1, newID);
	addAuctionStatement.setFloat(2, reservePrice);
	addAuctionStatement.setFloat(3, reservePrice);
	addAuctionStatement.setInt(4, newID);
	addAuctionStatement.setInt(5, newID);
	addAuctionStatement.setInt(6, newID);
}
			
			


























%>