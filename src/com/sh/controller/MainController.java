package com.sh.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.google.gson.Gson;
import com.sh.entities.Question;
import com.sh.entities.StudentReport;
import com.sh.model.QuestionModel;
import com.sh.model.StudentReportModel;


/**
 * Servlet implementation class MainController
 */
@WebServlet("/ScavengerHunt")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	private QuestionModel _model;
	private StudentReportModel _reportModel;
	List<Question>_randomQuestionBank =new ArrayList<Question>();
	ArrayList<Integer> visited= new ArrayList<Integer>();
	int _timeBeforeRefresh=0;
	int admin=0;
	
    public MainController() {
        super();
        System.out.println("I am in main controller constructor");
		_model=new QuestionModel();
		_reportModel=new StudentReportModel();
		visited.clear();
		//_randomQuestionBank=_model.getRandomQuestions();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		
		Gson gson = new Gson();
		String action= request.getParameter("action");
		System.out.println("action: "+action);
		
		if(action.equalsIgnoreCase("HomePage")){
			 System.out.println("in home page");
			 session.setAttribute("authenticated", "false");
			 session.setAttribute("currentPlayer","");
			 session.setAttribute("startTime", 0);
			 _timeBeforeRefresh=0;
			 admin=0;
			 RequestDispatcher view = request.getRequestDispatcher("HomePage.jsp");
		        view.forward(request, response);
			 
		}
		else if(action.equalsIgnoreCase("ScavengerHuntMainPage")){
			System.out.println("in get");
			session.setAttribute("all_questions", _model.getAllQuestions());
			System.out.println("current player in home page: "+session.getAttribute("currentPlayer"));
			System.out.println("start time: "+session.getAttribute("startTime"));
			session.setAttribute("pass", "");
			
			RequestDispatcher view = request.getRequestDispatcher("GamePage.jsp");
	        view.forward(request, response);
		}
		
		else if(action.equalsIgnoreCase("GamePage")){
			PrintWriter out= response.getWriter();
			response.setContentType("plain/text");
			System.out.println("in get");
			
			Question _question = _model.getRandomQuestion();
			
			while(ifVisited(_question.getQID())){
				System.out.println("inside while");
				if(visited.size()!=_model.getNumOfQuestions())
				_question = _model.getRandomQuestion();
				else
					visited.clear();
			}
			System.out.println("question: "+_question);
			out.print(gson.toJson(_question));
			out.flush();
			out.close();
		}
		
		
		
		else if(action.equalsIgnoreCase("AdminHomePage")){
			System.out.println("in admin home page");
			if(admin==0){
				session.setAttribute("pass", "");
				admin=1;
			}
			else
				session.setAttribute("pass", "bootcamp2016");
			session.setAttribute("all_questions", _model.getAllQuestions());
			//System.out.println("get today's report: "+ _reportModel.getMaxRid());
			session.setAttribute("report", _reportModel.getTodaysReport());
			System.out.println(session.getAttribute("all_questions"));
			RequestDispatcher view = request.getRequestDispatcher("AdminHomePage.jsp");
	        view.forward(request, response);
		}
		
		else if(action.equalsIgnoreCase("delete")){
			String id=request.getParameter("QID");
			_model.DeleteQuestion(Integer.parseInt(id));
			session.setAttribute("all_questions", _model.getAllQuestions());
			RequestDispatcher view = request.getRequestDispatcher("AdminHomePage.jsp");
	        view.forward(request, response);
		}
		
		else if(action.equalsIgnoreCase("getTotalTime")){
			System.out.println("in get total time: currentPlayer: "+ session.getAttribute("currentPlayer")+" start time: "+session.getAttribute("startTime"));
			StudentReportModel _reportModel1=new StudentReportModel();
			long timeDiff=Long.parseLong(request.getParameter("timeDiff"));
			String time=request.getParameter("time");
			String studentName=(String) session.getAttribute("currentPlayer");
			java.util.Date dt = new Date();
			java.text.SimpleDateFormat sdf = 
				     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			System.out.println("timeDiff: "+timeDiff+" time: "+time+" Student: "+studentName+" dateOfTest: "+currentTime);
			
			StudentReport _record= new StudentReport(studentName,time,currentTime,(int)timeDiff);
			System.out.println("record to be added: "+ _record);
			
			_reportModel1.addToReport(_record);
					
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		System.out.println("in post");
		String action=request.getParameter("action");
		Gson gson = new Gson();
		
		if (action.equalsIgnoreCase("addQuestion"))
		{
			session.setAttribute("pass", "bootcamp2016");
			QuestionModel _model = new QuestionModel();
			int id=_model.getHighestQID();
			
			if(request.getParameter("Question")!=""&&request.getParameter("Option1")!=""&&request.getParameter("Option2")!=""&&request.getParameter("Option3")!=""&&request.getParameter("Option4")!=""&&request.getParameter("CorrectAns")!=""){
			
			Question _question=new Question((id+1),request.getParameter("Question"),request.getParameter("Option1"),request.getParameter("Option2"),request.getParameter("Option3"), request.getParameter("Option4"), Integer.parseInt(request.getParameter("CorrectAns")));
		
			System.out.println("values: "+_question.toString());
			_model.addQuestion(_question);
			session.setAttribute("all_questions", _model.getAllQuestions());
			
			}
			System.out.println("req dispatcher");
			response.sendRedirect("AdminHomePage.jsp");
//			RequestDispatcher view = request.getRequestDispatcher("AdminHomePage.jsp");
//	        view.forward(request, response);
			
		}
		
		else if(action.equalsIgnoreCase("refreshed")){
			PrintWriter out= response.getWriter();
			if(request.getParameter("_timeBeforeRefresh")!=null){
				
				String str=request.getParameter("_timeBeforeRefresh");
				
				System.out.println("value of str: "+str);
				
				if(!str.isEmpty()){
					
					System.out.println("value of start in post: "+str);
					long interval=Long.parseLong(str);
					long startTime=(long) session.getAttribute("startTime");
					int time=(int) (interval-startTime);
					System.out.println("value of int: "+time);
					
					if(session.getAttribute("_timeBeforeRefresh")!=null){
						
						_timeBeforeRefresh=(int) session.getAttribute("_timeBeforeRefresh");
						System.out.println("time before refresh 1: "+_timeBeforeRefresh);
						_timeBeforeRefresh=_timeBeforeRefresh+time;
						System.out.println("time before refresh 2: "+_timeBeforeRefresh);
						session.setAttribute("_timeBeforeRefresh", _timeBeforeRefresh);
					}
				}
			}
			
			out.print(gson.toJson(_timeBeforeRefresh));
			out.flush();
			out.close();
			
		}
		
		else if(action.equalsIgnoreCase("totalTime")){
			PrintWriter out= response.getWriter();
			long end=new Date().getTime();
			long start=(long) session.getAttribute("startTime");
			if(session.getAttribute("_timeBeforeRefresh")!=null){
				
				_timeBeforeRefresh=(int) session.getAttribute("_timeBeforeRefresh");
			}
			long time=(end-start)+_timeBeforeRefresh;
			String conversion=convertTime(time);
			System.out.println("in get total time: currentPlayer: "+ session.getAttribute("currentPlayer")+" total time: "+conversion);
			
			StudentReportModel _reportModel1=new StudentReportModel();
			String studentName=(String) session.getAttribute("currentPlayer");
			java.util.Date dt = new Date();
			java.text.SimpleDateFormat sdf = 
				     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			StudentReport _record= new StudentReport(studentName,conversion,currentTime,(int)time);
			System.out.println("record to be added: "+ _record);
			
			_reportModel1.addToReport(_record);
			
			
			out.print(gson.toJson(conversion));
			out.flush();
			out.close();
		}
		
		else if(action.equalsIgnoreCase("getPlayerName")){
			
			System.out.println("hi, "+request.getParameter("person"));
			session.setAttribute("currentPlayer", request.getParameter("person"));
			long start=Long.parseLong(request.getParameter("startTime"));
			session.setAttribute("startTime", start);
			System.out.println("start time: "+session.getAttribute("startTime"));
			session.setAttribute("_timeBeforeRefresh", 0);
			
		}
	}
	
	public boolean ifVisited(int qid){
		if(visited.contains(qid))
		return true;
		else{
			visited.add(qid);
			System.out.println("visited: "+ visited.toString());
			return false;
		}
		
	}
	
	public String convertTime(long diffMs){
		long diffDays = Math.round(diffMs / 86400000); // days
 		long diffHrs = Math.round((diffMs % 86400000) / 3600000); // hours
 		long diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000); // minutes
 		long diffsec = Math.round(((diffMs % 86400000) % 3600000 % 60000) / 1000);
 		String time="";
 		
 		
 		if(diffDays==0 && diffHrs==0 && diffMins==0 && diffsec!=0){
 			time= ""+diffsec+" seconds ";
 		}
 		else if(diffDays==0 && diffHrs==0 && diffMins!=0){
 			time= ""+diffMins + " minutes, "+diffsec+" seconds ";
 		}
 		else if(diffDays==0 && diffHrs!=0){
 			time= ""+diffHrs + " hours, " + diffMins + " minutes, "+diffsec+" seconds ";
 		}
 		else{
 			time= ""+diffDays + " days, " + diffHrs + " hours, " + diffMins + " minutes, "+diffsec+" seconds ";
 		}
 		return time;
 	}
	
}
