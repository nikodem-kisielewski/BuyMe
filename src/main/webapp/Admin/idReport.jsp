<%@ page import ="java.sql.*" %>
<%

int item_id = Integer.parseInt(request.getParameter("id")); 
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select item_id from items where item_id='"+item_id+"';");


    	if(!rs.first()){
    		  %><a href='generateSalesReport.jsp'>Item does not exist in database</a><% 
    	}
    	else{
    		rs=st.executeQuery("select max(current_price) as total from auctions where item_id='"+item_id+"' and now()>end_date;");
    		rs.first();
        		   %>
	    	 <table border=1 style="text-align:center">
	         <thead>
	             <tr>
	                <th>Total Earnings For Item <%=item_id%></th>
	             </tr>
	         </thead>
	         <tbody>
	               <tr>
	                   <td><%=rs.getString("total") %></td>
	               </tr>
	               
	              </tbody>
	           </table><br>
	           <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
	           
	           <% 
    	}
    %>