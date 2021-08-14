<!DOCTYPE html>
<html>
   <head>
      <title>Your Profile</title>
   </head>
   <body>
  <h1>Your Profile</h1>
  <a href='viewEndUsers2.jsp'>View Auction History</a><br>
  <a href='viewEndUsers2.jsp'>View Bid History</a><br>
  
  <h3>Change Name</h3>
	<form action="endChangeName.jsp" method="POST">
       New Name: <input type="text" name="name"/> <br/>
       Password: <input type="password" name="pass"/> <br/>
       <input type="submit" value="Submit Name Change"/>
     
     </form>
    
     <h3>Change Username</h3>
     <form action="endChangeUser.jsp" method="POST">
       Password:	<input type="password" name="pass"/> <br/>
       New Username: <input type="text" name="new_user"/> <br/>
       <input type="submit" value="Submit Username Change"/>
    
     </form>
     <h3>Change Password</h3>
     <form action="endChangePass.jsp" method="POST">
       Old Password:	<input type="password" name="old_pass"/> <br/>
       New Password: <input type="password" name="new_pass"/> <br/>
       <input type="submit" value="Submit Password Change"/>
       <div>
       		<a href='endMain.jsp'>Go back to Buy Me Main Page</a>
       </div>
     </form>
   </body>
</html>