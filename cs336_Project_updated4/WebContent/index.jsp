<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>cs336 Project</title>
	</head>
	
	<body style="background-color:#FAEAC3;">
	
		<h1 style="text-align:center">Welcome to the Online Auction System!</h1>
		
		<br>
		<br>
			<h3>Create an Account</h3>
		 	<form method="get" action="createAccount.jsp">
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
		 			<tr>
		 				<td>Phone Number</td><td><input type="text" name = "phone"></td>
		 			</tr>
		 			<tr>
		 				<td>Address</td><td><input type="text" name = "address"></td>
		 			</tr>
		 			<tr>
		 				<td>Date of Birth</td><td><input type="text" name = "dob"></td>
		 			</tr>
		 			<tr>
		 				<td>Credit Card Number</td><td><input type="text" name = "creditcard"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		 	</form>
		<br>
		<br>
			<h3>Login</h3>
			<form method="get" action="loginPage.jsp">
		 		<table>
		 			<tr>
		 				<td>Email</td><td><input type="text" name = "email"></td>
		 			</tr>
		 			<tr>
		 				<td>Password</td><td><input type="password" name = "password"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		 	</form>
	</body>
</html>