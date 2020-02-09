<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String facultyId = request.getParameter("fack2Id");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		
		int up = st.executeUpdate("delete from Faculty where FacultyId = '"+facultyId+"' and Adminf = '"+usernameCurr+"'");
		
        if(up == 1) response.sendRedirect("success.html");
        else response.sendRedirect("failure.html");
  	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 