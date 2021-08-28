<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Auction</title>
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

	<a href = "repAuctionView.jsp">View all auctions</a>

	<%
	try{ //we need to pass itemID from buyItem.jsp for each item.
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//int id_value = session.getAttribute("id");
		
		ResultSet result_set = null;
		int id = Integer.parseInt(request.getParameter("val"));
		//String id = request.getParameter("val");

		String test_val = "SELECT * FROM item i WHERE i.itemID=?";
		PreparedStatement ps = con.prepareStatement(test_val);
		
		ps.setInt(1, id);
		//ps.setString(1, id);
		
		result_set=ps.executeQuery();
		
		while(result_set.next()){
	%>
	<form method="get" action="buy_item_success.jsp">
	<table>
		<tr>
			<td><h1 style="text-align:center"><%=result_set.getString("title") %></h1></td>	
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
			<td><b>Category: </b><%=result_set.getString("category") %></td>
		</tr>
		<tr>
		</tr>
	</table>
	</form>
	<br>
	<form method="get" action="deleteAuction.jsp">
		<button name="delete" type="submit" value="deleteAuc">Delete this auction</button>
		<input type="hidden" name="itemid" value="<%=id%>">
	</form>	 
	<br>
	<form method="get" action="deleteAuction.jsp">
		<button name="delete" type="submit" value="removeBid">Remove all bids</button>
		<input type="hidden" name="itemid" value="<%=id%>">
	</form>	
	<%
	}
	Statement stmt2 = con.createStatement();
	String str = "";
		
		
	}catch(Exception ex){
		out.print(ex);
		out.print("Failed to Display!");
	}
	 %>
	 

</body>
</html>