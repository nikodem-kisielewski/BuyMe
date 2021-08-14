<!DOCTYPE html>
<html>
   <head>
      <title><%session.getAttribute("user").toString();%>'s Profile</title>
   </head>
   <body>
  <h1><%=session.getAttribute("user").toString()%>'s Profile</h1>
    <h3><a href='viewBidHistory.jsp'>View Bid History</a></h3>
    
  <h3> <a href='viewAuctionHistory.jsp'>View Auction History</a></h3>
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
       New Password: <input type="password" name="new_pass1"/> <br/>
       Repeat New Password: <input type="password" name="new_pass2"/> <br/>
       <input type="submit" value="Submit Password Change"/><br>
       <div><br>
       		<a href='endMain.jsp'>Go back to Buy Me Main Page</a>
       </div>
     </form>
   </body>
</html>