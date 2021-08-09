<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Create Auction Page</title>
	</head>
	<body>
		<h1>Create a listing</h1>
		<div>
		<form action="checkSimilarListing.jsp" method="POST">
			Name:	<input type="text" name="name"/><br/>
			Condition:	<select name="condition" id="condition">
				<option value="brandnew">Brand New in Box</option>
				<option value="good">Used: Good</option>
				<option value="fair">Used: Fair</option>
				<option value="broken">Broken/For Parts</option>
			</select></br>
			Manufacturing location:	<input type="text" name="loc"/></br>
			Brand:	<input type="text" name="brand"/></br>
			Color:	<input type="text" name="color"/></br>
			Design:	<input type="text" name="design"/></br>
			Material:	<input type="text" name="material"/></br>
			<input type="submit" value="Submit"/>
			</form>
		</div>
	</body>
</html>