<%@ page import ="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<title>Add a Similar Shirt</title>
	</head>
</html>

<%
// Get all of the parameters that the user entered
String itemID = request.getParameter("itemID");

System.out.println(itemID);

%>