<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta charset="UTF-8">
	<title>Login Page</title>
	</head>
	<body style="background-color:#FAEAC3;">		
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement st = con.createStatement();
			
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			ResultSet rs;
			
			rs = st.executeQuery("select e.email, e.password from EndUser e where email='" + email + "' and password='" + password + "'");
			//Check what kind of user logged in
			if(rs.next()){
				session.setAttribute("email", email);
				out.println("Welcome user");
				out.println("<a href = 'logout.jsp'>Log out</a>");
				response.sendRedirect("success.jsp");
			}else{
				rs = st.executeQuery("select a.email, a.password from Admin_Staff a where email='" + email + "' and password='" + password + "'");
					if(rs.next()){
						session.setAttribute("email", email);
						out.println("Welcome user");
						out.println("<a href = 'logout.jsp'>Log out</a>");
						response.sendRedirect("adminLogin.jsp");
					}else {
						rs = st.executeQuery("select c.email, c.password from Customer_Rep c where email='" + email + "' and password='" + password + "'");
						if(rs.next()){
							session.setAttribute("email", email);
							out.println("Welcome user");
							out.println("<a href = 'logout.jsp'>Log out</a>");
							response.sendRedirect("repLogin.jsp");
						}else{
							out.println("<h3>Invalid Login Details</h3> <a href='index.jsp'>Try Again</a>");
						}
					}
			}
		}catch(Exception ex){
			out.print(ex);
			out.print("Failed");
		}
	%>
	</body>
</html>