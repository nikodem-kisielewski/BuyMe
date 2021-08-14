<!DOCTYPE html>
<html>
   <head>
      <title>Remove Bid</title>
   </head>
   <body>
   <h1>Remove Bid</h1>
     <form action="deleteBidCode.jsp" method="POST">
       Auction ID:	<input type="text" name="key"/> <br/>
       Username: <input type="text" name="username"/> <br/>
       Bid Amount: <input type="text" name="bid_amount"/> <br/>
       <input type="submit" value="Submit"/>
       <div>
       		<a href='../repMain.jsp'>Go back to Customer Representative Main Page</a>
       </div>
     </form>
   </body>
</html>