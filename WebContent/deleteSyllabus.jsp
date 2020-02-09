<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "root", "password");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		
       	st.executeUpdate("delete from Syllabus where AdminS = '"+usernameCurr+"'");
        response.sendRedirect("success.html");
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 