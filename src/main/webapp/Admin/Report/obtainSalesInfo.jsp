<%@ page import ="java.sql.*" %>
<%
    String specification = request.getParameter("specification");  
	if(specification==null){
		%><h2> Please Choose a Specification</h2><%
	}
	else if(specification.equals("item_id")){
		%>
		  <h3>Enter Item ID</h3>
		     <form action="idReport.jsp" method="POST">
		       <input type="text" name="id"/> <br/>
		       <input type="submit" value="Submit"/>
		     </form>
		     <% 
	}
	else if(specification.equals("item_type")){
		%>
		  <h3>Choose Item Type</h3>
		     <form action="typeReport.jsp" method="POST">
			<input type="radio" id="shirt" name="type" value="shirt">
      		<label for="buyer">Shirt</label><br>
        	<input type="radio" id="seller" name="type" value="pants">
       		 <label for="seller">Pants</label><br>
       		 <input type="radio" id="buyer" name="type" value="footwear">
       		 <label for="buyer">Footwear</label><br>
			<br>
		       <input type="submit" value="Submit"/>
		     </form>
		     <% 
	}
	else{
		%>
		  <h3>Enter Seller Username</h3>
		      <form action="sellerReport.jsp" method="POST">
		       <input type="text" name="seller"/> <br/>
		       <input type="submit" value="Submit"/>
		     </form>
		     <% 
	}
%>
	<a href='generateSalesReport.jsp'>Go back to Generate Sales Report Page</a>
		
	