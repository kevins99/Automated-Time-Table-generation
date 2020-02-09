
package com.load;

import java.sql.*;  
import java.util.ArrayList;  
import java.util.List;
import com.timetable.bean.User;

public class LoadAllocation { 
	public static Connection getConnection(){  
	    Connection con=null;  
	    try{  
	        Class.forName("com.mysql.jdbc.Driver");  
	        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Project","root","password");  
	    }catch(Exception e){System.out.println(e);}  
	    return con;  
	}
	
	public static List<User> getAllRecords(){  
	    List<User> list=new ArrayList<User>();  
	      
	    try{  
	        Connection con=getConnection();  
	        PreparedStatement ps=con.prepareStatement("select FacultyName, group_concat(Division, ' - ', (select SubjectName from Syllabus where SubjectCode = LoadAllocation.SubjectCode) SEPARATOR '<br>') as Division, group_concat(SubjectLoad SEPARATOR '<br>') as SubjectLoad, sum(SubjectLoad) as TotalLoad from LoadAllocation group by FacultyName");   
	        ResultSet rs=ps.executeQuery();
	        
	        while(rs.next()){  
	            User u=new User();  
	            u.setFacultyName(rs.getString("FacultyName"));
	            u.setDivision(rs.getString("Division"));
//	            u.setSubjectCode(rs.getInt("SubjectCode"));
	            u.setTotalLoad(rs.getInt("TotalLoad"));
	            u.setSubjectLoad(rs.getString("SubjectLoad"));
	            list.add(u);
	        }  
	    }catch(Exception e){System.out.println(e);}  
	    
	    return list;  
	}
}