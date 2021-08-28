<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Manage Items</title>
	<style>
	table, th, td {
	  border: 1px solid black;
	}
	</style>
	</head>
	<body style="background-color:#FAEAC3;">
	<h1 style="text-align:center">Manage your Items' Availability</h1>
	
	<table style="width: 100%">
	<tr>
		<th>Check Availability</th> 
	    <th>Title</th> 
	    <th>ItemID</th>
	    <th>Initial Price</th> 
	    <th>Current Status</th>
	</tr>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		ResultSet rs_val = null;
		String email = session.getAttribute("email").toString();
		
		String get_val = "SELECT i.title, i.itemID, i.initial_price, i.available FROM item i where i.seller_email=? and i.check_live=1";
		PreparedStatement ps_val = con.prepareStatement(get_val);
		
		ps_val.setString(1, email);
		rs_val = ps_val.executeQuery();
		
		while(rs_val.next()){
	%>
	<tr>
	<td><a href="check_itemAval.jsp?val=<%=rs_val.getString("itemID")%>"><button>Manage Availability</button></a></td>
	<td><%=rs_val.getString("title") %></td>
	<td><%=rs_val.getString("itemID") %></td>
	<td><%=rs_val.getString("initial_price") %></td>
	<%
		if(rs_val.getInt("available") == 1){
			out.print("<td>Available</td>");
		}else{
			out.print("<td>Not Available</td>");
		}
	%>		
	
	<% 		
		}

	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</table>
	<br>
	<a href="success.jsp">Home Page</a>
	</body>
</html>