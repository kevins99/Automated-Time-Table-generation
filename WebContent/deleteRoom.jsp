<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%
	String roomn = request.getParameter("RoomNo");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");

		/* st.executeUpdate("delete from Classes where RoomNo = '"+roomn+"' and Adminc = '"+usernameCurr+"';");
                
        response.sendRedirect("Admin.jsp"); */
        
        PreparedStatement ps=conn.prepareStatement("select * from Classroom where RoomNo = '"+roomn+"' and Adminc = '"+usernameCurr+"'");   
        //out.print("select * from Classes where RoomNo = '"+roomn+"' and Adminc = '"+usernameCurr+"'");
        ResultSet rs=ps.executeQuery();
        
        if(rs.next()) {
        	st.executeUpdate("delete from Classroom where RoomNo = '"+roomn+"' and Adminc = '"+usernameCurr+"'");
            response.sendRedirect("success.html");
        } 
        
        else {
        	response.sendRedirect("repEntry.html");	
        }
 	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 