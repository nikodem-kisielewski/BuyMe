<%@ page import ="java.sql.*" %>
<%

String seller = (request.getParameter("seller")); 
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select username from users where username='"+seller+"';");
    	if(!rs.first()){
    		  %><a href='generateSalesReport.jsp'>User does not exist in database</a><% 
    	}
    	else{
    		rs=st.executeQuery("select max(current_price) as total from auctions where seller='"+seller+"' and now()>end_date;");
    		rs.first();
        		   %>
	    	 <table border=1 style="text-align:center">
	         <thead>
	             <tr>
	                <th>Total Earnings For User  <%=seller%></th>
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