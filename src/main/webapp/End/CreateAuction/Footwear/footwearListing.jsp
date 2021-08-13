<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Create Auction Page</title>
	</head>
	<body>
		<h1>Create a listing</h1>
		<div>
		<form action="addFootwear.jsp" method="POST">
			Name:	<input type="text" name="name"/><br/>
			Condition:	<select name="condition" id="condition">
				<option value="brandnew">Brand New</option>
				<option value="good">Used: Good</option>
				<option value="fair">Used: Fair</option>
			</select><br>
			Manufacturing location (Country):	<input type="text" name="loc"/><br>
			Brand:	<input type="text" name="brand"/><br>
			Color:	<input type="text" name="color"/><br>
			Design:	<input type="text" name="design"/><br>
			Material:	<input type="text" name="material"/><br>
			Child size?	<select name="child" id="child">
				<option value=false>No</option>
				<option value=true>Yes</option>
			</select><br>
			Shoe Size: <input type="number" step="0.5" name="shoeSize"><br>
			Shoe Width: <select name="width" id="width">
				<option value="narrow">Narrow</option>
				<option value="normal">Normal</option>
				<option value="wide">Wide</option>
			</select><br>
			Has an insole?: <select name="insole" id="insole">
				<option value="false">No</option>
				<option value="true">Yes</option>
			</select><br>
			Securing method (laces, velcro, etc.): <input type="text" name="method"><br>
			Purpose (running, casual, hiking, etc): <input type="text" name="purpose"><br>
			Gender:	<select name="gender" id="gender">
				<option value="Male">Male</option>
				<option value="Female">Female</option>
			</select><br>
			Auction end date and time: <input type="datetime-local" name="endDate"/><br>
			Minimum price (reserve): <input type="number" step="0.01" name="reservePrice"/><br>
			<input type="submit" value="Submit"/>
			</form>
		</div>
	</body>
</html>