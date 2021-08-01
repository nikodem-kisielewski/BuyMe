<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
   <h1>BuyMe Login</h1>
     <form action="checkLogin.jsp" method="POST">
       Username:	<input type="text" name="username"/> <br/>
       Password:	<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
       <div>
       	<a href='register.jsp'>New user? Register here</a>
       </div>
     </form>
   </body>
</html>