package com.sh.model;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Date;

import com.sh.entities.StudentReport;
import com.sh.util.dbConn;




public class StudentReportModel {

	private Connection connection;
	
	public StudentReportModel() {
		System.out.println("I am in Dao Constructor");
		connection=dbConn.getConnection();
	}
	
	
	public void addToReport(StudentReport _report){
		try{
			System.out.println("inside addtoReport");
//			String sql = "SELECT max(RID) as rid FROM QuestionBank";
//			 
//			Statement statement = connection.createStatement();
//			ResultSet result = statement.executeQuery(sql);
//			int rid=0;
//			if (result.next())
//			{
//			rid=result.getInt("rid");
//			}
			
//			java.util.Date dt = ;
//			java.text.SimpleDateFormat sdf = 
//				     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			String currentTime = sdf.format(dt);
			//System.out.println("max value of rid "+ rid);
			System.out.println("record to be added to report: "+_report.toString());
			PreparedStatement prepstmt=connection.prepareStatement("insert into StudentReport(StudentName,Time,DateOfTest, TimeDiff) values (?,?,?,?)");
			//prepstmt.setInt(1, rid+1);
			prepstmt.setString(1, _report.getStudentName());
			prepstmt.setString(2, _report.getTime());
			prepstmt.setString(3, _report.getDateOfTest());
			prepstmt.setInt(4, (int) _report.getTimeDiff());
			
			prepstmt.executeUpdate();
			System.out.println("records added");
		}catch(SQLException se){
			System.out.println("prepare statment cant add into table");
			se.printStackTrace();
		}
	}
	
	
	public List<StudentReport> getTodaysReport()
	{
		List<StudentReport> _report= new ArrayList<StudentReport>();
		
		try{
			System.out.println("inside getTodaysReport");
			
			Calendar c = new GregorianCalendar();
		    c.set(Calendar.HOUR_OF_DAY, 0); //anything 0 - 23
		    c.set(Calendar.MINUTE, 0);
		    c.set(Calendar.SECOND, 0);
		    Date d1 = c.getTime();
		    
			
			java.text.SimpleDateFormat sdf = 
				     new java.text.SimpleDateFormat("yyyy-MM-dd");
			String _today=sdf.format(d1);
			
			String sql = "select * from StudentReport where DateOfTest>'"+_today+"' order by TimeDiff asc;";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			while (result.next())
			{
				System.out.println("inside if block of get report");
				Date dt=result.getDate("DateOfTest");
				String DateOfTest=""+dt+"";
				StudentReport _record=new StudentReport(result.getInt("RID"),result.getString("StudentName"),result.getString("time"),DateOfTest,result.getInt("timeDiff"));
				_report.add(_record);
			}
			System.out.println("the question bank contains following questions ");
			for (StudentReport _record1 : _report) {
				System.out.println(_record1.toString());
			}
			
			System.out.println("records added");
		}catch(SQLException se){
			System.out.println("cannot get the question bank");
			se.printStackTrace();
		}
		return _report;
		
	}
	
	public int getMaxRid(){
		int rid=0;
	
		try{
			System.out.println("inside addtoReport");
			String sql = "SELECT Max(RID) as rid FROM StudentReport";
			
				Statement statement = connection.createStatement();
				ResultSet result = statement.executeQuery(sql);
				
				if (result.next())
					rid=result.getInt("rid");
			
			
			
	}catch(SQLException se){
		System.out.println("prepare statment cant add into table");
		se.printStackTrace();
	}
		
		System.out.println("rid: "+rid);
		return rid;
	
	}
	
	
	public int getRid(){
		int rid=0;
	
		try{
			System.out.println("inside addtoReport");
			String sql = "SELECT RID FROM StudentReport";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if (result.next())
				rid=result.getInt("rid");
			
			
	}catch(SQLException se){
		System.out.println("prepare statment cant add into table");
		se.printStackTrace();
	}
		
		System.out.println("rid: "+rid);
		return rid;
	
	}
}
