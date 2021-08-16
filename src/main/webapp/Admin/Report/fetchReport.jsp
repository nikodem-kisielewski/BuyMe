<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
    	<title>Sales Report</title>
    <style>
			table {
				border: 1px solid black;
				border-collapse: collapse;	
				width: 50%
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
	<body>
    	<%
        Class.forName("com.mysql.jdbc.Driver");
        String data_type= request.getParameter("data_type");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs;
        
        if(data_type.equals("total_earnings")){
        	 rs=st.executeQuery("select sum(s.final_price) as total from sold s where buyer <> ''");
        	 %>
        	 <table>
                 <tr>
                    <th>Total Earnings</th>
                 </tr>
             
               <%while(rs.next())
               {
                   %>
                   <tr>
                       <td><%=rs.getString("total") %></td>
                   </tr>
                   <%}%>
               </table><br>
              <% 
        }
        else if(data_type.equals("best_items")){
        	 rs=st.executeQuery("select a.item_id, sum(s.final_price) as total from auctions a natural join sold s where s.buyer <> '' group by a.item_id order by total desc");
        	 %>
        	 <table border=1 style="text-align:center">
                 <tr>
                    <th>Item ID</th>
                    <th>Earnings for Item</th>
                 </tr>
             
               <%while(rs.next())
               {
                   %>
                   <tr>
                       <td><%=rs.getString("a.item_id") %></td>
                        <td><%=rs.getString("total") %></td>
                   </tr>
                   <%}%>
               </table><br>
              <% 
        }
        else if(data_type.equals("best_sellers")){
        	 rs=st.executeQuery("select a.seller, sum(a.current_price) as total from auctions a natural join sold s where buyer <> '' group by seller order by total desc;");
        	 %>
        	 <table border=1 style="text-align:center">
                 <tr>
                    <th>Seller Username</th>
                    <th>Earnings Made By User</th>
                 </tr>
             
               <%while(rs.next())
               {
                   %>
                   <tr>
                       <td><%=rs.getString("a.seller") %></td>
                        <td><%=rs.getString("total") %></td>
                   </tr>
                   <%}%>
               </table><br>
              <% 
        }
        else{
        	
        }
       %>
       <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
    
</body>
