<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String fid = request.getParameter("fackId");
	String fname = request.getParameter("fackName");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		  
        PreparedStatement ps=conn.prepareStatement("select * from Faculty where FacultyId = '"+fid+"' and Adminf = '"+usernameCurr+"'");   
        ResultSet rs=ps.executeQuery();
       	
        
        if(rs.next()) {
        	response.sendRedirect("repEntry.html");
        }
        
        else {
        	int i=st.executeUpdate("insert into Faculty (FacultyId, Name, Adminf) values ('"+fid+"','"+fname+"','"+usernameCurr+"')");
        }
        response.sendRedirect("success.html");
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 