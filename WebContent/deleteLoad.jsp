<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String facultyId = request.getParameter("facID");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		
		int up = st.executeUpdate("delete from LoadAllocation where FacultyId = '"+facultyId+"' and AdminL = '"+usernameCurr+"'");
		
        if(up != 0) response.sendRedirect("success.html");
        else response.sendRedirect("failure.html");
  	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 