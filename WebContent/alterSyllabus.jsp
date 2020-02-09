<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	int subjectcode = Integer.parseInt(request.getParameter("subcode"));
	String subjectname = request.getParameter("subname");
	int subjecthrs = Integer.parseInt(request.getParameter("subhrs"));
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");

		st.executeUpdate("update Syllabus set SubjectCode = "+subjectcode+", SubjectName = '"+subjectname+"', Hours = "+subjecthrs+" where SubjectCode = "+subjectcode+" and AdminS = '"+usernameCurr+"';");
                
        response.sendRedirect("editSyllabus.jsp");
 	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 