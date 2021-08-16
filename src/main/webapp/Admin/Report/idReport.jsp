<%@ page import ="java.sql.*" %>
<%

int item_id = Integer.parseInt(request.getParameter("id")); 
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select item_id from items where item_id='"+item_id+"';");
%>

<!DOCTYPE html>
<html>
<head>
	<title>Sales Report by Item ID</title>
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
    	<% if(!rs.first()) { %>
    		<a href='generateSalesReport.jsp'>Item does not exist in database</a>
    	<%  } else {
    		rs=st.executeQuery("select max(current_price) as total from auctions where item_id='"+item_id+"' and now()>end_date;");
    		rs.first();
        %>
         
	    	 <table>
	             <tr>
	                <th>Total Earnings For Item <%=item_id%></th>
	             </tr>
	               <tr>
	                   <td><%=rs.getString("total") %></td>
	               </tr>
	               
	           </table><br>
	           <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
	           
	           <% 
    	}
    %>
    </body>
</html>