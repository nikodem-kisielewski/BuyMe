<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Auctions Containing This Item In The Last Month</title>
    <style>
		table {
			border: 1px solid black;
			border-collapse: collapse;	
			width: 100%
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
<body>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        int item_id = Integer.parseInt(request.getParameter("itemID"));
   
        
       	ResultSet rs = st.executeQuery("select auction_id, buyer, seller, final_price, end_date from items natural join "
        	+ "(auctions natural join sold) where end_date<now() and end_date>DATE_SUB(NOW(), INTERVAL 1 MONTH) and item_id= " + item_id);
       	
         	  %>
         	  
         	  <h1>Auction History for This Item</h1>
        	  <table>
                  <tr>
                     <th>Auction ID</th>
                        <th>Buyer(Winner)</th>
                             <th>Seller</th>
                       <th>Final Price</th>
                           <th>End Date</th> 
                  </tr>
              
                <% while(rs.next())
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