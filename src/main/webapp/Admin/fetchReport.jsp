<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
    <%@ page import ="java.sql.*" %>
</head>
<body bgcolor=white>
    <% 	String userid = request.getParameter("data_type");   
        Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select sum(final_price) as total from sold;");%>
        
        <table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Total</th>
      
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
       <a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
        <%con.close();%>
</body>
