<!DOCTYPE html>
<html>
 <%@ page import ="java.sql.*" %>
   <head>
      <title>Remove Auction</title>
   </head>
   <body>
   <h1>Remove Auction</h1>
       Auction ID:	<input type="text" name="auction_id"/> <br/>
        <h3>Warning: This removes all bids associated with this auction</h3>
       <button onclick="Delete();this.disabled=true;">Delete Auction</button>
       
       <script>
	   function Delete() {
		    auction_id=document.getElement(auction_id);
	        Class.forName("com.mysql.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
	        Statement st = con.createStatement();
	        ResultSet rs;
	        rs = st.executeQuery("select * from auctions where auction_id='" + auction_id + "'");
	        if (!rs.next()) {
	        	out.print("Auction does not exist <div><a href='removeAuction.jsp'>Try again</a></div>");
	        }
	        else{
	        	con.close();
		   		out.print("Deletion of Customer Representative " +"'"+auction_id + "'" +" was successful");
		        rs = st.executeQuery("delete * from auctions where auction_id='" + auction_id + "'");
	        }
	       }
		</script>
       
       
       
       <div>
       		<a href='../repMain.jsp'>Go back to Customer Representative Main Page</a>
       </div>
      
     </form>
   </body>
</html>