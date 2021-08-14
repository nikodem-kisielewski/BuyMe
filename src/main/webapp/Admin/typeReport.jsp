<%@ page import ="java.sql.*" %>
<%

String type = request.getParameter("type");  

Class.forName("com.mysql.jdbc.Driver");
        String data_type= request.getParameter("data_type");
        System.out.println(data_type);
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs;
        
if(type==null){
	%><h2> Please Choose an Item Type</h2><%
}

else if(type.equals("shirt")){
	 rs=st.executeQuery("select sum(a.current_price) as total from auctions a,shirts s where now()>a.end_date and a.item_id=s.item_id;");
	 %>
	 <table border=1 style="text-align:center">
     <thead>
         <tr>
            <th>Total Earnings For Shirts</th>
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
else if(type.equals("pants")){
	 rs=st.executeQuery("select sum(a.current_price) as total from auctions a,pants p where now()>a.end_date and a.item_id=p.item_id;");
	 %>
	 <table border=1 style="text-align:center">
     <thead>
         <tr>
            <th>Total Earnings For Pants</th>
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
else {
	 rs=st.executeQuery("select sum(a.current_price) as total from auctions a,footwear f where now()>a.end_date and a.item_id=f.item_id;");
	 %>
	 <table border=1 style="text-align:center">
     <thead>
         <tr>
            <th>Total Earnings For Footwear</th>
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
      
}%>
 <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>