<!DOCTYPE html>
<html>
<head>
    <title>List Of Customer Representatives</title>
    <%@ page import ="java.sql.*" %>
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from users where acct_type=" +"'rep';");%>
        
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
       <a href='../adminMain.jsp'>Go back to Admin Main Page</a>
        <%con.close();%>
</body>
