<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String roomNo = request.getParameter("roomNo");
	String roomType = request.getParameter("roomType");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		  
        PreparedStatement ps=conn.prepareStatement("select * from Classroom where RoomNo = '"+roomNo+"' and Adminc = '"+usernameCurr+"'");   
        ResultSet rs=ps.executeQuery();
       	
        int type = 1;
        if(roomType == "ClassRoom") type = 0;
        
        if(rs.next()) {
        	response.sendRedirect("repEntry.html");
        } 
        
        else {
        	int i=st.executeUpdate("insert into Classroom (RoomNo, Type, Adminc) values ('"+roomNo+"',"+type+",'"+usernameCurr+"')");
        }
        response.sendRedirect("success.html");
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 