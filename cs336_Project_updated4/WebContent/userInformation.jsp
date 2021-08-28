<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit/update user information</title>
<style>
	body{
		background-color:#FAEAC3;
	}
	table, td {
  		border: 1px solid black;
  		font-size: 20px;
  		padding: 5px;
  		border-collapse: collapse;
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
			
			String entity = request.getParameter("email");
			if (entity == null) {
				entity = (String)session.getAttribute("uemail");
			}
			session.setAttribute("uemail",entity);
			//
			String str = "SELECT * FROM EndUser WHERE email = '" + entity + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Email");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Password");
			out.print("</td>");
			//
			out.print("<td>");
			out.print("Phone Number");
			out.print("</td>");
			//
			out.print("<td>");
			out.print("Address");
			out.print("</td>");
			//
			out.print("<td>");
			out.print("Date of birth");
			out.print("</td>");
			//
			out.print("<td>");
			out.print("Credit card number");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out name:
				out.print(result.getString("name"));
				out.print("</td>");
				out.print("<td>");
				//Print out email:
				out.print(result.getString("email"));
				out.print("</td>");
				out.print("<td>");
				//Print out password
				out.print(result.getString("password"));
				out.print("</td>");
				out.print("<td>");
				//Print out phone number
				out.print(result.getString("phone"));
				out.print("</td>");
				out.print("<td>");
				//Print address
				out.print(result.getString("address"));
				out.print("</td>");
				out.print("<td>");
				//print dob
				out.print(result.getString("dob"));
				out.print("</td>");
				out.print("<td>");
				//print credit card info
				out.print(result.getString("creditcard"));
				out.print("</td>");
				out.print("</tr>");
				out.print("</tr>");
			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	
		%>
		
		<h3>Edit User Account Information</h3>
		 	<form method="post" action="updateInformation.jsp">
		 		<table>
		 			<tr>
		 				<td>Name: </td><td><input type="text" name = "name"></td>
		 			</tr>
		 			<tr>
		 				<td>Password: </td><td><input type="text" name = "password"></td>
		 			</tr>
		 			<tr>
		 				<td>Phone Number: </td><td><input type="text" name = "phone"></td>
		 			</tr>
		 			<tr>
		 				<td>Address: </td><td><input type="text" name = "address"></td>
		 			</tr>
		 			<tr>
		 				<td>Date of Birth: </td><td><input type="text" name = "dob"></td>
		 			</tr>
		 			<tr>
		 				<td>Credit Card: </td><td><input type="text" name = "creditcard"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" name="action" value="Update"> 		 	
		 	</form>
		 	<br>
		 	
		 <form action="deleteUser.jsp">
    	 	<input type="submit" value="Delete User" />
		 </form>		 	
		 	
		 	<% out.println("<a href = 'repLogin.jsp'>Return to dashboard</a>"); %>
</body>
</html>