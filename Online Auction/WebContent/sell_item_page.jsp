<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body style="background-color:#FAEAC3;">
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		ResultSet resultSet = null;
		
		String count = "SELECT COUNT(*) FROM item";
		PreparedStatement ps1 = con.prepareStatement(count);
		resultSet = ps1.executeQuery();
		resultSet.next();
		
		int itemID = resultSet.getInt("count(*)") + 1;
		
		//int itemID = Integer.parseInt(request.getParameter("itemID"));
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String category = request.getParameter("category");
		String closing_date = request.getParameter("closing_date");
		int int_price = Integer.parseInt(request.getParameter("int_price"));
		int reserve = Integer.parseInt(request.getParameter("reserve"));
		int increment = Integer.parseInt(request.getParameter("increment"));
		int one = 1;
		
		String seller_email = session.getAttribute("email").toString();
		
		String insert = "INSERT INTO item(itemID, title, description, closing_date, initial_price, reserve, seller_email, category, check_live, increment, available) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		//String testq = "SELECT * FROM item";
		
		PreparedStatement ps = con.prepareStatement(insert);
		//resultSet = stmt.executeQuery(testq);
		
		ps.setInt(1, itemID);
		ps.setString(2, title);
		ps.setString(3, description);
		ps.setString(4, closing_date);
		ps.setInt(5, int_price);
		ps.setInt(6, reserve);
		ps.setString(7, seller_email);
		ps.setString(8, category);
		ps.setInt(9, 1);
		ps.setInt(10, increment);
		ps.setInt(11, one);
		
		ps.executeUpdate();
		
		con.close();
		out.print("Successfully Created an Auction!");
		out.print("<br>");
		out.print("<a href='success.jsp'>Back to the Main Page</a>");
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to create an auction!");
	}
	
	%>
	</body>
</html>