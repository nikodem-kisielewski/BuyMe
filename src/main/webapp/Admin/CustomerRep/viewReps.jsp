<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>List Of Customer Representatives</title>
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
<h1>List of Customer Representatives</h1>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from users where acct_type=" +"'rep';");%>
        
        <table>
          <tr>
             <th>Username</th>
              <th>Password</th>
               <th>Name</th>
          </tr>
      
        <%while(rs.next())
        {
            %>
            <tr>
                <td><%=rs.getString("username") %></td>
                <td><%=rs.getString("password") %></td>
                <td><%=rs.getString("name") %></td>
            
            </tr>
            <%}%>
           </tbody>
        </table><br>
       <a href='../adminMain.jsp'>Go back to Admin Main Page</a>
        <%con.close();%>
</body>
