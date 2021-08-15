<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
    <%@ page import ="java.sql.*" %>
</head>
<body bgcolor=white>
    	<%
        Class.forName("com.mysql.jdbc.Driver");
        String data_type= request.getParameter("data_type");
        System.out.println(data_type);
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs;
        
        if(data_type.equals("total_earnings")){
        	 rs=st.executeQuery("select sum(a.current_price) as total from auctions a where now()>a.end_date;");
        	 %>
        	 <table border=1 style="text-align:center">
             <thead>
                 <tr>
                    <th>Total Earnings</th>
                 </tr>
             </thead>
             <tbody>
             
               <%while(rs.next())
               {
                   %>
                   <tr>
                       <td><%=rs.getString("total") %></td>
                   </tr>
                   <%}%>
                  </tbody>
               </table><br>
              <% 
        }
        else if(data_type.equals("best_items")){
        	 rs=st.executeQuery("select a.item_id, sum(a.current_price) as total from auctions a where now()>a.end_date group by item_id order by total desc");
        	 %>
        	 <table border=1 style="text-align:center">
             <thead>
                 <tr>
                    <th>Item ID</th>
                    <th>Earnings for Item</th>
                 </tr>
             </thead>
             <tbody>
             
               <%while(rs.next())
               {
                   %>
                   <tr>
                       <td><%=rs.getString("a.item_id") %></td>
                        <td><%=rs.getString("total") %></td>
                   </tr>
                   <%}%>
                  </tbody>
               </table><br>
              <% 
        }
        else if(data_type.equals("best_sellers")){
        	 rs=st.executeQuery("select a.seller, sum(a.current_price) as total from auctions a where now()>a.end_date group by seller order by total desc;");
        	 %>
        	 <table border=1 style="text-align:center">
             <thead>
                 <tr>
                    <th>Seller Username</th>
                    <th>Earnings Made By User</th>
                 </tr>
             </thead>
             <tbody>
             
               <%while(rs.next())
               {
                   %>
                   <tr>
                       <td><%=rs.getString("a.seller") %></td>
                        <td><%=rs.getString("total") %></td>
                   </tr>
                   <%}%>
                  </tbody>
               </table><br>
              <% 
        }
        else{
        	
        }
       %>
       <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
    
</body>
