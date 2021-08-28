<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Admin Login</title>
	</head>
	<body style="background-color:#FAEAC3;">
		<%
			if((session.getAttribute("email") == null)){
		%>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<%} else{
		%>
		<h3>  
			  Welcome Admin!
		<br> 
		</h3>
		<%
			}
		%>
		
		<h3>Create a new customer representative account</h3>
		 	<form method="get" action="createRepAccount.jsp">
		 		<table>
		 			<tr>
		 				<td>Name</td><td><input type="text" name = "name"></td>
		 			</tr>
		 			<tr>
		 				<td>Email</td><td><input type="text" name = "email"></td>
		 			</tr>
		 			<tr>
		 				<td>Password</td><td><input type="password" name = "password"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		 	</form>
		 <br> 
		 
		 <h3>Generate sales reports for:</h3>
		 <form action="totalEarnings.jsp">
    	 	<input type="submit" value="Total earnings, best buyers, best selling items" />
		</form>
		<br>
		 <form action="earningsQuery.jsp">
    	 	<input type="submit" value="Earnings per item, item type, user" />
		</form>
		<br>
		
		 	
		<a href='logout.jsp'>Log out</a>		 	
	</body>
</html>