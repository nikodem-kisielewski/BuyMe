<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Auctions Containing This Item In The Last Month</title>
   
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        String item_id=request.getParameter("item_id");
   
        
        	  ResultSet rs=st.executeQuery("select auction_id, buyer, seller, final_price, end_date from items natural join (auctions natural join sold) where end_date<now() and end_date>DATE_SUB(NOW(), INTERVAL 1 MONTH) and item_id='"+item_id+"'");
         	  %>
         	  <h1>Auctions You've Participated In</h1>
        	  <table border=1 style="text-align:center">
              <thead>
                  <tr>
                     <th>Auction ID</th>
                        <th>Buyer(Winner)</th>
                             <th>Seller</th>
                       <th>Final Price</th>
                           <th>End Date</th> 
                  </tr>
              </thead>
              <tbody>
              
                <%while(rs.next())
                {
                    %>
                    <tr>
                        <td><%=rs.getString("auction_id") %></td>
                        <td><%=rs.getString("buyer") %></td>
                        <td><%=rs.getString("seller") %></td>
                        <td><%=rs.getString("final_price") %></td>
                          <td><%=rs.getString("end_date")%></td>
                    	
                    </tr>
                    <%}%>
                   </tbody>
                </table><br>
                <a href="../endMain.jsp">Go Back to BuyMe Main Page</a>
      
</body>
