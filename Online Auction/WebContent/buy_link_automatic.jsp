<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Automatic Auction</title>
	</head>
	<body style="background-color:#FAEAC3;">
	<% 
	try{
	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
	
		ResultSet result_set = null;
		int id = Integer.parseInt(request.getParameter("val1"));
		//String id = request.getParameter("val");

		String test_val = "SELECT * FROM item i WHERE i.itemID=?";
		PreparedStatement ps = con.prepareStatement(test_val);
		
		ps.setInt(1, id);
		//ps.setString(1, id);
		
		result_set=ps.executeQuery();
		
		
		while(result_set.next()){
	%>
	
	<form method="get" action="ConfirmAutomaticAuction.jsp">
	<table>
		<tr>
			<td><h1 style="text-align:center"><%=result_set.getString("title") %></h1></td>	
		</tr>
		<tr>
			<td>If you want to increment your bid with another amount, please enter higher increment. Otherwise, enter the seller's increment amount.</td>
		</tr>
		<tr>
			<td><b>ItemID: </b><%=result_set.getInt("itemID") %></td>
		</tr>
		<tr>
			<td><b>Description: </b><%=result_set.getString("description") %></td>
		</tr>
		<tr>
			<td><b>Closing Date: </b><%=result_set.getString("closing_date") %></td>
		</tr>
		<tr>
			<td><b>Initial Price: </b><%=result_set.getString("initial_price") %></td>
		</tr>
		<tr>
			<td><b>Current Bid: </b><%=result_set.getString("bid_amount") %></td>
		</tr>
		<tr>
			<td><b>Category: </b><%=result_set.getString("category") %></td>
		</tr>
		<tr>
			<td><b>Upper Limit Price: </b></td><td><input type="text" name="upper_limit"></td>
		</tr>
		<tr>
			<td><b>Customer increment: </b></td><td><input type="text" name="cust_inc"></td>
		</tr>
		<input type="hidden" name="itemID" value="<%=id%>">
	</table>
		<input type="submit" value="Submit">	
	</form>
	<%
		}
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</body>
</html>