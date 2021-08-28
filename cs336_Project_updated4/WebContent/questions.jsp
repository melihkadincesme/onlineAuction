<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions</title>
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
	
</style>
</head>
<body>


<br>
<%
		String repFunc = request.getParameter("repFunc");
		boolean isRep = false;
		out.print("<form action = \"questions.jsp\">");
		out.print("<input type=\"text\" name=\"keywords\" placeholder=\"Search keywords\" required>");
		out.print("<input type=\"submit\" name=\"search\" value=\"Search\">");
		out.print("<input type=\"hidden\" name=\"repFunc\" value=\"" +repFunc+ "\"/> <br> <br>");
		out.print("</form>");
		if (repFunc == null || repFunc.equals("null")) {
			//not a rep, show post question button for regular users
			out.print("<form action = \"postQuestion.jsp\">");
			out.print("<input type=\"submit\" name=\"post\" value=\"Post a Question\">");
			out.print("</form> <br>");
			
			out.print("<a href = \"success.jsp\">Go back to user dashboard</a> <br>");
		} else {
			isRep = true;
			out.print("<a href = \"repLogin.jsp\">Go back to representative dashboard</a> <br>");
		}
		List<String> list = new ArrayList<String>();
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//
			String keywords = request.getParameter("keywords");
			String entity = (String)session.getAttribute("email");
			String str;
			String words[] = null;
			
			//
			if (keywords == null) {
				str = "SELECT * FROM questions order by postnum desc";				
			} else {
				out.print("<br> <form action = \"questions.jsp\">");
				out.print("<input type=\"submit\" name=\"view\" value=\"View all questions\">");
				out.print("<input type=\"hidden\" name=\"repFunc\" value=\"" +repFunc+ "\"/> </form> <br> <br>");
				//user is searching keywords, search title first
				words = keywords.split(" ");
				str = "SELECT * FROM questions WHERE title LIKE '%" +words[0]+ "%'";	
				for (int i=1; i<words.length;i++) {
					str = str.concat("AND title LIKE '%" +words[i]+ "%'");
				}
				str = str.concat(" UNION ");
				//search descriptions
				str = str.concat("SELECT * FROM questions WHERE qtext LIKE '%" +words[0]+ "%'");	
				for (int i=1; i<words.length;i++) {
					str = str.concat("AND qtext LIKE '%" +words[i]+ "%'");
				}				
				str = str.concat(" order by postnum desc");
			}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			String repAns = "";
			boolean answered;
			while (result.next()) {
				repAns = result.getString("atext");
				int postnum = result.getInt("postnum");
				String title = result.getString("title");
				String cemail = result.getString("cemail");
				String qtext = result.getString("qtext");
				if (repAns == null) {
					repAns = "This question has not been answered yet.";
					answered = false;
				} else {
					answered = true;
				}
				out.print("<table>");
				//
				out.print("<tr>");
				out.print("<td>");
				out.print("Post #" + postnum);
				out.print("<h3>");
				out.print(title);
				out.print("</h3>");
				out.print("<strong> by user: </strong>");
				out.println(cemail);
				out.print("<br>");
				out.print("<br>");
				out.println(qtext);
				out.print("</td>");
				out.print("</tr>");
				//
				out.print("<tr>");
				out.print("<td>");
				out.print("<h4>");
				out.print("Answer:");
				out.print("</h4>");
				out.print(repAns);
				if (isRep && !answered) {
					out.print("<br> <br>");
					out.print("<form method=\"get\" action=\"repAnswer.jsp\"> <button name=\"repFunc\" type=\"submit\" value=\"true\">Answer question</button>");
					out.print("<input type=\"hidden\" name=\"postnum\" value=\"" +postnum+ "\"/>");
					out.print("<input type=\"hidden\" name=\"title\" value=\"" +title+ "\"/>");
					out.print("<input type=\"hidden\" name=\"cemail\" value=\"" +cemail+ "\"/>");
					out.print("<input type=\"hidden\" name=\"qtext\" value=\"" +qtext+ "\"/>");
					out.print("</form>");						 			
				}
				out.print("<br>");	
				out.print("</td>");
				out.print("</tr>");							
					
				//
				out.print("</table>");
				
				out.print("<br>");
			}

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Failed");
		}
	
		%>

</body>
</html>