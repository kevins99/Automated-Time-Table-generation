<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String facultySelect = request.getParameter("facultySelect");
	String subjectSelect = request.getParameter("subjectSelect");
	String divisionSelect = request.getParameter("divisionSelect");
	String batchSelect = request.getParameter("batchSelect");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "root", "password");
		Statement st=conn.createStatement();

		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");

		ResultSet res = st.executeQuery("select SubjectCode from Syllabus where SubjectName='"+subjectSelect+"'");
		res.next();
		int subjectCodeSelect = res.getInt("SubjectCode");

		res = st.executeQuery("select * from Syllabus where SubjectName='"+subjectSelect+"'");
		res.next();
		int subjectLoad = res.getInt("Hours");

		int batch = 0;
		if(batchSelect != null) batch = Integer.parseInt(batchSelect);

		res = st.executeQuery("select FacultyId from Faculty where Name = '"+facultySelect+"'"); res.next();
		
		st.executeUpdate("insert into LoadAllocation (FacultyId, SubjectCode, Division, Batch, SubjectLoad, AdminL) values ('"+res.getString("FacultyId")+"', "+subjectCodeSelect+", '"+divisionSelect+"', "+batch+", "+subjectLoad+", '"+usernameCurr+"')");
		
		response.sendRedirect("loadAllocation.jsp");
 	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%>