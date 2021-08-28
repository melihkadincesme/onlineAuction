<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Create Representative Account</title>
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
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		String insert = "INSERT INTO Customer_Rep(name, email, password) VALUES (?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setString(3, password);

		
		ps.executeUpdate();
		
		con.close();
		out.println("Successfully Created an Account!");
		out.println("<a href = 'adminLogin.jsp'>Return to dashboard</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
	%>
	</body>
</html>