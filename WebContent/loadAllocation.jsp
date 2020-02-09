<%@page import="java.net.http.HttpClient.Redirect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" session="false"%>
<%@page import="java.sql.*,java.util.*,java.util.concurrent.TimeUnit, java.time.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HttpSession sessiona = request.getSession(false);
	String usernameCurr = (String) sessiona.getAttribute("username");
	
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String database = "Project";
	String userid = "user";
	String password = "1234";
	
	try {
	Class.forName(driver);
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	%>
	
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
		
	<div class="limiter">	
		<div class="container-table100">
			<div class="wrap-table100">
		<h1 style="color: white"><center>Load Allocation Table</center></h1><br><br>	
				<div class="table100">
		<table>
		<thead>	
		<tr class="table100-head">
		<th class="column1"><center>Id</center></th>
		<th class="column1"><center>Name</center></th>
		<th class="column2"><center>Division</center></th>
		<th class="column1"><center>Batch</center></th>
		<th class="column1"><center>Subject Load</center></th>
		<th class="column1"><center>Total Load</center></th>
		</tr>
		</thead>
	
	<%
		try{
		connection = DriverManager.getConnection(connectionUrl+database, userid, password);
		statement=connection.createStatement();
		String sql ="select (select Name from Faculty where FacultyId = LoadAllocation.FacultyId and Adminf = 'abc@gmail.com') as FacultyName, FacultyId, group_concat(Division, ' : ', (select SubjectName from Syllabus where SubjectCode = LoadAllocation.SubjectCode and AdminS = 'abc@gmail.com') SEPARATOR '<br><br>') as Division, group_concat(SubjectLoad SEPARATOR '<br><br>') as SubjectLoad, group_concat(Division, '#', Batch SEPARATOR '<br><br>') as Batch, sum(SubjectLoad) as TotalLoad from LoadAllocation where AdminL = 'abc@gmail.com' group by FacultyId";
		resultSet = statement.executeQuery(sql);
		
		while(resultSet.next()){
			String temp = resultSet.getString("Batch");
			String[] tempSplit = temp.split("<br><br>"), batchName = {"K - ", "L - ", "M - ", "N - "};
			String Batch = "";
			for(int i = 0; i < tempSplit.length; i++) {
				String[] temp1 = tempSplit[i].split("#");
				for(int j = 0; j < temp1[1].length(); j++) {
					if(temp1[1].charAt(j) == '0') {
						Batch += "- - -";
					}
					else {
						String[] temp2 = temp1[0].split("-");
						Batch += batchName[Integer.parseInt(temp1[1]) - 1];
						Batch += temp2[1];
					}
					Batch +=  "<br><br>";
				}
			}
	%>
		<tbody>
		<tr>
		<td class="column2"><center><%=resultSet.getString("FacultyId") %></center></td>
		<td class="column1"><center><%=resultSet.getString("FacultyName") %></center></td>
		<td class="column2"><center><%=resultSet.getString("Division") %></center></td>
		<td class="column1"><center><%=Batch %></center></td>
		<td class="column2"><center><%=resultSet.getString("SubjectLoad") %></center></td>
		<td class="column1"><center><%=resultSet.getString("TotalLoad") %></center></td>
		</tr>
	<%
		}
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	</table>
	<br>
	</div>
	<div>
	<form method="post" action="addLoad.jsp">
		<center>
		<select required id = "divisionSelect" name="divisionSelect" onchange="showSubject(this.value);">
			<option value="" selected disabled>Select Division</option>
		<%
			try{
			connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			statement =connection.createStatement();
			String sql2 = "select * from Division where AdminD = '"+usernameCurr+"'";
			resultSet = statement.executeQuery(sql2);
			while(resultSet.next()) {
		%>
			<option value="<%= resultSet.getString("Division")%>"><%= resultSet.getString("Division")%></option>
		<%
			}
		%>
		</select>
		
		<select required id="subjectSelect" name="subjectSelect" onchange="showBatch(this.value);">
			<option value="" selected disabled>Select Subject</option>
		</select>
		<select required id="facultySelect" name="facultySelect">
			<option value="" selected disabled>Select Faculty</option>
		</select>
		<select style="visibility:hidden" id="batchSelect" name="batchSelect">
			<option value="" selected disabled>Select Batch</option>
		<%
				connection.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>	
		</select>	</center> <br><br>
		<center> <button class="learn-more" type = "submit" target="_blank">    
	      <div class="circle">
	        <span class="icon arrow"></span>
	      </div>			    
	        <p class="button-text">Add</p>			    
	    </button> </center>
		<%-- <center> <input type="submit" style = "background: lightgrey; color: black; padding: 16px 32px; margin: 4px 2px; cursor: pointer;" value="Add"> </center> --%>
	</form>
	</div>
	
	<br><br>
	<center>
		<button class="learn-more" onclick="window.open('deleteLoad.html')" target="_blank">    
	      <div class="circle">
	        <span class="icon arrow"></span>
	      </div>			    
	        <p class="button-text">Delete Load</p>			    
	    </button>
	    &nbsp; &nbsp;
	    <button class="learn-more" onclick="window.print()" target="_blank">    
	      <div class="circle">
	        <span class="icon arrow"></span>
	      </div>			    
	        <p class="button-text">Print Load to PDF</p>			    
	    </button>
	 </center>
	
	<script>
		$("#batchSelect").val("");
		$("#divisionSelect").val("");
		$("#facultySelect").val("");
		$("#subjectSelect").val("");
		var xmlHttp;
		var xmlHttp;
		function showSubject(str) {
			if (typeof XMLHttpRequest != "undefined") {
				xmlHttp= new XMLHttpRequest();
			}
			else if(window.ActiveXObject) {
				xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
			}
			if (xmlHttp==null){
				alert("Browser does not support XMLHTTP Request")
				return;
			}
			
			var url="showDivisionLoadAllocation.jsp";
			url +="?divisionPass=" +str;
			console.log(url);
			xmlHttp.onreadystatechange = subjectChange;
			xmlHttp.open("GET", url, true);
			xmlHttp.send(null);
		}
		function subjectChange() {
			var select = document.getElementById("subjectSelect");
			for (i = 1; i < select.options.length; i++) {
			  select.options[i] = null;
			}
			if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete") {  
				var subject = xmlHttp.responseText;
				var subjectFack = subject.split('#');
				var subjectArr = subjectFack[0].split("$");
				var select = document.getElementById("subjectSelect");
				for(var i = 1; i < subjectArr.length; i++) {
					select.options[select.options.length] = new Option(subjectArr[i], subjectArr[i]);
					console.log(subjectArr[i]);
				}
				
				var facultyArr = subjectFack[1].split("$");
				var selectFack = document.getElementById("facultySelect");
				for(var i = 1; i < facultyArr.length; i++) {
					selectFack.options[selectFack.options.length] = new Option(facultyArr[i], facultyArr[i]);
					console.log(facultyArr[i]);
				}
			}
		}
		
		function showBatch(str) {
			if (typeof XMLHttpRequest != "undefined") {
				xmlHttp= new XMLHttpRequest();
			}
			else if(window.ActiveXObject) {
				xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
			}
			if (xmlHttp==null){
				alert("Browser does not support XMLHTTP Request")
				return;
			}
			
			var url="showBatchLoadAllocation.jsp";
			e = document.getElementById("divisionSelect");
			
			url += "?subjectPass=" + str + "&divisionPass=" + e.options[e.selectedIndex].text;
			console.log(url);
			xmlHttp.onreadystatechange = batchChange;
			xmlHttp.open("GET", url, true);
			xmlHttp.send(null);
		}
		function batchChange() {
			var select = document.getElementById("batchSelect");
			for (i = 1; i < select.options.length; i++) {
			  select.options[i] = null;
			}
			if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete") {  
				var batch = xmlHttp.responseText;
				var batchArr = batch.split('$');
				var batchName = ["", "K-", "L-", "M-", "N-"];
				
				var temp = document.getElementById("divisionSelect").options[e.selectedIndex].text;
				/* console.log(temp); */
				var division = temp.split('-');
				
				var select = document.getElementById("batchSelect");
				console.log(batch);
				console.log(batchArr.length);
				if(batchArr.length > 1) {
					console.log(batchArr.length);
					select.style.visibility = "visible"; 
					for(var i = 1; i < batchArr.length; i++) {
						var exact = parseInt(batchArr[i]) + 1;
						select.options[select.options.length] = new Option(batchName[exact]+division[1], exact);
						console.log(batchName[exact]+division[1]);
						console.log(exact);
					}
				}
			}
		}
	</script>  
	
</body>
</html>