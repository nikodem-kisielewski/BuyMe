<!DOCTYPE html>
<html>
<head>
    <title>Jsp Sample</title>
    <%@page import="java.sql.*;"%>
</head>
<body bgcolor=yellow>
    <%
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=(Connection)DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/BuyMe","root","rootpass");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from users;");
    %><table border=1 align=center style="text-align:center">
      <thead>
          <tr>
             <th>Username</th>
             <th>Password</th>
             <th>Name</th>
             <th>Account Type</th>
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
                <td><%=rs.getString("acct_type") %></td>
            </tr>
            <%}%>
           </tbody>
        </table><br>
        st.close();
        rs.close();
    <%}
    catch(Exception e){
        out.print(e.getMessage());%><br><%
    }
    %>
</body>
</html>

<!--executeUpdate() mainupulation and executeQuery() for retriving-->