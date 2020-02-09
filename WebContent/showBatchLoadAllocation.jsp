<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String subjectName = request.getParameter("subjectPass");
	String division = request.getParameter("divisionPass");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");

		String sql = "select * from Syllabus where AdminS = '"+usernameCurr+"' and SubjectName = '"+subjectName+"'";
        PreparedStatement ps=conn.prepareStatement(sql);   
        ResultSet rs=ps.executeQuery(); rs.next();
        int subject = rs.getInt("SubjectCode");
        
		sql = "select * from Syllabus where AdminS = '"+usernameCurr+"' and SubjectName = '"+subjectName+"'";
        ps=conn.prepareStatement(sql);   
        rs=ps.executeQuery();
       	
        while(rs.next()) {
        	if(rs.getInt("Lab") == 1) {
	        	int[] selected = new int[]{0, 0, 0, 0};
	        	sql = "select * from LoadAllocation where Division = '"+division+"' and AdminL = '"+usernameCurr+"' and SubjectCode = "+subject+"";
	        	ps = conn.prepareStatement(sql);
	        	ResultSet loadRs = ps.executeQuery();
	        	while(loadRs.next()) {
	        		selected[loadRs.getInt("Batch") - 1] = 1;
				}
	        	for(int i = 0; i <= 3; i++) {
	        		if(selected[i] == 0) {
	        			out.print("$" + i);
	        		}
	        	}
        	}
        	else break;
        }
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 