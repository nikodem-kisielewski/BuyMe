<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Auctions You Participated In</title>
   
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        String username=session.getAttribute("user").toString();
   
        
        	  ResultSet rs=st.executeQuery("select distinct auction_id, item_id, seller, current_price, (select max(b.amount) as yourBid from bidOn b where username='"+username+"' and b.auction_id=a.auction_id) as bid,end_date from auctions a natural join bidOn where username='"+username+"'or seller='"+username+"';");
         	  %>
         	  <h1>Auctions You've Participated In</h1>
        	  <table border=1 style="text-align:center">
              <thead>
                  <tr>
                     <th>Auction ID</th>
                        <th>Item ID</th>
                             <th>Seller</th>
                       <th>Your Highest Bid</th>
                        <th>Current Highest Bid</th>
                           <th>End Date</th> 
                  </tr>
              </thead>
              <tbody>
              
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
                   </tbody>
                </table><br>
      
</body>
