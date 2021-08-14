<!DOCTYPE html>
 <%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Auctions You Participated In</title>
   
</head>
<body bgcolor=white>
    <%  Class.forName("com.mysql.jdbc.Driver");
  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BuyMe","root", "rootpass");
        Statement st=con.createStatement();
        String username=session.getAttribute("user").toString();
        ResultSet rs=st.executeQuery("select distinct auction_id from auctions natural join bidOn where username='" + username+"'");
        %>
        
        <table border=1 style="text-align:center">
      <thead>
          <tr>
             <th>Auction ID</th>
             <!--   <th>Current Highest Bid</th>--> 
               
              <!--   <th>Start Date</th>--> 
               <!--     <th>End Date</th>--> 
          </tr>
      </thead>
      <tbody>
      
        <%while(rs.next())
        {
            %>
            <tr>
                <td><%=rs.getString("auction_id") %></td>
              <!--  <td><%=rs.getString("m") %></td>--> 
                
            <!--    <td><%=rs.getString("start_date") %></td>--> 
           <!--      <td><%=rs.getString("end_date") %></td>--> 
            
            </tr>
            <%}%>
           </tbody>
        </table><br>
       <a href='endProfile.jsp'>Go back to Your Profile Page</a>
        <%con.close();%>
</body>
