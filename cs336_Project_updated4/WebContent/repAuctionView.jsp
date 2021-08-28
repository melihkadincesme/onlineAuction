<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Item List</title>
	
	<style>
	table, th, td {
	  border: 1px solid black;
	}
	</style>
	</head>
	<body style="background-color:#FAEAC3;">
	
	<h1 style="text-align:center">Auction View</h1>
	<br>
	
	
	<table style="width: 100%">
	<tr>
	    <th>Title</th> 
	    <th>Description</th>
	    <th>Initial Price</th> 
	    <th>Closing Date</th>
	    <th>Category</th>
	    <th>Highest Bid Amount</th> 
	    <th>Increment</th>
	    <th>Edit Auction</th>
	</tr>
	<%
	
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		ResultSet result_set = null;
		ResultSet rs_item = null;

		String get_item_vals = "SELECT i.itemID, i.closing_date, i.bid_amount, i.reserve, i.customer_email FROM item i";
		PreparedStatement ps_item = con.prepareStatement(get_item_vals);
		rs_item = ps_item.executeQuery();
		
		while(rs_item.next()){
			int itemID = rs_item.getInt("itemID");
			int bid_amount = rs_item.getInt("bid_amount");
			int reserve = rs_item.getInt("reserve");
			String highest_bid_email = rs_item.getString("customer_email");
			
			Timestamp t = rs_item.getTimestamp("closing_date");
			
			Date date = new Date();
			Timestamp timestamp2 = new Timestamp(date.getTime());
			int result = t.compareTo(timestamp2);
			
			if(result == -1){//time has passed
				if(reserve == 0){
					String winner = "The user " + highest_bid_email	+ " has won the auction for " + itemID + " product.";
					
					String update_value = "UPDATE customer_products SET message=? where itemID=?";
					PreparedStatement update_customer_ps = con.prepareStatement(update_value);
					
					update_customer_ps.setString(1, winner);
					update_customer_ps.setInt(2, itemID);
					update_customer_ps.executeUpdate();
				}else if(reserve > bid_amount){
					String no_winner = "No one is the winner for this auction! Reserve price is higher than the highest bid!";
					
					String update_value2 = "UPDATE customer_products SET message=? where itemID=?";
					PreparedStatement update_customer_ps2 = con.prepareStatement(update_value2);
					
					update_customer_ps2.setString(1, no_winner);
					update_customer_ps2.setInt(2, itemID);
					update_customer_ps2.executeUpdate();
				}else if(bid_amount >= reserve){
					String winner = "The user " + highest_bid_email	+ " has won the auction for " + itemID + " product.";
					
					String update_value3 = "UPDATE customer_products SET message=? where itemID=?";
					PreparedStatement update_customer_ps3 = con.prepareStatement(update_value3);
					
					update_customer_ps3.setString(1, winner);
					update_customer_ps3.setInt(2, itemID);
					update_customer_ps3.executeUpdate();
				}
			
				String update_check = "UPDATE item SET check_live=0 where itemID=?";
				PreparedStatement ps_check = con.prepareStatement(update_check);
				
				ps_check.setInt(1, itemID);
				ps_check.executeUpdate();
			}
		}
		
		//string testq = "SELECT * FROM item i where i.itemID not in (SELECT i.itemID FROM item i where i.seller_email=?)";
		String testq = "SELECT * FROM item i WHERE i.check_live=1 and i.itemID not in(SELECT i.itemID FROM item i where i.seller_email=?)";
		
		PreparedStatement ps = con.prepareStatement(testq);
		String email_address = session.getAttribute("email").toString();
		ps.setString(1, email_address);
		ps.executeQuery();
		
		//result_set = stmt.executeQuery(testq);
		result_set = ps.executeQuery();
		
		while(result_set.next()){
			//int itemID_val = result_set.getInt("itemID");
			//session.setAttribute("id", //itemID_val);
	%>
	<tr>
	<td><%=result_set.getString("title") %></td>
	<td><%=result_set.getString("description") %></td>
	<td><%=result_set.getString("initial_price") %></td>
	<td><%=result_set.getString("closing_date") %></td>
	<td><%=result_set.getString("category") %></td>
	<td><%=result_set.getString("bid_amount") %></td>
	<td><%=result_set.getString("increment") %></td> 
	<td><a href="editAuction.jsp?val=<%=result_set.getString("itemID")%>"><%=result_set.getString("title")%> Edit</a></td>
	
	</tr>
	<% 
		}
		con.close();
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</table>
	<br>
	<a href="repLogin.jsp">Back to representative dashboard</a>
	<br>
	</body>
	</html>
</html>