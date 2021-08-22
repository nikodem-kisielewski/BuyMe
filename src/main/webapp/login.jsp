<!DOCTYPE html>
<html>
	<head>
		<link rel='stylesheet' href='CSS/forms.css'>
		<title>Login Form</title>
	</head>
	<body>
		<div class='back'>
			<h1>BuyMe Login</h1>
			<form action="checkLogin.jsp" method="POST">
				Username: <input type="text" name="username">
				Password: <input type="password" name="password">
				<div class='link'>
					<input type="submit" value="Login"/><br>
					<a href='register.jsp'>New user? Register here</a>
				</div>
			</form>
		</div>
	</body>
</html>