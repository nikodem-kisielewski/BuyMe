<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Create Auction Page</title>
	</head>
	<body>
		<h1>Create a listing</h1>
		<div>
		<form action="checkSimilarShirt.jsp" method="POST">
			Name:	<input type="text" name="name"/><br/>
			Condition:	<select name="condition" id="condition">
				<option value="brandnew">Brand New</option>
				<option value="good">Used: Good</option>
				<option value="fair">Used: Fair</option>
			</select></br>
			Manufacturing location (Country):	<input type="text" name="loc"/></br>
			Brand:	<input type="text" name="brand"/></br>
			Color:	<input type="text" name="color"/></br>
			Design:	<input type="text" name="design"/></br>
			Material:	<input type="text" name="material"/></br>
			Child size?	<select name="child" id="child">
				<option value=false>No</option>
				<option value=true>Yes</option>
			</select></br>
			Size: <select name="size" id="size">
				<option value="XS">XS</option>
				<option value="S">S</option>
				<option value="M">M</option>
				<option value="L">L</option>
				<option value="XL">XL</option>
				<option value="XXL">XXL</option>
			</select></br>
			Gender:	<select name="gender" id="gender">
				<option value="male">Male</option>
				<option value="female">Female</option>
			</select></br>
			<input type="submit" value="Submit"/>
			</form>
		</div>
	</body>
</html>