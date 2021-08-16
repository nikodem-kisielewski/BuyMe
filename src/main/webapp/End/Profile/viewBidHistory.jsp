<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Bids You've Placed</title>
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
		tr:nth-child(odd) {
			background-color: #f2f2f2;
		}
	</style>
</head>
<body>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        String username=session.getAttribute("user").toString();
        ResultSet rs=st.executeQuery("select auction_id, item_id,seller, amount, current_price,date,end_date from auctions natural join bidOn where username= '"+username+"' order by auction_id,date desc;");
        %>
        
        <table>
        <TR>
     
         <H2><BR>Your Bid History</H2>
    
   </TR>
          <tr>
             <th>Auction ID</th>
                <th>Item ID</th>
                <th>Seller</th>
                  <th>Bid Amount</th>
                     <th>Highest Bid</th>
                <th>Date of Bid Placement</th>
                   <th>End Date for Auction</th>
               
          </tr>
      
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
        </table><br>
       <a href='endProfile.jsp'>Go back to Your Profile Page</a>
        <%con.close();%>
</body>
