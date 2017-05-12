package com.sh.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sh.util.dbConn;
import com.sh.entities.*;

public class QuestionModel {
	
	private Connection connection;
	ArrayList<Integer> visited= new ArrayList<Integer>();	//visited.Clear in home page
	public QuestionModel() {
		System.out.println("I am in Dao Constructor");
		connection=dbConn.getConnection();
		System.out.println("Connection created in dao");
	}
	
	public void addQuestion(Question _question)
	{
		try{
			System.out.println("inside addQuestion");
			String sql = "SELECT max(QID) as qid FROM QuestionBank";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			int qid=0;
			if (result.next())
			{
			qid=result.getInt("qid");
			}
			
			
			System.out.println("max value of qid "+ qid);
			System.out.println("values of question"+_question.toString());
			PreparedStatement prepstmt=connection.prepareStatement("insert into QuestionBank() values (?,?,?,?,?,?,?)");
			prepstmt.setInt(1, qid+1);
			prepstmt.setString(2, _question.getQuestion());
			prepstmt.setString(3, _question.getOption1());
			prepstmt.setString(4, _question.getOption2());
			prepstmt.setString(5, _question.getOption3());
			prepstmt.setString(6, _question.getOption4());
			prepstmt.setInt(7, _question.getCorrectAns());
			prepstmt.executeUpdate();
			System.out.println("records added");
		}catch(SQLException se){
			System.out.println("prepare statment cant add into table");
			se.printStackTrace();
		}
	}
	
	
	public List<Question> getAllQuestions()
	{
		List<Question> _questionBank= new ArrayList<Question>();
		
		try{
			System.out.println("inside getallQuestion");
			String sql = "SELECT * FROM QuestionBank";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			while (result.next())
			{
				System.out.println("inside if block of get all question");
				Question _question=new Question(result.getInt("QID"),result.getString("Question"),result.getString("Option1"),result.getString("Option2"),result.getString("Option3"),result.getString("Option4"),result.getInt("CorrectAns"));
				_questionBank.add(_question);
			}
			System.out.println("the question bank contains following questions ");
			for (Question questionBankModel : _questionBank) {
				System.out.println(questionBankModel.toString());
			}
			
			System.out.println("records added");
		}catch(SQLException se){
			System.out.println("cannot get the question bank");
			se.printStackTrace();
		}
		return _questionBank;
		
	}
	
	public Integer getHighestQID(){
		int qid=1;
		try{
			System.out.println("inside addQuestion");
			String sql = "SELECT max(QID) as qid FROM QuestionBank";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if (result.next())
			{
				qid=result.getInt("qid");
			}
		}catch(SQLException se){
			System.out.println("cannot get the question bank");
			se.printStackTrace();
		}
			return qid;
	}
	
	public Integer getNumOfQuestions()
	{
		int _num=0;
		try{
			System.out.println("inside getQuestionsById");
			String sql = "SELECT count(*) FROM QuestionBank";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			
			if (result.next())
			{
				_num=result.getInt("count(*)");
			}
			
		}catch(SQLException se){
			System.out.println("cannot get the question");
			se.printStackTrace();
		}
		return _num;
		
	}
	
	public void DeleteQuestion(int id){
		try{
			System.out.println("id: "+id);
			PreparedStatement preparedStatement = connection
                    .prepareStatement("delete from QuestionBank where QID=?");
            // Parameters start with 1
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
            System.out.println("deleted");
			
		}catch(SQLException se){
			System.out.println("cannot get the question");
			se.printStackTrace();
		}
	}
	
	
	public Question getQuestionsById(int id)
	{
		Question _question=new Question();
		try{
			System.out.println("inside getQuestionsById");
			String sql = "SELECT * FROM QuestionBank where qid="+id;
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if(result.next())
				_question=new Question(result.getInt("QID"),result.getString("Question"),result.getString("Option1"),result.getString("Option2"),result.getString("Option3"),result.getString("Option4"),result.getInt("CorrectAns"));

			System.out.println("the question is: ");
			System.out.println(_question.toString());
			System.out.println("question sent");
		}catch(SQLException se){
			System.out.println("cannot get the question");
			se.printStackTrace();
		}
		return _question;
		
	}
	
	public Question getRandomQuestion()
	{
		Question _question = new Question();
		//List<Question> _questionBank= new ArrayList<Question>();
		
		try{
			System.out.println("inside getRandomQuestion");
			String sql = "SELECT * FROM QuestionBank order by RAND() limit 1";
			 
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if(result.next()){
				_question=new Question(result.getInt("QID"),result.getString("Question"),result.getString("Option1"),result.getString("Option2"),result.getString("Option3"),result.getString("Option4"),result.getInt("CorrectAns"));
				
			}
				System.out.println(_question.toString());
			
		}catch(SQLException se){
			System.out.println("cannot get the question bank");
			se.printStackTrace();
		}
		return _question;
		
	}
	
	public boolean ifVisited(int qid){
		if(visited.contains(qid)&&visited.size()<6)
		return true;
		else{
			visited.add(qid);
			return false;
		}
		
	}
}

