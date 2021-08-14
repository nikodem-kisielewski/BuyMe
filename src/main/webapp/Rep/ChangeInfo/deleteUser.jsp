<!DOCTYPE html>
<html>
   <head>
      <title>Delete User</title>
   </head>
   <body>
   <h1>Delete User</h1>
     <form action="deleteUserCode.jsp" method="POST">
       Username:	<input type="text" name="username"/> <br/>
       <input type="submit" value="Submit"/>
       <div>
       		<a href='../repMain.jsp'>Go back to Customer Representative Main Page</a>
       </div>
       <h2>Warning: This permanently deletes this account and its bid history</h2>
     </form>
   </body>
</html>