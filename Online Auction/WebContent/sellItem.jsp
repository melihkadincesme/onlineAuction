<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Sell Item</title>
	</head>
	<body style="background-color:#FAEAC3;">
	
		<h1 style="text-align:center">Creating an Auction / Selling Page</h1>
		<br>
		<ul>
		  <li>Welcome to creating an auction page! To post your item to the Website, please enter the following informations.</li>
		  <li>If you don't want to set a hidden minimum price, reserve, please enter zero into the specific section.</li>
		</ul>  
		
		<form method="get" action="sell_item_page.jsp">
		 		<table>
		 		
		 			<tr>
		 				<td>Title</td><td><input type="text" name = "title"></td>
		 			</tr>
		 			<!-- 
		 			<tr>
		 				<td>ItemID</td><td><input type="text" name = "itemID"></td>
		 			</tr>
		 			-->
		 			<tr>
		 				<td>Description</td><td><input type="text" name = "description" size="50"></td>
		 			</tr>
		 			<tr>
		 				<td>Category</td><td>
		 				<input list="category" name="category">
						<datalist id="category">
						
							<option name="Antiques" value="Antiques">
							<option value="Art">
							<option value="Books">
							<option value="Cameras">
							<option value="Cars">
							<option value="Clothing/Shoes">
							<option value="Electronics">
							<option value="DVDs">
						    <option value="Health Products">
						    <option value="Jewelry/Watches">
						    <option value="Music">
						    <option value="Sporting Goods">
						    <option value="Sports Memorobilia">
						    <option value="Toys">
						    <option value="Video Games">
						    <option value="Others">
						</datalist> </td>
		 			</tr>
		 			<tr>
                         <td>Closing Date</td><td>
                         <input type="datetime-local" id=closingDate name="closing_date" value="2021-06-10T12:00" min="2021-04-17T00:00" max="2023-06-14T00:00">
                         </td>
                     </tr>
		 			<tr>
		 				<td>Initial Price</td><td><input type="text" name = "int_price"></td>
		 			</tr>
		 			<tr>
		 				<td>Reserve Price</td><td><input type="text" name = "reserve"></td>
		 			</tr>
		 			<tr>
		 				<td>Increment</td><td><input type="text" name = "increment"></td>
		 			</tr>
		 			<!-- <tr>
		 				<td>Seller Email</td><td><input type="text" name = "seller_email"></td>
		 			</tr>
		 			 -->
		 		</table>
		 		<input type="submit" value="Submit">	 	
		 	</form>
	
	</body>
</html>