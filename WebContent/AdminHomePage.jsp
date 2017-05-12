<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
	<head>
		<title>Admin Home Page - University of Memphis</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="js/html5shiv.js"></script><![endif]-->
		<script src="js/jquery.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
		<noscript>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-xlarge.css" />
		</noscript>
		<script type="text/javascript" src="js/jquery-1.6.2.js"></script>
		<script type="text/javascript">
		
		function authenticate(){
			
			
			var pass = prompt("Please provide password to continue","Password");
			if(pass!="bootcamp2016"){
				window.location.href = "ScavengerHunt?action=HomePage"
			}
	}
		
		function IsPostBack(){
			var refresh=document.getElementById("_ispostback").value;
			//alert(document.getElementById('_timeBeforeRefresh').value);
			//alert(timet);
			if(refresh==""||refresh==null)
				return false;
			
			return true;
		}
 	
 	 $(document).ready(function(){
 		if(!IsPostBack())
 		authenticate();
 	});
		
		
		function validateForm() {
		    var q = document.forms["myForm"]["Question"].value;
		    var o1 = document.forms["myForm"]["Option1"].value;
		    var o2 = document.forms["myForm"]["Option2"].value;
		    var o3 = document.forms["myForm"]["Option3"].value;
		    var o4 = document.forms["myForm"]["Option4"].value;
		    var ans = document.forms["myForm"]["CorrectAns"].value;
		    if (q == null || q == ""||o1 == null || o1 == ""||o2 == null || o2 == ""||o3 == null || o3 == ""||o4 == null || o4 == ""||ans == null || ans == "") {
		        alert("All fields are mandatory");
		        return false;
		    }
		    if(isNaN(ans)){
		    	alert("Last field has to be a number between 1 ans 4");
		    	return false;
		    }
		    
		}
		
		function reset(){
			document.getElementById("form").reset();
		}
	
		</script>
	</head>
	<body>

		<!-- Header -->
			<header  id="header" class="alt">
			 
			 <h2><div style="width:800px; position: absolute; left: 290px;top: 13px;z-index: -1;"><a href="ScavengerHunt?action=HomePage"><img alt="" src="images/UofM.jpg" style="width:100%; opacity:0.9;"></a></div></h2><br>
			 
			</header> 


		<!-- Main -->
			<section id="main" class="wrapper">
				<div class="container">
					<header class="major special">
						<h2>Admin Home Page</h2>
						<p></p>
					</header>

					
					<!-- Lists -->
						<section>
							<h3>Add a question</h3>
							<form method ="POST" action="ScavengerHunt?action=addQuestion" name="myForm" onsubmit="return validateForm()" id="form">
							<div class="row">
								<div class="6u 12u$(xsmall)">
		
									<h4>
									<textarea rows="4" cols="50"  name="Question" placeholder="Type your question"></textarea>
									</h4>
									<ul class="alt">
  									<li>Option 1<input type="text" name="Option1" > </li>
  									<li>Option 2<input type="text" name="Option2" > </li>
  									<li>Option 3<input type="text" name="Option3" > </li>
  									<li>Option 4<input type="text" name="Option4" > </li>
									<li>Correct Option Number<input type="text" name="CorrectAns" > </li>
									
									</ul>

								</div>
								
							</div>

							
							<ul class="actions">
								<li><input type="submit" value ="submit" onclick="reset"></li>
								
							</ul>
							
							</form>
						</section>

					<!-- Table -->
						<section>
						
						
						<script type="text/javascript">
						
						</script>
							
							<input type="hidden" id="_ispostback" value="<%=session.getAttribute("pass")%>" />
							<div class="table-wrapper">
							<br><br>
							<h3>Player Rankings</h3>
							<h4></h4>
							
								<table class="td2">
									<thead>
										<tr>
											
											<th>Player's Name</th>
											<th>Time to finish the game</th>
											<th>Date</th>
											
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${report }" var="record">
										<tr class="rowToClick">
											
											<td>${record.studentName }</td>
											<td>${record.time }</td>
											<td>${record.dateOfTest} </td>
										</tr>
										
										</c:forEach>
										
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td></td>
										</tr>
									</tfoot>
								</table>
								
								<br><br>
							<h3>List of Questions</h3>
							<h4></h4>
								<table class="td1">
									<thead>
										<tr>
											
											<th>Question</th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${all_questions }" var="question">
										<tr class="rowToClick">
											
											<td>${question.question }</td>
											
											<td><a href="ScavengerHunt?action=delete&QID=<c:out value="${question.QID}"/>">Delete</a></td>
										</tr>
										
										</c:forEach>
										
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td></td>
										</tr>
									</tfoot>
								</table>
								
								
							</div>
							
						</section>

					

					

					

		<!-- Footer -->
			<footer id="footer">
				<div class="container">
					<ul class="icons">
						<li><a href="#" class="icon fa-facebook"></a></li>
						<li><a href="#" class="icon fa-twitter"></a></li>
						<li><a href="#" class="icon fa-instagram"></a></li>
					</ul>
					<!-- <ul class="copyright">
						<li>&copy; Untitled</li>
						<li>Design: <a href="http://templated.co">TEMPLATED</a></li>
						<li>Images: <a href="http://unsplash.com">Unsplash</a></li>
					</ul> -->
				</div>
			</footer>

	</body>
</html>