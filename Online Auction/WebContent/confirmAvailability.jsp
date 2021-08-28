<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Confirm Availability</title>
	</head>
	<body style="background-color:#FAEAC3;">
	
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String category = request.getParameter("category1");
		int itemID = Integer.parseInt(request.getParameter("itemID"));
		
		String update = "update item set available=? where itemID=?";
		PreparedStatement ps_updt = con.prepareStatement(update);
		
		if(category.equals("Available")){
			ps_updt.setInt(1, 1);
			ps_updt.setInt(2, itemID);
			ps_updt.executeUpdate();

		}else if(category.equals("Not Available")){
			int zero = 0;
			ps_updt.setInt(1, zero);
			ps_updt.setInt(2, itemID);
			ps_updt.executeUpdate();

		}

		out.print("Successfully changed the Status of your item");
		out.print("<br>");
	%>
		<br>
		<a href="success.jsp">Home Page</a>
		<br>
		<a href="manageItem.jsp">Check your Item's Availability</a>
	<% 		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	
	</body>
</html>