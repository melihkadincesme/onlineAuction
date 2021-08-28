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
	form {
		display: inline-block;
	}
</style>
<body>
		
		<a href = 'adminLogin.jsp'>Return to dashboard</a>
		
		<h3>See earnings for:</h3>
		 <form action="earningsQuery.jsp">
    	 	<input type="submit" name="button" value="item" />
		</form>
		 <form action="earningsQuery.jsp">
    	 	<input type="submit" name="button" value="item type" />
		</form>
		 <form action="earningsQuery.jsp">
    	 	<input type="submit" name="button" value="all users" />
		</form>
		<br> <br>
		 <form method="get" action="earningsQuery.jsp">
		 	Search for user by email: <input type="text" name = "button">
		 	<input type="submit" value="Search"> 	
		 </form>
		 
		 
		 
		<%
		List<String> list = new ArrayList<String>();
		
		String query = request.getParameter("button");

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "";
			
			if (query.equals("item")) {//Find total earnings for items
				str = "SELECT title, sum(bid_amount) earnings FROM item WHERE check_live = 0 AND customer_email IS NOT NULL GROUP BY title ORDER BY earnings DESC";
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<table>");
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Item");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Earnings:");
				out.print("</td>");
				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current email:
					out.print(result.getString("title"));
					out.print("</td>");
					out.print("<td>");
					//Print out number of auctions that user won
					out.print(result.getString("earnings"));
					out.print("</td>");
					out.print("</tr>");

				}
				out.print("</table>");
			}
			else if (query.equals("item type")) {//Find total earnings by item type/category
				str = "SELECT category, sum(bid_amount) earnings FROM item WHERE check_live = 0 AND customer_email IS NOT NULL GROUP BY category ORDER BY earnings DESC";
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<table>");
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Item category");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Earnings:");
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
					out.print(result.getString("earnings"));
					out.print("</td>");
					out.print("</tr>");

				}
				out.print("</table>");				
			}
			else if (query.equals("all users")) {//Find earnings for all users
				str = "SELECT seller_email, sum(bid_amount) earnings FROM item WHERE check_live = 0 AND customer_email IS NOT NULL GROUP BY seller_email ORDER BY earnings DESC";
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<table>");
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Seller email:");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Earnings:");
				out.print("</td>");
				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current email:
					out.print(result.getString("seller_email"));
					out.print("</td>");
					out.print("<td>");
					//Print out number of auctions that user won
					out.print(result.getString("earnings"));
					out.print("</td>");
					out.print("</tr>");

				}
				out.print("</table>");						
			}
			else {//Search specific user
				String email = query;
				str = "SELECT seller_email, sum(bid_amount) earnings FROM item WHERE check_live = 0 AND seller_email = '" + email + "'";
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<table>");
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Seller email:");
				out.print("</td>");
				//make a column
				out.print("<td>");
				out.print("Earnings:");
				out.print("</td>");
				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current email:
					out.print(result.getString("seller_email"));
					out.print("</td>");
					out.print("<td>");
					//Print out number of auctions that user won
					out.print(result.getString("earnings"));
					out.print("</td>");
					out.print("</tr>");

				}
				out.print("</table>");			
			}
		
			
			
		} catch (Exception e) {
			
		}
	
		%>
</body>
</html>