<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Bids You've Placed</title>
   
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        String username=session.getAttribute("user").toString();
        ResultSet rs=st.executeQuery("select auction_id, item_id,seller, amount, current_price,date,end_date from auctions natural join bidOn where username= '"+username+"' order by auction_id,date desc;");
        %>
        
        <table border=1 style="text-align:center">
        <TR>
     
         <H2><BR>Your Bid History</H2>
    
   </TR>
      <thead>
          <tr>
             <th>Auction ID</th>
                <th>Item ID</th>
                <th>Seller</th>
                  <th>Bid Amount</th>
                     <th>Highest Bid</th>
                <th>Date of Bid Placement</th>
                   <th>End Date for Auction</th>
               
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
                
                <td><%=rs.getString("amount") %></td>
                <td><%=rs.getString("current_price") %></td>
                <td><%=rs.getString("date") %></td>
                  <td><%=rs.getString("end_date") %></td>
            
            </tr>
            <%}%>
           </tbody>
        </table><br>
       <a href='endProfile.jsp'>Go back to Your Profile Page</a>
        <%con.close();%>
</body>
