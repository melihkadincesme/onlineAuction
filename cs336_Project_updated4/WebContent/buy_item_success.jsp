<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>bid success</title>
	</head>
	<body style="background-color:#FAEAC3;">
	
	<%
	int count = 0;
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		ResultSet result_set = null;
		ResultSet result_set2 = null;
		ResultSet result_set_customer = null;
		ResultSet result_set_closingDate = null;
		ResultSet rs = null;
		
		int bid_amount = Integer.parseInt(request.getParameter("bid_amount"));
		int id = Integer.parseInt(request.getParameter("itemID"));
		String customer_email = session.getAttribute("email").toString();
		
		//gets the title from item table
		String unique_title = "SELECT i.title FROM item i where i.itemID=?";
		PreparedStatement ps3 = con.prepareStatement(unique_title);
		ps3.setInt(1, id);
		result_set2 = ps3.executeQuery();
		
		//gets the bid amount and initial price specified to a specific itemID
		String get_bid ="SELECT bid_amount, initial_price, customer_email FROM item WHERE itemID=?";
		PreparedStatement ps1 = con.prepareStatement(get_bid);
		ps1.setInt(1, id);
		result_set = ps1.executeQuery();
		
		String get_closing_date = "SELECT i.closing_date FROM item i WHERE i.itemID = ?";
		PreparedStatement ps_closingDate = con.prepareStatement(get_closing_date);
		ps_closingDate.setInt(1, id);
		result_set_closingDate = ps_closingDate.executeQuery();
		
		//check if customer_products table is empty for the specified itemID and customer_email
		String get_result = "SELECT c.customer_email, c.itemID from customer_products c where c.customer_email=? and itemID=?";
		PreparedStatement ps_get_result = con.prepareStatement(get_result);
		ps_get_result.setString(1, customer_email);
		ps_get_result.setInt(2, id);
		result_set_customer = ps_get_result.executeQuery();
		
		while(result_set.next() && result_set2.next() && result_set_closingDate.next()){
			int highest_bid = result_set.getInt("bid_amount");
			int initial_price = result_set.getInt("initial_price");
			String exLeader = result_set.getString("customer_email");
			String title1 = result_set2.getString("title");
			String get_closingDate_val = result_set_closingDate.getString("closing_date");
			
			if(bid_amount <= highest_bid || bid_amount < initial_price){
				out.print("You cannot bid because your bid amount is less than the highest bid or you requested a bid that is less than the initial price!");
			}else{
				//insert data into item
				String update_item = "UPDATE item SET bid_amount=?, customer_email=? where itemID=?";
				
				PreparedStatement ps = con.prepareStatement(update_item);
				
				ps.setInt(1, bid_amount);
				ps.setString(2, customer_email);
				ps.setInt(3, id);
				ps.executeUpdate();
				
				//add the functionality of duplicate
				//
				//
				
				String insertMessage = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
				PreparedStatement insertPS = con.prepareStatement(insertMessage);
			
				//inform ex bidder of LOSS
				if (exLeader != null) {
					insertPS.setString(1, exLeader);
					insertPS.setInt(2, id);
					insertPS.setString(3, title1);
					insertPS.setString(4, get_closingDate_val);
					insertPS.setString(5, "Your bid for item " + id + " has been outbid by " + customer_email);
					
					insertPS.executeUpdate();	
				}
				
				
				insertPS.setString(1, customer_email);
				insertPS.setInt(2, id);
				insertPS.setString(3, title1);
				insertPS.setString(4, get_closingDate_val);
				insertPS.setString(5, "You are now the leading bidder for item " + id);
				
				insertPS.executeUpdate();
				
				boolean outbid = false;
				boolean doThis = true;
				try {
					//check if multiple auto bidders
					Statement st2 = con.createStatement();

					rs = stmt.executeQuery("select count(*) from AutomaticBids a where a.item_id = " + id + " and upper_limit > " + bid_amount + ";");
					rs.next();
					
					count = rs.getInt("count(*)");
					
					if (count == 0) {
						
						doThis = false;
					} else if (count == 1) {
						rs = stmt.executeQuery("select * from AutomaticBids a where a.item_id = " + id + " and upper_limit > " + bid_amount + ";");
						
						rs.next();
						String emailOfBidder = rs.getString("email");
						int upper_limit = rs.getInt("upper_limit");
						int customerIncrement = rs.getInt("customer_inc");
						if (bid_amount + customerIncrement <= upper_limit) {
							outbid = true;
							bid_amount += customerIncrement;

							st2.executeUpdate("UPDATE `Item` SET `bid_amount` = " + bid_amount + ", `customer_email` = '" + emailOfBidder + "' WHERE (`itemID` = " + id + ");");
							
							//send message to leader
							String messageLeader = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
							PreparedStatement ps_leader = con.prepareStatement(messageLeader);
						
							ps_leader.setString(1, emailOfBidder);
							ps_leader.setInt(2, id);
							ps_leader.setString(3, title1);
							ps_leader.setString(4, get_closingDate_val);
							ps_leader.setString(5, "You are now the leading bidder for item " + id);
							
							ps_leader.executeUpdate();
						
							//send message to ex-leader
							
							String messageExLeader = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
							PreparedStatement ps_ex_leader = con.prepareStatement(messageExLeader);
						
							ps_ex_leader.setString(1, customer_email);
							ps_ex_leader.setInt(2, id);
							ps_ex_leader.setString(3, title1);
							ps_ex_leader.setString(4, get_closingDate_val);
							ps_ex_leader.setString(5, "Your bid for item " + id + " has been outbid");
							ps_ex_leader.executeUpdate();
						}					
					} else {
						rs = stmt.executeQuery("select * from AutomaticBids where item_id = " + id + " order by upper_limit desc limit 2;");
						outbid = true;
						rs.next();
						String winnerEmail = rs.getString("email");
						int winnerIncrement = rs.getInt("customer_inc");
						int upperLimit = rs.getInt("upper_limit");
						rs.next();
						String secondEmail = rs.getString("email");
						int basePrice = rs.getInt("upper_limit");
						if (winnerIncrement + basePrice <= upperLimit) {
							bid_amount = winnerIncrement + basePrice;
							st2.executeUpdate("UPDATE `Item` SET `bid_amount` = " + bid_amount + ", `customer_email` = '" + winnerEmail + "' WHERE (`itemID` = " + id + ");");
							
							//send message to leader
							String messageLeader = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
							PreparedStatement ps_leader = con.prepareStatement(messageLeader);
						
							ps_leader.setString(1, winnerEmail);
							ps_leader.setInt(2, id);
							ps_leader.setString(3, title1);
							ps_leader.setString(4, get_closingDate_val);
							ps_leader.setString(5, "You are now the leading bidder for item " + id);
							
							ps_leader.executeUpdate();
						
							
						} else {
							st2.executeUpdate("UPDATE `Item` SET `bid_amount` = " + basePrice + ", `customer_email` = '" + secondEmail + "' WHERE (`itemID` = " + id + ");");
							
							//send message to leader
							String messageLeader = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
							PreparedStatement ps_leader = con.prepareStatement(messageLeader);
						
							ps_leader.setString(1, secondEmail);
							ps_leader.setInt(2, id);
							ps_leader.setString(3, title1);
							ps_leader.setString(4, get_closingDate_val);
							ps_leader.setString(5, "You are now the leading bidder for item " + id);
							
							ps_leader.executeUpdate();
						
							//send message to ex-leader
							
							String messageExLeader = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
							PreparedStatement ps_ex_leader = con.prepareStatement(messageExLeader);
						
							ps_ex_leader.setString(1, customer_email);
							ps_ex_leader.setInt(2, id);
							ps_ex_leader.setString(3, title1);
							ps_ex_leader.setString(4, get_closingDate_val);
							ps_ex_leader.setString(5, "Your bid for item " + id + " has been outbidelse");
							ps_ex_leader.executeUpdate();
						}	
					}
				} finally {
					if (doThis == true) {
						ResultSet rs_item = null;

						String get_item_vals = "select * from AutomaticBids where item_id = " + id + " order by upper_limit asc limit " + (count - 1) + ";";
						PreparedStatement ps_item = con.prepareStatement(get_item_vals);
						rs_item = ps_item.executeQuery();
						
						while(rs_item.next()){
							String email = rs_item.getString("email");
							
							String messageExLeader = "INSERT INTO customer_products(customer_email, itemID, title, created_date, closing_date, message) VALUES (?, ?, ?, now(), ?, ?)";
							PreparedStatement ps_ex_leader = con.prepareStatement(messageExLeader);
						
							ps_ex_leader.setString(1, email);
							ps_ex_leader.setInt(2, id);
							ps_ex_leader.setString(3, title1);
							ps_ex_leader.setString(4, get_closingDate_val);
							ps_ex_leader.setString(5, "Your bid for item " + id + " has been outbidfinal");
							ps_ex_leader.executeUpdate();

						}	
					}			
				}		
				if (outbid == true) {
					out.print("Successfully bid on auction, but someone has automatically outbid your bid.");
				} else {
					out.print("Successfully bid on auction!");
				}
				
			}
		}
		out.print("<br>");
		out.print("<a href='buyItem.jsp'>Back to the list of items</a>");
		con.close();
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to bid on an item!");
	}
	
	%>
	
	</body>
</html>