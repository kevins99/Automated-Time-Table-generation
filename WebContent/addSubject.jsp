<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	int subjectCode = Integer.parseInt(request.getParameter("subjectCode"));
	String subjectName = request.getParameter("subjectName");
	String subjectHours = request.getParameter("subjectHours");
	int labLecture = Integer.parseInt(request.getParameter("labLecture"));
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		
        PreparedStatement ps=conn.prepareStatement("select * from Syllabus where SubjectCode = '"+subjectCode+"' and AdminS = '"+usernameCurr+"'");
        ResultSet rs=ps.executeQuery();
       
        if(rs.next()) {
        	response.sendRedirect("repEntry.html");
        }
        else {
        	int i=st.executeUpdate("insert into Syllabus (SubjectCode, SubjectName, Hours, AdminS, Lab) values ("+subjectCode+",'"+subjectName+"','"+subjectHours+"','"+usernameCurr+"',"+labLecture+")");
        }

        response.sendRedirect("success.html");
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 