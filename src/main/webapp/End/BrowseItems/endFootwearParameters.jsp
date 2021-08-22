<!DOCTYPE html>
<html>
	<head>
		<link rel='stylesheet' href='../../CSS/navbar.css'>
		<link rel='stylesheet' href='../../CSS/params.css'>
		<title>Set Search Parameters</title>
	</head>
	<body>
		<div class = 'navbar'>
			<a href='../endMain.jsp'>Home</a>
			<div class = 'dropdown'>
				<button class='dropbtn'>Create a new listing</button>
					<div class='dropdown-content'>
						<a href='../CreateAuction/footwearListing.jsp'>Footwear</a>
						<a href='../CreateAuction/pantsListing.jsp'>Pants</a>
						<a href='../CreateAuction/shirtListing.jsp'>Shirts</a>
					</div>
			</div>
			<div class='dropdown'>
				<button class='dropbtn'>Browse active listings</button>
				<div class='dropdown-content'>
					<a href='../BrowseAuctions/endFootwearParameters.jsp'>Footwear</a>
					<a href='../BrowseAuctions/endPantsParameters.jsp'>Pants</a>
					<a href='../BrowseAuctions/endShirtParameters.jsp'>Shirts</a>
				</div>
			</div>
			<div class='dropdown active'>
				<button class='dropbtn'>Browse Items</button>
				<div class='dropdown-content'>
					<a href='endFootwearParameters.jsp'>Footwear</a>
					<a href='endPantsParameters.jsp'>Pants</a>
					<a href='endShirtParameters.jsp'>Shirts</a>
				</div>
			</div>
			<a href='../BidHistory/searchAuctionHistory.jsp'>Browse Auction Bid Histories</a>
			<a href='../UserHistory/searchUserHistory.jsp'>Browse User Histories</a>
			<a href='../CustService/endCustomerService.jsp'>Customer Service</a>
			<a href='../Profile/endProfile.jsp'>Profile</a>
			<a href='../../logout.jsp' style='float:right'>Log out</a>
		</div>
		<div class='back'>
			<h1>Search for shirts</h1>
			<p>Leave text box entries blank for no restrictions.</p>
			<form action="endBrowseFootwear.jsp" method="POST">
			<div class='lcolumn'>
					<label>Condition:</label>
					<select name="condition" id="condition">
					<option value="any">Any</option>
					<option value="brandnew">Brand New</option>
					<option value="good">Used: Good</option>
					<option value="fair">Used: Fair</option>
				</select><br>
				<label>Brand:</label>
				<input type="text" name="brand"><br>
				<label>Color:</label>
				<input type="text" name="color"><br>
				<label>Material:</label>
				<input type="text" name="material"><br>
				<label>Child size?</label>
				<select name="child" id="child">
					<option value=false>No</option>
					<option value=true>Yes</option>
				</select><br>
				<label>Shoe Size:</label>
				<input type="number" step="0.5" name="shoeSize"><br>
				<input type="submit" name="Search">
			</div>
			<div class='rcolumn'>
				<label>Shoe Width:</label>
				<select name="width" id="width">
					<option value="any">Any</option>
					<option value="Narrow">Narrow</option>
					<option value="Normal">Normal</option>
					<option value="Wide">Wide</option>
				</select><br>
				<label>Has an insole?:</label>
				<select name="insole" id="insole">
					<option value="False">No</option>
					<option value="True">Yes</option>
				</select><br>
				<label>Securing method (laces, velcro, etc.):</label>
				<input type="text" name="method"><br>
				<label>Purpose (running, casual, hiking, etc):</label>
				<input type="text" name="purpose"><br>
				<label>Gender:</label>
				<select name="gender" id="gender">
					<option value="Male">Male</option>
					<option value="Female">Female</option>
				</select><br>
			</div>
			</form>
		</div>
	</body>
</html>