<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>

<%

	/* int subjectcode = Integer.parseInt(request.getParameter("subcode")); */

	HttpSession sessiona = request.getSession(false);
	String usernameCurr = (String) sessiona.getAttribute("username");
	
	/* try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");

 		st.executeUpdate("select * from Syllabus where SubjectCode = "+subjectcode+" and AdminS = '"+usernameCurr+"';");
 		ResultSet resultSet = null;
 		resultSet = statement.executeQuery("select * from Syllabus where SubjectCode = "+subjectcode+" and AdminS = '"+usernameCurr+"';");
 		out.print("select * from Syllabus where SubjectCode = "+subjectcode+" and AdminS = '"+usernameCurr+"';");
                
         response.sendRedirect("Admin.jsp");
  	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	} */
	
	/* String id = request.getParameter("userid"); */
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String database = "Project";
	String userid = "user";
	String password = "1234";
	
	try {
	Class.forName(driver);
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	%>
	
	<!DOCTYPE html>
	<html>
	<head><link rel="stylesheet" type="text/css" href="css/main.css"></head>
	<body style="overflow: hidden;">
	
	<!-- ======== NAVBAR START ======== -->
	
	<style>
	
	.topnav {
	  overflow: hidden;
	  background-color: #333;
	}
	
	.topnav a {
	  float: left;
	  color: #f2f2f2;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	  font-size: 17px;
	}
	
	.topnav a:hover {
	  background-color: #ddd;
	  color: black;
	}
	
	.topnav a.active {
	  background-color: rgb(126, 51, 187);
	  color: white;
	}
	</style>
	
	<div class="topnav">
	  <a href="Admin.jsp">Admin Console</a>
	  
	  	<div style="position: absolute; right: 0px; padding: 3px;">
		<form action="Logout">
			<button type="submit" class="login100-form-btn">Log Out</button>
		</form>
	  	</div>
	  
	</div>
	
	<!-- ======== NAVBAR END ======== -->

	
	
	<!-- <form method="post" action="alterSyllabus.jsp">
		Subject Code<input type="text" name="subcode">
		Subject Name<input type="text" name="subname">
		Hours<input type="text" name="subhrs">
		<input type="submit" value="Edit Syllabus">
	</form> -->
	
	
	<div class="limiter">
		<div class="container-login100" style="background-image: url('images/pict2.jpg');">
			<div class="wrap-login100">
			
			<span class="login100-form-title p-b-34 p-t-27">
						Alter Syllabus
					</span>
					
				<form method="post" action="alterSyllabus.jsp" class="login100-form validate-form">
		
					
					<br>
					<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="subcode" placeholder="Subject Code">
						<span class="focus-input100"></span>
					</div>
					
					<br>
					<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="subname" placeholder="Subject Name">
						<span class="focus-input100"></span>
					</div>
					
					<br>
					<div class="wrap-input100 validate-input">
						<input class="input100" type="text" name="subhrs" placeholder="Subject Hours">
						<span class="focus-input100"></span>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" type="submit">
							Edit Syllabus
						</button>
					</div>

				</form>
			</div>
		</div>
	</div>
	
	
	