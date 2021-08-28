<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Customer Inquiry</title>
</head>
<style>
	body{
		background-color:#FAEAC3;
	}
	table{
		table-layout: fixed;
		width: 50%;
  		border: 2px solid black;
  		border-collapse: collapse;
  		padding:5px 10px 5px 10px;
     	margin-left:auto; 
    	margin-right:auto;
	}
	td{
		border: 1px solid black;
		padding:5px 10px 5px 10px;
	}
	textarea{
		resize: none;
		width: 100%;
		height: 100px;
	}	
</style>
<body>

<form action = "questions.jsp">
	<button name="repFunc" type="submit" value="true">Return to questions</button>	 
</form>

<%
	int postnum = Integer.parseInt(request.getParameter("postnum"));
	//Display post
	out.print("<table>");
	//
	out.print("<tr>");
	out.print("<td>");
	out.print("Post #" + postnum);
	out.print("<h3>");
	out.print(request.getParameter("title"));
	out.print("</h3>");
	out.print("<strong> by user: </strong>");
	out.println(request.getParameter("cemail"));
	out.print("<br>");
	out.print("<br>");
	out.println(request.getParameter("qtext"));
	out.print("</td>");
	out.print("</tr>");
	//Answer form
	out.print("<tr>");
	out.print("<td>");
	out.print("<h4>");
	out.print("Answer:");
	out.print("</h4>");
	out.print("<form action=\"submitAnswer.jsp\">");
	out.print("<textarea name=\"description\" placeholder=\"Type your answer here\" name=\"description\" required></textarea>");
	out.print("<input type=\"hidden\" name=\"postnum\" value=\"" +postnum+ "\"/>");
	out.print("<button type=\"submit\" name=\"action\">Submit</button>");
	out.print("</form> <br>");
	


%>




</body>
</html>