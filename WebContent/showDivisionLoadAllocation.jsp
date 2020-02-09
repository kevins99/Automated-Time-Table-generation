<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>

<%

	String division = request.getParameter("divisionPass");
	
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "user", "1234");
		Statement st=conn.createStatement();
		
		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");

		String sql = "select * from Syllabus where AdminS = '"+usernameCurr+"' and Lab = '"+0+"'";
        PreparedStatement ps=conn.prepareStatement(sql);   
        ResultSet rs=ps.executeQuery();
       	
        while(rs.next()) {
        	/* out.print("$");
        	out.print(rs.getString("SubjectName")); */
        	sql = "select * from LoadAllocation where Division = '"+division+"' and AdminL = '"+usernameCurr+"' and SubjectCode = "+rs.getString("SubjectCode")+"";
        	ps = conn.prepareStatement(sql);
        	ResultSet loadRs = ps.executeQuery();
        	if(!loadRs.next()) {
        		out.print("$");
        		/* sql = "select * from Syllabus where AdminS = '"+usernameCurr+"' and SubjectCode = "+rs.getString("SubjectCode")+"";
        		ps = conn.prepareStatement(sql);
        		loadRs = ps.executeQuery(); loadRs.next(); */
        		out.print(rs.getString("SubjectName"));
			}
        }
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        sql = "select * from Syllabus where AdminS = '"+usernameCurr+"' and Lab = '"+1+"'";
        ps=conn.prepareStatement(sql);   
        rs=ps.executeQuery();
       	
        while(rs.next()) {
        	/* out.print("$");
        	out.print(rs.getString("SubjectName")); */
        	sql = "select count(*) from LoadAllocation where Division = '"+division+"' and AdminL = '"+usernameCurr+"' and SubjectCode = "+rs.getString("SubjectCode")+"";
        	ps = conn.prepareStatement(sql);
        	ResultSet loadRs = ps.executeQuery(); loadRs.next();
        	if(loadRs.getInt(1) != 4) {
        		out.print("$");
        		/* sql = "select * from Syllabus where AdminS = '"+usernameCurr+"' and SubjectCode = "+rs.getString("SubjectCode")+"";
        		ps = conn.prepareStatement(sql);
        		loadRs = ps.executeQuery(); loadRs.next(); */
        		out.print(rs.getString("SubjectName"));
			}
        }
        
        out.print("#");
        
        sql = "select * from Faculty where Adminf = '"+usernameCurr+"'";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()) {
			sql = "select * from LoadAllocation where Division = '"+division+"' and AdminL = '"+usernameCurr+"' and FacultyId = '"+rs.getString("FacultyId")+"' and Batch = "+0+" and SubjectLoad > "+20+"";
			/* out.print(sql); */
			ps = conn.prepareStatement(sql);
			ResultSet loadRs = ps.executeQuery();
			if(!loadRs.next()) {
				out.print("$");
        		out.print(rs.getString("Name"));
			}
		}
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%> 