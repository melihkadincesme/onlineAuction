<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta charset="UTF-8">
	<title>Check Item Available</title>
	</head>
	<body style="background-color:#FAEAC3;">
	
	<form method="get" action="confirmAvailability.jsp">
	<table>
	
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		
		String email = session.getAttribute("email").toString();
		int itemID1 = Integer.parseInt(request.getParameter("val"));
		
		String get_str = "SELECT i.title FROM item i where i.itemID=?";
		PreparedStatement ps_val = con.prepareStatement(get_str);
		
		ps_val.setInt(1, itemID1);
		rs = ps_val.executeQuery();
		
		while(rs.next()){
	%>
	<tr>
		<td><h1><%=rs.getString("title") %></h1></td>
	</tr>
	<tr>
		 <td>Change Status: </td><td>
		 	<input list="category1" name="category1">
		 	<datalist id="category1">
						
			<option value="Available">
			<option value="Not Available">
								
			</datalist> 
			</td>
		</tr>
		<input type="hidden" name="itemID" value="<%=itemID1%>">
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