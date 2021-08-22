<!DOCTYPE html>
<html>
	<head>
		<link rel='stylesheet' href='CSS/forms.css'>
		<title>Registration Form</title>
	</head>
	<body>
		<div class='back'>
			<h1>BuyMe Registration</h1>
			<form action="checkLogin.jsp" method="POST">
				Username: <input type="text" class='login' name="username">
				Password: <input type="password" name="password">
				<div class='link'>
					<input type="submit" value="Register"/><br>
					<a href='login.jsp'>Go back to login page</a>
				</div>
			</form>
		</div>
	</body>
</html>