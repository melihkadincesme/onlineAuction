<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Total Earnings and Best Buyers</title>
</head>
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
<body>
		
		<a href = 'adminLogin.jsp'>Return to dashboard</a>
		
		<h3>Total Earnings:</h3>

		<%
		List<String> list = new ArrayList<String>();
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = "SELECT sum(bid_amount) FROM item WHERE check_live = 0";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			while(result.next())
			{
				out.print("Sum of all sold auctions:  $" + result.getString(1));
			}
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Failed to find total earnings");
		}
	
		%>
		
		<h3>Best Buyers: </h3>
		
		<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();

			//
			String str = "SELECT customer_email, count(customer_email) count FROM item WHERE check_live = 0 AND customer_email IS NOT NULL GROUP BY customer_email ORDER BY count DESC";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("User email:");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Number of auctions won:");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current email:
				out.print(result.getString("customer_email"));
				out.print("</td>");
				out.print("<td>");
				//Print out number of auctions that user won
				out.print(result.getString("count"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Failed to find best buyers");
		}
	%>
	
		<h3>Best Selling Items:</h3>		
		<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();

			//
			String str = "SELECT category, count(category) count FROM item WHERE check_live = 0 AND customer_email IS NOT NULL GROUP BY category ORDER BY count DESC";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Category:");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Number of items sold:");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current email:
				out.print(result.getString("category"));
				out.print("</td>");
				out.print("<td>");
				//Print out number of auctions that user won
				out.print(result.getString("count"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Failed to find best items");
		}
	%>
</body>
</html>