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
	<head>
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<link rel="stylesheet" type="text/css" href="button.css">
	<link rel="stylesheet" type="text/css" href="loaddir/css/main.css">
	<meta http-equiv="refresh" content="5" />
	</head>
	<body>
	
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

	<div class="limiter">
		<div class="container-table100">
			<div class="wrap-table100">
				<div class="table100">
		<table>
		<thead>
		<tr class="table100-head">
								<th class="column1"><center>Room Number</center></th>
								<th class="column2"><center>Type</center></th>
							</tr>
		</thead>
	<%
	try{
		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		statement=connection.createStatement();
		String sql ="select * from Classroom";
		resultSet = statement.executeQuery(sql);
		while(resultSet.next()) {
			String type = "Classroom";
			if(resultSet.getInt("Type") == 1) type = "Laboratory";
	%>
	<tbody>
	<tr>
	<td class="column1"><center><%=resultSet.getString("RoomNo") %></center></td>
	<td class="column2"><center><%= type%></center></td>
	</tr>
	<%
	}
	
	connection.close();
	} catch (Exception e) {
	e.printStackTrace();
	}
	
	
%> 
<center>

		<button class="learn-more" onclick="window.open('addClass.html')" target="_blank">    
	      <div class="circle">
	        <span class="icon arrow"></span>
	      </div>			    
	        <p class="button-text">Add Class Room</p>			    
	    </button>
	    &nbsp; &nbsp; &nbsp;
	    <button class="learn-more" button onclick="window.open('deleteRoom.html')" target="_blank">    
	      <div class="circle">
	        <span class="icon arrow"></span>
	      </div>			    
	        <p class="button-text">Delete Class Room</p>			    
	    </button>
		<br><br>
		
</center>

	
	
	