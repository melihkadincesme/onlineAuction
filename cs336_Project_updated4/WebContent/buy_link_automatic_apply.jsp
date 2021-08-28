<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Automatic Button</title>
	</head>
	<body style="background-color:#FAEAC3;">
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		ResultSet result_set_customer = null;
		ResultSet rs_title_date = null;
		
		String email = session.getAttribute("email").toString();
		int itemID = Integer.parseInt(request.getParameter("val2"));

		ResultSet rs_item = stmt.executeQuery("SELECT * FROM item i WHERE i.itemID=" + itemID + ";");
		rs_item.next();
		
		int current_bid = rs_item.getInt("bid_amount");
		int int_price = rs_item.getInt("initial_price");
		int increment = rs_item.getInt("increment");
		//String title = rs_item.getString("title");
		
		String get_title_date = "SELECT i.title, i.closing_date FROM item i where i.itemID=?";
		PreparedStatement ps1 = con.prepareStatement(get_title_date);
		ps1.setInt(1, itemID);
		rs_title_date = ps1.executeQuery();
		
		int new_price = 0;
		
		ResultSet rs_highest_bid = stmt.executeQuery("SELECT a.customer_inc, a.upper_limit FROM AutomaticBids a where a.item_ID=" + itemID + ";");
		rs_highest_bid.next();
		
		int customer_inc = rs_highest_bid.getInt("customer_inc");
		int upper_limit = rs_highest_bid.getInt("upper_limit");
		
		if(customer_inc == 0){
			out.print("Please first set an increment amount!");
			customer_inc = increment;
		}

		if(current_bid == 0){
			new_price = int_price+1;
		}else{
			new_price = current_bid + customer_inc;
		}
		
		String get_result = "SELECT c.customer_email, c.itemID from customer_products c where c.customer_email=? and itemID=?";
		PreparedStatement ps_get_result = con.prepareStatement(get_result);
		ps_get_result.setString(1, email);
		ps_get_result.setInt(2, itemID);
		result_set_customer = ps_get_result.executeQuery();
		
		if(current_bid > upper_limit){
			out.print("Cannot bid because current bid is higher than the upper limit!");
			out.print("<br>");
			out.print("<a href='buyItem.jsp'>Back to the list of items</a>");
			return;
		}else if(new_price > upper_limit){
			out.print("Incremented price is larger than upper limit!");
			out.print("<br>");
			out.print("<a href='buyItem.jsp'>Back to the list of items</a>");
			return;
		}else{
			String update_bid = "UPDATE item i SET bid_amount=?, customer_email=? where i.itemID=?";
			PreparedStatement ps_bid = con.prepareStatement(update_bid);
			
			ps_bid.setInt(1, new_price);
			ps_bid.setString(2, email);
			ps_bid.setInt(3, itemID);
			ps_bid.executeUpdate();
			
			//alert other buyers that someone has bid higher using automatic bidding
			while(rs_title_date.next()){
				String title = rs_title_date.getString("title");
				String close_date = rs_title_date.getString("closing_date");

				if(result_set_customer.next() == false){ //if the user is bidding first time on the item
					String insert_customer = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date) VALUES (?, ?, ?, now(), ?)";
					PreparedStatement ps_insert_customer = con.prepareStatement(insert_customer);
					
					ps_insert_customer.setString(1, email);
					ps_insert_customer.setInt(2, itemID);
					ps_insert_customer.setString(3, title);
					ps_insert_customer.setString(4, close_date);
					
					ps_insert_customer.executeUpdate();
					
					String highest_bid = "The user " + email + " has the highest bid by automatic auction of $" + new_price + ".";
					
					String update_customer_table = "UPDATE customer_products SET message=? where itemID=?";
					PreparedStatement ps_update_cust = con.prepareStatement(update_customer_table);
					
					ps_update_cust.setString(1, highest_bid);
					ps_update_cust.setInt(2, itemID);
					
					ps_update_cust.executeUpdate();
				}else{
					String highest_bid = "The user " + email + " has the highest bid by automatic auction of $" + new_price + ".";

					String update_customer_table = "UPDATE customer_products SET message=? where itemID=?";
					PreparedStatement ps_update_cust = con.prepareStatement(update_customer_table);
					
					ps_update_cust.setString(1, highest_bid);
					ps_update_cust.setInt(2, itemID);
					
					ps_update_cust.executeUpdate();
				}
			}
		}
		
		out.print("Successfully biddedd on Automatic Auction!");
		out.print("<br>");
		out.print("<a href='buyItem.jsp'>Back to the list of items</a>");
		con.close();
		
	}catch(Exception ex){
		out.print(ex);
		out.print("Automatic Bid Failed!");
	}
	%>
	
	</body>
</html>