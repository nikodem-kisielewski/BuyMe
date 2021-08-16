<%@ page import ="java.sql.*" %>
<%

String seller = (request.getParameter("seller")); 
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select username from users where username='"+seller+"';");

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

<%
    	if(!rs.first()){
    		  %><a href='generateSalesReport.jsp'>User does not exist in database</a><% 
    	}
    	else{
    		rs=st.executeQuery("select max(final_price) as total from sold where seller='"+seller+"' and buyer <> ''");
    		rs.first();
        		   %>
	    	 <table>
	             <tr>
	                <th>Total Earnings For User  <%=seller%></th>
	             </tr>
	               <tr>
	                   <td><%=rs.getString("total") %></td>
	               </tr>
	              </tbody>
	           </table><br>
	           <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
	           
	           <% 
    	}
    %>
    </body>
    </html>