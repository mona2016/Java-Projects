package com.sh.entities;

import java.io.Serializable;
import java.util.Date;

public class StudentReport implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int RID;
	private String studentName;
	private String time;
	private String dateOfTest;
	private int timeDiff;
	public int getRID() {
		return RID;
	}
	public void setRID(int rID) {
		RID = rID;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDateOfTest() {
		return dateOfTest;
	}
	public void setDateOfTest(String dateOfTest) {
		this.dateOfTest = dateOfTest;
	}
	
	public int getTimeDiff() {
		return timeDiff;
	}
	public void setTimeDiff(int timeDiff) {
		this.timeDiff = timeDiff;
	}
	public StudentReport(int rID, String studentName, String time, String dateOfTest, int timeDiff) {
		super();
		RID = rID;
		this.studentName = studentName;
		this.time = time;
		this.dateOfTest = dateOfTest;
		this.timeDiff = timeDiff;
	}
	
	public StudentReport(String studentName, String time, String dateOfTest, int timeDiff) {
		super();
		
		this.studentName = studentName;
		this.time = time;
		this.dateOfTest = dateOfTest;
		this.timeDiff = timeDiff;
	}
	public StudentReport() {
		super();
	}
	@Override
	public String toString() {
		return "StudentReport [RID=" + RID + ", studentName=" + studentName + ", time=" + time + ", dateOfTest="
				+ dateOfTest + ", timeDiff=" + timeDiff + "]";
	}

	
	
}
