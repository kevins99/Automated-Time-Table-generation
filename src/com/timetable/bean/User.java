package com.timetable.bean;

public class User {  
    private String facultyName, division, subjectLoad;
    private int totalLoad;
    
	public String getFacultyName() {
		return facultyName;
	}
	public void setFacultyName(String facultyName) {
		this.facultyName = facultyName;
	}
	
	public int getTotalLoad() {
		return totalLoad;
	}
	public void setTotalLoad(int totalLoad) {
		this.totalLoad = totalLoad;
	}
	public String getSubjectLoad() {
		return subjectLoad;
	}
	public void setSubjectLoad(String subjectLoad) {
		this.subjectLoad = subjectLoad;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}  
}