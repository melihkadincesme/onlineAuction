<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Submit Answer</title>
</head>
<style>
	body{
		background-color:#FAEAC3;
	}
</style>
<body>

	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String desc = request.getParameter("description");
		String postnum = request.getParameter("postnum");
		
		
		String update = "UPDATE questions set atext = ? where postnum = " + postnum ;
		
		PreparedStatement ps = con.prepareStatement(update);
		
		ps.setString(1, desc);
		
		ps.executeUpdate();
		
		con.close();
		out.println("Answer successfully added!");
	}catch (Exception ex) {
		out.print(ex);
		out.print("insert answer failed");
	}
	%>
	<form action = "questions.jsp">
		<button name="repFunc" type="submit" value="true">Return to questions</button>	 
	</form>

</body>
</html>