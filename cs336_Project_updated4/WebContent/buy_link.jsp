<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Link for each item</title>
	</head>
	<body style="background-color:#FAEAC3;">
	
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
			<td><b>Category: </b><%=result_set.getString("category") %></td>
		</tr>
		<tr>
			<td><b>Closing Date: </b><%=result_set.getString("closing_date") %></td>
		</tr>
		<tr>
			<td><b>Initial Amount: </b><%=result_set.getString("initial_price") %></td>
		</tr>
		<tr>
			<td><b>Current Highest Bid: </b><%=result_set.getString("bid_amount") %></td>
		</tr>
		<tr>
			<td><b>Minimum Increment: </b><%=result_set.getString("increment") %></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<%if (result_set.getInt("bid_amount") == 0) {
		
				%><td><b>Your minimum bid amount HAS to be <%= result_set.getInt("initial_price")+1 %> at least. </b></td>
				<%
			} else {
				%><td><b>Your minimum bid amount HAS to be <%= result_set.getInt("bid_amount") + result_set.getInt("increment") %> at least for automatic auction. </b></td>
				<%
			}
			%>
			
			
		</tr>
		<tr>
			<td><b>Bid Amount: </b></td><td><input type="text" name="bid_amount"></td>
		</tr>
		<input type="hidden" name="itemID" value="<%=id%>">
	</table>
		<input type="submit" value="Submit">	
	</form>
	<% 		
		}
		
	}catch(Exception ex){
		out.print(ex);
		out.print("Failed to Display!");
	}
	 %>
	</body>
</html>