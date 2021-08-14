<!DOCTYPE html>
<html>
	<head>
		<title>Set Search Parameters</title>
	</head>
	<body>
		<h1>Set your search parameters</h1>
		<p>Leave text box entries blank for no restrictions.</p>
		<div>
			<form action="endBrowseShirts.jsp" method="POST">
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
				Size: <select name="size" id="size">
					<option value="any">Any</option>
					<option value="XS">XS</option>
					<option value="S">S</option>
					<option value="M">M</option>
					<option value="L">L</option>
					<option value="XL">XL</option>
					<option value="XXL">XXL</option>
				</select><br>
				Gender:	<select name="gender" id="gender">
					<option value="male">Male</option>
					<option value="female">Female</option>
				</select><br>
				Max price: <input type="number" step="5" name="maxPrice"><br>
				Sort by: <select name="sort" id="sort">
					<option value="priceHighToLow">Price: High to Low</option>
					<option value="priceLowToHigh">Price: Low to High</option>
				</select><br>
				<input type="submit" name="Submit">
			</form>
		</div>
	</body>
</html>