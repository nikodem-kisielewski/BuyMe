<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>List Of End Users</title>
   
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from users where acct_type=" +"'end';");%>
        
        <table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Username</th>
              <th>Password</th>
               <th>Name</th>
          </tr>
      </thead>
      <tbody>
      
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
       <a href='repMain.jsp'>Go back to Customer Representative Page</a>
        <%con.close();%>
</body>
