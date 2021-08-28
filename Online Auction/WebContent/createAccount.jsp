<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Create an Account</title>
	</head>
	<body style="background-color:#FAEAC3;">
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
		String phone_num = request.getParameter("phone");
		String address = request.getParameter("address");
		String dob = request.getParameter("dob");
		String credit_card = request.getParameter("creditcard");
		
		String insert = "INSERT INTO EndUser(name, email, password, phone, address, dob, creditcard) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setString(3, password);
		ps.setString(4, phone_num);
		ps.setString(5, address);
		ps.setString(6, dob);
		ps.setString(7, credit_card);
		
		ps.executeUpdate();
		
		con.close();
		out.print("Successfully Created an Account!");
		out.print("<br>");
		out.print("<a href='index.jsp'>Back to the Login Page</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
	%>
	</body>
</html>