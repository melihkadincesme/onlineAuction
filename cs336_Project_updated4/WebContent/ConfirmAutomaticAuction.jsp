<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Confirm Automatic Auction</title>
	</head>
	<body style="background-color:#FAEAC3;">
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		ResultSet rs_seller_inc = null;
	
		String email = session.getAttribute("email").toString();
		int itemID = Integer.parseInt(request.getParameter("itemID"));
		int upperLimit = Integer.parseInt(request.getParameter("upper_limit"));
		int cust_inc = Integer.parseInt(request.getParameter("cust_inc"));

		String seller_inc = "SELECT i.increment, i.initial_price, i.bid_amount FROM item i WHERE i.itemID=?";
		PreparedStatement ps_inc = con.prepareStatement(seller_inc);
		ps_inc.setInt(1, itemID);
		rs_seller_inc = ps_inc.executeQuery();
		//rs_seller_inc.next();
		
		//int inc_seller = rs_seller_inc.getInt(1);

		String qr = "SELECT count(*) FROM AutomaticBids a where a.email=? and a.item_id=?";
		PreparedStatement ps = con.prepareStatement(qr);
		
		ps.setString(1, email);
		ps.setInt(2, itemID);
		rs = ps.executeQuery();
		rs.next();
		
		int count=rs.getInt(1);
		
		String insert = "INSERT INTO AutomaticBids(email, item_id, upper_limit, customer_inc) VALUES (?, ?, ?, ?)";

		int currentBid = 0;
		while(rs_seller_inc.next()){
			int inc_seller = rs_seller_inc.getInt("increment");
			int int_price = rs_seller_inc.getInt("initial_price");
			currentBid = rs_seller_inc.getInt("bid_amount");
			
			if(count > 0){
				if(upperLimit < int_price){
					out.println("Insert Failed! Secret upper limit is less than the initial price.");
					return;
				}else if(cust_inc < inc_seller){
					out.println("Your increment value is less than is less than seller's increment value!");
					String update_val1 = "UPDATE AutomaticBids a SET a.upper_limit=" + Integer.toString(upperLimit) + ", a.customer_inc=" + inc_seller + " WHERE a.email= '" + email + "' and a.item_id=" + itemID + ";";
					stmt.executeUpdate(update_val1);
					out.println("Secret Upper Limit inserted with seller's bid increment!");
					return;
				}
				String update_val = "UPDATE AutomaticBids a SET a.upper_limit=" + Integer.toString(upperLimit) + ", a.customer_inc=" + cust_inc + " WHERE a.email= '" + email + "' and a.item_id=" + itemID + ";";
	
				stmt.executeUpdate(update_val);
			}else{
				PreparedStatement ps1 = con.prepareStatement(insert);
				
				ps1.setString(1, email);
				ps1.setInt(2, itemID);
				ps1.setInt(3, upperLimit);
				ps1.setInt(4, cust_inc);
				
				ps1.executeUpdate();
			}
		}
		try {
			String update_bid = "UPDATE item i SET bid_amount=?, customer_email=? where i.itemID=?";
			PreparedStatement ps_bid = con.prepareStatement(update_bid);
			
			ps_bid.setInt(1, cust_inc + currentBid);
			ps_bid.setString(2, email);
			ps_bid.setInt(3, itemID);
			ps_bid.executeUpdate();
		} catch (Exception ex) {
			out.print(ex);
			out.print("Failed to bid on an item!");
		}
		con.close();
		out.print("Successfully Set an Upper Limit!");
		out.print("<br>");
		out.print("<a href='success.jsp'>Back to the Main Page</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
	%>
	</body>
</html>