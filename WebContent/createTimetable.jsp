<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit"%>
<!DOCTYPE html>
	<html>
	<head>
		<script src="loadEssentials/jquery.min.js"></script>
		<script src="loadEssentials/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="css/main.css">
		<link rel="stylesheet" type="text/css" href="button.css">
		<link rel="stylesheet" type="text/css" href="loaddir/css/main.css">
	</head>
	<body>
	<!-- ======== NAVBAR START ======== -->
	
	<style>
	
	.topnav {
	  overflow: hidden;
	  background-color: #333;
	}
	
	.topnav a {
	  float: left;
	  color: #f2f2f2;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	  font-size: 17px;
	}
	
	.topnav a:hover {
	  background-color: #ddd;
	  color: black;
	}
	
	.topnav a.active {
	  background-color: rgb(126, 51, 187);
	  color: white;
	}
	</style>
	<div class="topnav">
	  <a href="Admin.jsp">Admin Console</a>
	  
	  	<div style="position: absolute; right: 0px; padding: 3px;">
		<form action="Logout">
			<button type="submit" class="login100-form-btn">Log Out</button>
		</form>
	  	</div>
	  
	</div>
	
	<!-- ======== NAVBAR END ======== -->
<%
	//Class to store information for each subject
	class Subject {
	    private int code;
	    private int hours;

		public Subject(int code, int hours) {
		   this.code = code;
		   this.hours = hours;
		}
		
	    public int getCode() { return code; }
	    public int getHours() { return hours; }
	
	    public void setCode(int code) { this.code = code; }
	    public void setHours(int hours) { this.hours = hours; }
	}

	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Project", "root", "password");
		Statement st=conn.createStatement();

		HttpSession sessiona = request.getSession(false);
		String usernameCurr = (String) sessiona.getAttribute("username");
		
		// Clearing contents of Timetable
		String sql = "delete from Timetable where AdminFT = '"+usernameCurr+"'";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.executeUpdate(); 

		// Clearing contents of ClassroomTimetable
		sql = "delete from ClassroomTimetable where AdminCT = '"+usernameCurr+"'";
		ps = conn.prepareStatement(sql);
		ps.executeUpdate();

		// Initializing ClassrromTimetable for Labs
		sql = "select * from Classroom where Adminc = '"+usernameCurr+"' and Type = "+1+"";
		ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();	
		
		Statement stmt = conn.createStatement();
		while(rs.next()) {
			for(int i = 1; i <= 5; i++) {
				for(int j = 1; j <= 6; j++) {
					sql = "insert into ClassroomTimetable (Day, slot, RoomNo, AdminCT, Batch) values("+i+", "+j+", '"+rs.getString("RoomNo")+"', '"+usernameCurr+"', "+-1+")";
					stmt.addBatch(sql);
				}
			}
		}
		stmt.executeBatch();
		
		// Initializing ClassroomTimetable for Lecture rooms
		sql = "select * from Classroom where Adminc = '"+usernameCurr+"' and Type = "+0+"";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		stmt = conn.createStatement();
		while(rs.next()) {
			for(int i = 1; i <= 5; i++) {
				for(int j = 1; j <= 6; j++) {
					sql = "insert into ClassroomTimetable (Day, slot, RoomNo, AdminCT, Batch) values("+i+", "+j+", '"+rs.getString("RoomNo")+"', '"+usernameCurr+"', "+0+")";
					stmt.addBatch(sql);
				}
			}
		}
		stmt.executeBatch();

		// Initializing Timetable
		sql = "select * from Faculty where Adminf = '"+usernameCurr+"'";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		stmt = conn.createStatement();
		while(rs.next()) {
			for(int i = 1; i <= 5; i++) {
				for(int j = 1; j <= 6; j++) {
					sql = "insert into Timetable (Day, slot, FacultyId, AdminFT) values("+i+", "+j+", '"+rs.getString("FacultyId")+"', '"+usernameCurr+"')";
					stmt.addBatch(sql);
				}
			}
		}
		stmt.executeBatch();

 		//TIMEtable for Labs
		sql = "select * from Division where Admind = '"+usernameCurr+"' order by Division desc";
		ps = conn.prepareStatement(sql);
		ResultSet divisionRs = ps.executeQuery();
		
        int slot = -1;
	//	stmt = conn.createStatement();
        while(divisionRs.next()) {
            
	       	for(int batch = 1; batch <= 4; batch++) {
	       		if(batch%2 == 0) {
	    			sql = "select * from Syllabus where Lab = "+1+" and AdminS = '"+usernameCurr+"' order by SubjectName asc";
	       		}
	       		else { 
	       			sql = "select * from Syllabus where Lab = "+1+" and AdminS = '"+usernameCurr+"' order by SubjectName desc";
	       		}
	       		ps = conn.prepareStatement(sql);
	            ResultSet labRs = ps.executeQuery();

	        	// Subject queue
	        	//Queue <Subject> labQ = new LinkedQueue <Subject>();    
	        	Queue<Subject> labQ = new LinkedList<>();  
	        	/* Queue<Subject> labQ = new PriorityQueue<Subject>(10, new SubjectComparator()); */

	            while(labRs.next()) {
	    			Subject subject = new Subject(labRs.getInt("SubjectCode"), labRs.getInt("Hours"));
	    			labQ.add(subject);
	    			//System.out.println(subject.getHours());
	            }
	            
				for(int day = 1, j = 1; day <= 5; day++, j = (j+2)%6) {
					sql = "select * from ClassroomTimetable where slot = "+j+" and Day = "+day+" and AdminCT = '"+usernameCurr+"' and Batch = "+-1+"";
					ps = conn.prepareStatement(sql);
					ResultSet classRs = ps.executeQuery(sql);
					//System.out.println(day + " " + slot);
					while(classRs.next()) {						
						classRs.getString("Division");
						
						if(classRs.wasNull()) {
							while(true) {
								// Dequeuing subject from priority queue
								Subject subject = labQ.remove();
								
								// Gets facultyId for given TE and subject from LoadAllocation
								sql = "select * from LoadAllocation where Batch = "+batch+" and SubjectCode = '"+subject.getCode()+"' and Division = '"+divisionRs.getString("Division")+"' and AdminL = '"+usernameCurr+"'";
								ps = conn.prepareStatement(sql);
								ResultSet loadRs = ps.executeQuery(sql); loadRs.next();
								
								// Gets faculty slot from FacujltyTimetable
								sql = "select * from Timetable where FacultyId = '"+loadRs.getString("FacultyId")+"' and slot = "+j+" and Day = "+day+" and AdminFT = '"+usernameCurr+"'";
								//System.out.println(sql + " " + subject.getCode());
								ps = conn.prepareStatement(sql);
								ResultSet facultyRs = ps.executeQuery(sql); facultyRs.next();

								Statement stmF = conn.createStatement();
								// Checks if faculty is free
								facultyRs.getInt("SubjectCode");
								
								if(facultyRs.wasNull()) {
									sql = "update Timetable set RoomNo = '"+classRs.getString("RoomNo")+"', Division = '"+divisionRs.getString("Division")+"', Batch = "+batch+", SubjectCode = '"+subject.getCode()+"' where FacultyId = '"+loadRs.getString("FacultyId")+"' and slot = "+j+" and Day = "+day+" and AdminFT = '"+usernameCurr+"'";
									stmF.executeUpdate(sql);
									//stmt.addBatch(sql);
									//out.print(sql+"<br>");
									
									sql = "update Timetable set RoomNo = '"+classRs.getString("RoomNo")+"', Division = '"+divisionRs.getString("Division")+"', Batch = "+batch+", SubjectCode = '"+subject.getCode()+"' where FacultyId = '"+loadRs.getString("FacultyId")+"' and slot = "+(j+1)+" and Day = "+day+" and AdminFT = '"+usernameCurr+"'";
									//out.print(sql);
									stmF.executeUpdate(sql);
									// stmt.addBatch(sql);
										//out.print(sql+"<br>");
									 
									sql = "update ClassroomTimetable set Division ='"+divisionRs.getString("Division")+"', Batch = "+batch+" where slot = "+j+" and Day = "+day+" and RoomNo = '"+classRs.getString("RoomNo")+"' and AdminCT = '"+usernameCurr+"'";
									stmF.executeUpdate(sql);
									// stmt.addBatch(sql);
									//	out.print(sql+"<br>");
									 
									sql = "update ClassroomTimetable set Division ='"+divisionRs.getString("Division")+"', Batch = "+batch+" where slot = "+(j+1)+" and Day = "+day+" and RoomNo = '"+classRs.getString("RoomNo")+"' and AdminCT = '"+usernameCurr+"'";
									//stmt.addBatch(sql);
									//out.print(sql+"<br>");
									stmF.executeUpdate(sql);
									
									subject.setHours(subject.getHours() - 2);
									if(subject.getHours() != 0) {
										labQ.add(subject);
									}
									break;
								}
								else labQ.add(subject);
							}
							break;
						}
					}
				}
	        }
	    	break;
        }
      //  stmt.executeBatch();
        //out.print();
      
      sql = "select * from Faculty where Adminf = '"+usernameCurr+"'";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		stmt = conn.createStatement();
		while(rs.next()) {
			for(int i = 1; i <= 5; i++) {
				for(int j = 1; j <= 6; j++) {
					sql = "insert into Timetable (Day, slot, FacultyId, AdminFT) values("+i+", "+j+", '"+rs.getString("FacultyId")+"', '"+usernameCurr+"')";
					stmt.addBatch(sql);
				}
			}
		}
		stmt.executeBatch();

 		//TIMEtable for Labs
		sql = "select * from Division where Admind = '"+usernameCurr+"' order by Division desc";
		ps = conn.prepareStatement(sql);
		divisionRs = ps.executeQuery();
		
        slot = -1;
	//	stmt = conn.createStatement();
        while(divisionRs.next()) {
	    		sql = "select * from Syllabus where Lab = "+0+" and AdminS = '"+usernameCurr+"' order by SubjectName asc";
	       		ps = conn.prepareStatement(sql);
	            ResultSet labRs = ps.executeQuery();

	        	// Subject queue
	        	//Queue <Subject> labQ = new LinkedQueue <Subject>();    
	        	Queue<Subject> labQ = new LinkedList<>();  
	        	/* Queue<Subject> labQ = new PriorityQueue<Subject>(10, new SubjectComparator()); */

	            while(labRs.next()) {
	    			Subject subject = new Subject(labRs.getInt("SubjectCode"), labRs.getInt("Hours"));
	    			labQ.add(subject);
	    			//System.out.println(subject.getHours());
	            }
	            
				for(int day = 1; day <= 5; day++) {
					for(int j = 1; j <= 6; j++) {
					sql = "select * from ClassroomTimetable where Division = '"+divisionRs.getString("Division")+"' and slot = "+j+" and Day = "+day+" and AdminCT = '"+usernameCurr+"'";
					//out.print(sql + "<br>");
					ps = conn.prepareStatement(sql);
					ResultSet classRs1 = ps.executeQuery(sql);
					if(classRs1.next()) {
						continue;
					}
					sql = "select * from ClassroomTimetable where slot = "+j+" and Day = "+day+" and AdminCT = '"+usernameCurr+"' and Batch = "+-1+"";
					ps = conn.prepareStatement(sql);
					ResultSet classRs = ps.executeQuery(sql);
					//System.out.println(day + " " + slot);
					while(classRs.next()) {						
						classRs.getString("Division");
						
						if(classRs.wasNull()) {
							while(true) {
								// Dequeuing subject from priority queue
								Subject subject = labQ.remove();
								
								// Gets facultyId for given TE and subject from LoadAllocation
								sql = "select * from LoadAllocation where Batch = "+0+" and SubjectCode = '"+subject.getCode()+"' and Division = '"+divisionRs.getString("Division")+"' and AdminL = '"+usernameCurr+"'";
								ps = conn.prepareStatement(sql);
								ResultSet loadRs = ps.executeQuery(sql); loadRs.next();
								
								// Gets faculty slot from FacujltyTimetable
								sql = "select * from Timetable where FacultyId = '"+loadRs.getString("FacultyId")+"' and slot = "+j+" and Day = "+day+" and AdminFT = '"+usernameCurr+"'";
								//System.out.println(sql + " " + subject.getCode());
								ps = conn.prepareStatement(sql);
								ResultSet facultyRs = ps.executeQuery(sql); facultyRs.next();

								Statement stmF = conn.createStatement();
								// Checks if faculty is free
								facultyRs.getInt("SubjectCode");
								
								if(facultyRs.wasNull()) {
									sql = "update Timetable set RoomNo = '"+classRs.getString("RoomNo")+"', Division = '"+divisionRs.getString("Division")+"', Batch = "+0+", SubjectCode = '"+subject.getCode()+"' where FacultyId = '"+loadRs.getString("FacultyId")+"' and slot = "+j+" and Day = "+day+" and AdminFT = '"+usernameCurr+"'";
									stmF.executeUpdate(sql);
									//stmt.addBatch(sql);
									//out.print(sql+"<br>");
									 
									sql = "update ClassroomTimetable set Division ='"+divisionRs.getString("Division")+"', Batch = "+0+" where slot = "+j+" and Day = "+day+" and RoomNo = '"+classRs.getString("RoomNo")+"' and AdminCT = '"+usernameCurr+"'";
									stmF.executeUpdate(sql);
									// stmt.addBatch(sql);
									//	out.print(sql+"<br>");
									
									subject.setHours(subject.getHours() - 1);
									if(subject.getHours() != 0) {
										labQ.add(subject);
									}
									break;
								}
								else labQ.add(subject);
							}
							break;
						}
					}
					}
				}
	    	break;
        }
        
 
		String sql1 = "select * from Division where Admind = '"+usernameCurr+"' order by Division desc";
		PreparedStatement ps1 = conn.prepareStatement(sql1);
		ResultSet divisionRs1 = ps1.executeQuery();
		
		while(divisionRs1.next()) {
	%>
	
		<div class="limiter">	
		<div class="container-table100">
			<div class="wrap-table100">
		<h1 style="color: white"><center><%= divisionRs1.getString("Division") %> Time Table</center></h1><br><br>	
				<div class="table100">
	
		<table>
		<thead>	
		<tr class="table100-head">
		<th class="column1"><center>Time</center></th>
		<th class="column1"><center>Monday</center></th>
		<th class="column1"><center>Tuesday</center></th>
		<th class="column1"><center>Wednesday</center></th>
		<th class="column1"><center>Thursday</center></th>
		<th class="column1"><center>Friday</center></th>
		</tr>
		</thead>
		
		<!-- <table>
		<tr>
		<th><center>Time</center></th>
		<th><center>Monday</center></th>
		<th><center>Tuesday</center></th>
		<th><center>Wednesday</center></th>
		<th><center>Thursday</center></th>
		<th><center>Friday</center></th>
		</tr> -->
	<%
		for(int i = 1; i <= 6; i++) {
			String[] slotS = new String[5];
			for(int day = 1; day <= 5; day++) {
				sql = "select * from Timetable where Division = '"+divisionRs1.getString("Division")+"' and slot = "+i+" and Day = "+day+" and AdminFT = '"+usernameCurr+"' order by Batch asc";
				ps = conn.prepareStatement(sql);
				ResultSet facultyRs = ps.executeQuery(); 
				if(facultyRs.next()) {
				if(facultyRs.getInt("Batch") != 0) {
					if(i%2 != 0) {
					slotS[day - 1] = "<br>";
					String[] tempSplit = facultyRs.getString("Division").split("-");
					String[] batchName = {"", "K", "L", "M", "N"};
					for(int j = 1; j <= 4; j++) {
						/* out.print(facultyRs.getInt("Batch")); */
						sql = "select SubjectName from Syllabus where SubjectCode = "+facultyRs.getInt("SubjectCode")+" and AdminS = '"+usernameCurr+"'";
						ps = conn.prepareStatement(sql);
						ResultSet subjectRs = ps.executeQuery(); subjectRs.next();
						slotS[day - 1] +=  batchName[j] + tempSplit[1] + "&nbsp; : &nbsp;" + subjectRs.getString("SubjectName") + "&nbsp; [ " + facultyRs.getString("RoomNo") + " ]" + "<br>";
						facultyRs.next();
					}
					slotS[day - 1] += "<br>";
					}
					else slotS[day - 1] = "-";
				}
				else {
					sql = "select SubjectName from Syllabus where SubjectCode = "+facultyRs.getInt("SubjectCode")+" and AdminS = '"+usernameCurr+"'";
					Statement stm = conn.createStatement();
					ResultSet subjectRs = stm.executeQuery(sql); subjectRs.next();
					slotS[day - 1] = subjectRs.getString("SubjectName") + "&nbsp; [ " + facultyRs.getString("RoomNo") + " ]" + "<br>";
				}
				}
			}
	%>
		<tbody>
		<tr>
		<td class="column2" style="border-style:solid;"><center><%= i%></center></td>
		<td class="column2" style="border-style:solid;"><center><%= slotS[0]%></center></td>
		<td class="column2" style="border-style:solid;"><center><%= slotS[1]%></center></td>
		<td class="column2" style="border-style:solid;"><center><%= slotS[2]%></center></td>
		<td class="column2" style="border-style:solid;"><center><%= slotS[3]%></center></td>
		<td class="column2" style="border-style:solid;"><center><%= slotS[4]%></center></td>
		</tr>
		</tbody>
	<%
			}
	break;
		}
	}
	catch(Exception e)
	{
		System.out.print(e);
		e.printStackTrace();
	}
%>
	</table>
	<br>
	<center>
		<button class="learn-more" onclick="window.print()" target="_blank">    
	      <div class="circle">
	        <span class="icon arrow"></span>
	      </div>			    
	        <p class="button-text"> &nbsp;&nbsp;Print Timetable to PDF</p>			    
	    </button> </center>
	</div>
	</div>
	</div>
	</div>
	</body>
	</html>