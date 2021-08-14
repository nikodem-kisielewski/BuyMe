<!DOCTYPE html>
<html>
	<head>
		<title>Set Search Parameters</title>
	</head>
	<body>
		<h1>Set your search parameters</h1>
		<p>Leave text box entries blank for no restrictions.</p>
		<div>
			<form action="endBrowseFootwear.jsp" method="POST">
				Condition: <select name="condition" id="condition">
					<option value="any">Any</option>
					<option value="brandnew">Brand New</option>
					<option value="good">Used: Good</option>
					<option value="fair">Used: Fair</option>
				</select><br>
				Brand: <input type="text" name="brand"><br>
				Color: <input type="text" name="color"><br>
				Material: <input type="text" name="material"><br>
				Child size? <select name="child" id="child">
					<option value=false>No</option>
					<option value=true>Yes</option>
				</select><br>
				Shoe Size: <input type="number" step="0.5" name="shoeSize"><br>
				Shoe Width: <select name="width" id="width">
					<option value="any">Any</option>
					<option value="Narrow">Narrow</option>
					<option value="Normal">Normal</option>
					<option value="Wide">Wide</option>
				</select><br>
				Has an insole?: <select name="insole" id="insole">
					<option value="False">No</option>
					<option value="True">Yes</option>
				</select><br>
				Securing method (laces, velcro, etc.): <input type="text" name="method"><br>
				Purpose (running, casual, hiking, etc): <input type="text" name="purpose"><br>
				Gender:	<select name="gender" id="gender">
					<option value="Male">Male</option>
					<option value="Female">Female</option>
				</select><br>
				Max price: <input type="number" step="5" name="maxPrice"><br>
				Sort by: <select name="sort" id="sort">
					<option value="priceHighToLow">Price: High to Low</option>
					<option value="priceLowToHigh">Price: Low to High</option>
				</select><br>
				<input type="submit" name="Submit">
			</form>
			<a href="searchItemType.jsp">Return to the item selection page</a>
		</div>
	</body>
</html>