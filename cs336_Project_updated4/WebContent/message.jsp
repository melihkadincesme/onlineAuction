<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Message</title>
	
	<style>
	table, th, td {
	  border: 1px solid black;
	}
	</style>
	</head>
	<body style="background-color:#FAEAC3;">
	
	<h1 style="text-align:center">Message InBox for <%=session.getAttribute("email").toString()%> </h1>
	
	<table style="width: 100%">
	<tr>
	    <th>Title</th> 
	    <th>ItemID</th>
	    <th>Message</th>
	    <th>Timestamp</th>
	</tr>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		ResultSet result_set = null;
		 
		String customer_email = session.getAttribute("email").toString();

		String data_values = "SELECT c.title, c.itemID, c.message, c.created_date FROM customer_products c WHERE c.customer_email = ?";
		PreparedStatement ps = con.prepareStatement(data_values);
		
		ps.setString(1, customer_email);
		result_set = ps.executeQuery();
		
		while(result_set.next()){
	%>
		<tr>
		<td><%=result_set.getString("title") %></td>
		<td><%=result_set.getString("itemID") %></td>
		<td><%=result_set.getString("message") %></td>
		<td><%=result_set.getTimestamp("created_date") %></td>
		</tr>
	<%		
		}
		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display Messages!");
	}
	
	%>
	</table>
	<br>
	<a href="buyItem.jsp">List of Items</a>
	<br>
	<a href="success.jsp">Home Page</a>
	</body>
</html>