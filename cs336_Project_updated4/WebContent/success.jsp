<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Success</title>
	</head>
	<body style="background-color:#FAEAC3;">
		<%
			if((session.getAttribute("email") == null)){
		%>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<%} else{
		%>
		<h1 style="text-align:center">Welcome to the Online Auction System!</h1>
		<br>
			<%
			if(session.getAttribute("email").equals("admin@gmail.com")){ //you can create a seperate page for admin
			%>
				Admin have Successfully Logged in!
				<br>
			<%
			
			  }else{%>
			<h3> <%=session.getAttribute("email")%> have Successfully Logged in!</h3>
			  <br>
			  <br>
			  To view your profile, please follow the link below.
			  <br>
			  <a href='MyProfile.jsp'>My Profile</a>
			  <br>
			  <br>
			  To sell an item and to start an auction, please follow the link below.
			  <br>
			  <a href='sellItem.jsp'>Sell an Item</a>
			  <br>
			  <br>
			  To buy an item, please follow the link below.
			  <br>
			  <a href='buyItem.jsp'>Buy an Item</a>
			  <br>
			  <br>
			  Manage your items' availability 
			  <br>
			  <a href='manageItem.jsp'>Manage items</a>
			  <br>
			  <br>
			  <h3>Have a question or looking for answers?</h3>
		      <form action="questions.jsp">
    	 	  	   <input type="submit" value="Go to questions" />
			  </form>
			  
			  <%
			  }
			  %>
		
		<br> 
		<h3><a href='logout.jsp'>Log out</a></h3>
		
		<%
			}
		%>
	</body>
</html>