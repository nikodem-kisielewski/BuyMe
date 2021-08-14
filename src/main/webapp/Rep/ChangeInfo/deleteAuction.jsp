<!DOCTYPE html>
<html>
   <head>
      <title>Auction Deletion</title>
   </head>
   <body>
   <h1>Auction Deletion</h1>
     <form action="deleteAuctionCode.jsp" method="POST">
      Auction ID:	<input type="text" name="auction_id"/> <br/>
      <h3>Warning: This removes all bids and can not be undone</h3>
       <input type="submit" value="Submit"/>
       <div>
       		<a href='../repMain.jsp'>Go back to Customer Representative Main Page</a>
       </div>
     </form>
   </body>
</html>