<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="button.css">
</head>
<body style="">
	
	<!-- <form>
		<input type="button" value="Add Faculty" onclick="window.location.href='addFaculty.html'"><br><br>
		<input type="button" value="Delete Faculty" onclick="window.location.href='deleteFaculty.html"><br><br>
		<input type="button" value="Add Room" onclick="window.location.href='addClass.html'"><br><br>
		<input type="button" value="Delete Room" onclick="window.location.href='deleteRoom.html'"><br><br>
		<input type="button" value="Add Subject to Syllabus" onclick="window.location.href='addSubject.html'"><br><br>
		<input type="button" value="Edit Syllabus" onclick="window.location.href='editSyllabus.jsp'"><br><br>
		<input type="button" value="Delete Syllabus" onclick="window.location.href='deleteSyllabus.html'"><br><br>
		<input type="button" value="Load Allocation" onclick="window.location.href='loadAllocation.jsp'"><br><br>
		<input type="button" value="Create Timetable" onclick="window.location.href='createTimetable.jsp'"><br><br>	
	</form> -->
	
	<!-- <form action="Logout">
		<input type="submit" value="Logout">
	</form>	 -->	
	
	
	<div class="container-login100" style="background-image: url('images/pict2.jpg');">

		<center>
	
			<div class="wrap-login100">
			
				<span class="login100-form-title p-b-34 p-t-27">
						Admin Console
					</span>
					
					<br><br>
			
				<!-- <div class="container-login100-form-btn">	
				<button class="login100-form-btn" onclick="window.location.href='faculty.jsp'">Faculty</button> <br>	
				</div>

				<br> -->
				
				<button class="learn-more" onclick="window.location.href='faculty.jsp'">    
			      <div class="circle">
			        <span class="icon arrow"></span>
			      </div>			    
			        <p class="button-text">Faculty</p>			    
			    </button>
			    <br>
				
				
				<!-- <br>
				
				<div class="container-login100-form-btn">
				<button class="login100-form-btn" onclick="window.location.href='room.jsp'">Class Rooms</button>
				</div> -->
				
				
				<br>
				
				<button class="learn-more" onclick="window.location.href='room.jsp'">    
			      <div class="circle">
			        <span class="icon arrow"></span>
			      </div>			    
			        <p class="button-text">Class Rooms</p>			    
			    </button>
			    <br>
				
				<!-- <div class="container-login100-form-btn">
				<button class="login100-form-btn" onclick="window.location.href='syllabus.jsp'">Syllabus</button>
				</div>-->
				
				<br>
				
				<button class="learn-more" onclick="window.location.href='syllabus.jsp'">    
			      <div class="circle">
			        <span class="icon arrow"></span>
			      </div>			    
			        <p class="button-text">Syllabus</p>			    
			    </button>
			    <br>
				
				<!-- <div class="container-login100-form-btn">
				<button class="login100-form-btn" onclick="window.location.href='syllabus.html'">Load Allocation</button>
				</div> -->
				
				<br>
				
				<button class="learn-more" onclick="window.location.href='loadAllocation.jsp'">    
			      <div class="circle">
			        <span class="icon arrow"></span>
			      </div>			    
			        <p class="button-text">Load Allocation</p>			    
			    </button>
			    <br>
				
				<!-- <div class="container-login100-form-btn">
				<button class="login100-form-btn" onclick="window.location.href='syllabus.html'">Create Time Table</button>
				</div> -->
				
				<br>
				
				<button class="learn-more" onclick="window.location.href='createTimetable.jsp'">    
			      <div class="circle">
			        <span class="icon arrow"></span>
			      </div>			    
			        <p class="button-text">Create Time Table</p>			    
			    </button>
				
				<br><br><br><br><br>
				
				<div class="container-login100-form-btn">
				<form action="Logout">
					<button type="submit" class="login100-form-btn">Log Out</button>
				</form>
				</div>
				
			</div>
			
		</center>
		
	</div>
	
</body>
</html>