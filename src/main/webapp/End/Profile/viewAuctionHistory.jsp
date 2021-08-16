<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
	<title>Auctions You Participated In</title>
	<style>
		table {
			border: 1px solid black;
			border-collapse: collapse;	
			width: 100%
		}
		table.center {
			margin-left: auto; 
  			margin-right: auto;
		}
		th, td {
			text-align: left;
			padding: 15px;
		}	
		tr:nth-child(even) {
			background-color: #f2f2f2;
		}
	</style>
	</head>
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        String username=session.getAttribute("user").toString();
   
        
        	  ResultSet rs=st.executeQuery("select distinct auction_id, item_id, seller, current_price, (select max(b.amount) as yourBid from bidOn b where username='"+username+"' and b.auction_id=a.auction_id) as bid,end_date from auctions a natural join bidOn where username='"+username+"'or seller='"+username+"';");
         	  %>
         	  <h1>Auctions You've Participated In</h1>
        	  <table>
                  <tr>
                     <th><b>Auction ID</b></th>
                        <th><b>Item ID</b></th>
                             <th><b>Seller</b></th>
                       <th><b>Your Highest Bid</b></th>
                        <th><b>Current Highest Bid</b></th>
                           <th><b>End Date</b></th> 
                  </tr>
              
                <%while(rs.next())
                {
                    %>
                    <tr>
                        <td><%=rs.getString("auction_id") %></td>
                        <td><%=rs.getString("item_id") %></td>
                        <td><%=rs.getString("seller") %></td>
                        <td><%=rs.getString("bid") %></td>
                        <td><%=rs.getString("current_price") %></td>
                        <td><%=rs.getString("end_date")%></td>
                    	
                    </tr>
                    <%}%>
                </table><br>
	<a href='endProfile.jsp'>Go back to Your Profile Page</a>
</body>
