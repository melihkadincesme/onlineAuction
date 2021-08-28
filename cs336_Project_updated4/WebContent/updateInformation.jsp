<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Information</title>
<style>
	body{
		background-color:#FAEAC3;
	}
</style>
</head>
<body>

<%

 	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String name = request.getParameter("name");
		String email = (String)session.getAttribute("uemail");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String dob = request.getParameter("dob");
		String credit = request.getParameter("creditcard");
		
		String update = "";
		if (!"".equals(name)) {
			update = "UPDATE EndUser set name = '" +name+ "' where email = '" +email+ "'";
			stmt.executeUpdate(update);
		}
		if (!"".equals(password)) {
			update = "UPDATE EndUser set password = '" +password+ "' where email = '" +email+ "'";
			stmt.executeUpdate(update);
		}
		if (!"".equals(phone)) {
			update = "UPDATE EndUser set phone = '" +phone+ "' where email = '" +email+ "'";
			stmt.executeUpdate(update);
		}
		if (!"".equals(address)) {
			update = "UPDATE EndUser set address = '" +address+ "' where email = '" +email+ "'";
			stmt.executeUpdate(update);
		}
		if (!"".equals(dob)) {
			update = "UPDATE EndUser set dob = '" +dob+ "' where email = '" +email+ "'";
			stmt.executeUpdate(update);
		}
		if (!"".equals(credit)) {
			update = "UPDATE EndUser set creditcard = '" +credit+ "' where email = '" +email+ "'";
			stmt.executeUpdate(update);
		}
		
		
		
		con.close();
		out.println("Successfully changed!");
		out.println("<a href = 'userInformation.jsp'>Return to previous page</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("update failed");
	} 

	%>
</body>
</html>

