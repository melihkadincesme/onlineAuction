<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Account</title>
<style>
	body{
		background-color:#FAEAC3;
	}
</style>
</head>
<body>

		<%
		List<String> list = new ArrayList<String>();
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String email = (String)session.getAttribute("uemail");

			String del = "DELETE FROM EndUser WHERE email = '" + email + "'";
			
			stmt.executeUpdate(del);


			//close the connection.
			con.close();
			out.println("Successfully deleted account!");
			out.println("<a href = 'repLogin.jsp'>Return to dashboard</a>");
		}catch (Exception ex) {
			out.print(ex);
			out.print("delete failed");
		} 
	
		%>

</body>
</html>