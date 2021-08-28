<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Submit Question</title>
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
		
		String title = request.getParameter("title");
		String desc = request.getParameter("description");
		String email = (String)session.getAttribute("email");
		
		
		String insert = "INSERT INTO questions(cemail, title, qtext) VALUES (?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		ps.setString(1, email);
		ps.setString(2, title);
		ps.setString(3, desc);
		
		ps.executeUpdate();
		
		con.close();
		out.println("Added Question! Wait for a customer representative to answer.");
		out.println("<a href = 'questions.jsp'>Return to questions</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("insert question failed");
	}
	%>

</body>
</html>