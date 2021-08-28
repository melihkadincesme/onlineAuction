<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>Profile</title>
	</head>
	<body style="background-color:#FAEAC3;">
		<% if((session.getAttribute("email") == null)) { %>
			You are not logged in<br/>
			<a href="index.jsp">Please Login</a>
		<% } else { %>
			<h3>
			<% if(session.getAttribute("email").equals("admin@gmail.com")) { %>
				Welcome Admin
			<% } else { %>
			 	Welcome <%=session.getAttribute("email")%>
			<% } %>
			<% 
			try {
				
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				//Create a SQL statement
				Statement st = con.createStatement();
				String email = (String)session.getAttribute("email");
				
				ResultSet rs = st.executeQuery("select * from Item i where i.seller_email = '" + email + "' and i.check_live = true;");				
				%>
				<h3>Item's You're Selling</h3>
				
				<table border=1 align=center style="text-align:center">
			    	<thead>
			        	<tr>
			             	<th>TITLE</th>
			             	<th>DESCRIPTION</th>
			            	<th>CLOSING DATE</th>
			             	<th>INITIAL PRICE</th>
			             	<th>CURRENT BID</th>
			             	<th>CURRENT BUYER</th>
			             	<th>CATERGORY</th>
			             	<th>INCREMENT</th>
			          	</tr>
			      	</thead>
			      <tbody>
			        <%while(rs.next()) {%>
			            	<tr>
			            		<td><%=rs.getString("title") %></td>
			               		<td><%=rs.getString("description") %></td>
			                	<td><%=rs.getString("closing_date") %></td>
			                	<td><%=rs.getInt("initial_price") %></td>
			                	<td><%=rs.getInt("bid_amount") %></td>
			                	<td><%=rs.getString("customer_email") %></td>
			                	<td><%=rs.getString("category") %></td>
			                	<td><%=rs.getInt("increment") %></td>
			            	</tr>
			            <%
					} %>
			       </tbody>
			       
			   	</table><br>
			   	
			   	<% rs = st.executeQuery("select * from Item i where i.seller_email = '" + email + "' and i.check_live = false;"); %>
			   	<h3>Item's You've Sold</h3>
				
				<table border=1 align=center style="text-align:center">
			    	<thead>
			        	<tr>
			             	<th>TITLE</th>
			             	<th>DESCRIPTION</th>
			            	<th>CLOSING DATE</th>
			             	<th>INITIAL PRICE</th>
			             	<th>CURRENT BID</th>
			             	<th>CURRENT BUYER</th>
			             	<th>CATERGORY</th>
			             	<th>INCREMENT</th>
			          	</tr>
			      	</thead>
			      <tbody>
			        <%while(rs.next()) {%>
			            	<tr>
			            		<td><%=rs.getString("title") %></td>
			               		<td><%=rs.getString("description") %></td>
			                	<td><%=rs.getString("closing_date") %></td>
			                	<td><%=rs.getInt("initial_price") %></td>
			                	<td><%=rs.getInt("bid_amount") %></td>
			                	<td><%=rs.getString("customer_email") %></td>
			                	<td><%=rs.getString("category") %></td>
			                	<td><%=rs.getInt("increment") %></td>
			            	</tr>
			            <%
					} %>
			       </tbody>
			       
			   	</table><br>
			   	
			   	<% rs = st.executeQuery("select * from Item i where i.customer_email = '" + email + "' and i.check_live = false;"); %>
			   	<h3>Item's You've Bought</h3>
				
				<table border=1 align=center style="text-align:center">
			    	<thead>
			        	<tr>
			             	<th>TITLE</th>
			             	<th>DESCRIPTION</th>
			            	<th>CLOSING DATE</th>
			             	<th>INITIAL PRICE</th>
			             	<th>CURRENT BID</th>
			             	<th>CURRENT BUYER</th>
			             	<th>CATERGORY</th>
			             	<th>INCREMENT</th>
			          	</tr>
			      	</thead>
			      <tbody>
			        <%while(rs.next()) {%>
			            	<tr>
			            		<td><%=rs.getString("title") %></td>
			               		<td><%=rs.getString("description") %></td>
			                	<td><%=rs.getString("closing_date") %></td>
			                	<td><%=rs.getInt("initial_price") %></td>
			                	<td><%=rs.getInt("bid_amount") %></td>
			                	<td><%=rs.getString("customer_email") %></td>
			                	<td><%=rs.getString("category") %></td>
			                	<td><%=rs.getInt("increment") %></td>
			            	</tr>
			            <%
					} %>
			       </tbody>
			       
			   	</table><br>
			    <%}
			    catch(Exception e){
			        out.print(e.getMessage());%><br><%
			    }
			    finally{
			        
			    }
			    %>
		
		
			<br> 
			<br>
			<a href="success.jsp">Home Page</a>
			</h3>
		<% } %>
	</body>
</html>