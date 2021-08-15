<!DOCTYPE html>
<html>
   <head>
      <title>Edit End User Account</title>
   </head>
   <body>
   <h1>Edit End User Account</h1>
     <form action="editUserCode.jsp" method="POST">
       Old Username:	<input type="text" name="old_user"/> <br/>
       New Username: <input type="text" name="new_user"/> <br/>
       New Password: <input type="text" name="pass"/> <br/>
       New Name: <input type="text" name="name"/> <br/>
       <input type="submit" value="Submit"/>
       <div>
       		<a href='../repMain.jsp'>Go back to Customer Representative Main Page</a>
       </div>
     </form>
   </body>
</html>