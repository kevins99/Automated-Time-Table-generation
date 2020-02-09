package com.login.dao;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;

public class LoginDao 
{
	String sql = "select * from Admin where EmailId=? and password=?";
	String url = "jdbc:mysql://localhost:3306/Project";
	String username = "user";
	String password = "1234";
	
	public boolean check(String uname, String pass)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url,username,password);
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1,uname);
			st.setString(2,pass);
			ResultSet rs = st.executeQuery();
			if(rs.next())
			{
				return true;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return false;
	}
}
