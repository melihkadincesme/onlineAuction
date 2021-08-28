<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Customer Rep Login</title>
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
			  Welcome Representative <%=session.getAttribute("email")%>
		<br> 
		</h3>
		<%
			}
		%>
		
		<h3>Remove bid</h3>
		<h3>Remove Auction</h3>
		<h3>Edit User Account Information</h3>
		 <form method="get" action="userInformation.jsp">
		 	<table>
		 		<tr>
		 			<td>Enter User Email: </td><td><input type="text" name = "email"></td>
		 		</tr>
		 	</table>
		 	<input type="submit" value="Submit">	 	
		 </form>
		 <br> <br>
		 <form method="get" action="questions.jsp">
			<button name="repFunc" type="submit" value="true">View user questions</button>
		 </form>
		 <br>
		 <form method="get" action="repAuctionView.jsp">
			<button name="repFunc" type="submit" value="true">View auctions</button>
		 </form>
		 <br>	 
		
		 
		<a href='logout.jsp'>Log out</a>
	</body>
</html>