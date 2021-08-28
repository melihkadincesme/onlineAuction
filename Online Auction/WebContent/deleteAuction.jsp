<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Auction</title>
</head>
<style>
	body{
		background-color:#FAEAC3;
	}
</style>
<body>
<%
	String id = request.getParameter("itemid");
	List<String> list = new ArrayList<String>();
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String type = request.getParameter("delete");
		String del = "";
		
		if (type.equals("deleteAuc")){
			del = "DELETE FROM item WHERE itemID = '" + id + "'";
			stmt.executeUpdate(del);
		} else if (type.equals("removeBid")) {
			del = "UPDATE item SET bid_amount = null WHERE itemID = " +id;
			stmt.executeUpdate(del);
		}

		//close the connection.
		con.close();
		out.println("Successfully deleted!");
		out.println("<a href = 'repAuctionView.jsp'>Return to auctions</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("delete failed");
	}	
%>

</body>
</html>