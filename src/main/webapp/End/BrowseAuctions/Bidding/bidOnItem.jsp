<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
String auctionID = request.getParameter("auctionID");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Bid on item</title>
	</head>
	<h1>Bidding</h1>
	<div>
		<p>You can place a bid on this item directly. You will be notified if you are outbid or
			if you win this item. Alternitavely you can also set up autobidding. Autobidding
			will bid on the item automatically as you get outbid. You can set your bid increment
			and the maximum price you are willing to pay.
		</p>
	</div>
	<div>
		<p> If you do not wish to set up autobidding, please leave the autobid fields blank.<p>
		<%  %>
		<h2>Normal bid</h2>
		<form action="regBid.jsp" method="POST">
			<input type="number" step="0.01" name="bidAmount"><br>
			<input type="hidden" name="auctionID" value="auctionID">
			<input type="submit" value="Submit Bid">
		</form>
	</div>
</html>