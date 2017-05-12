<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
	Spatial by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head >
		<title>University of Memphis - Scavenger Hunt</title>
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
		
<!-- 		<script src="https://maps.googleapis.com/maps/api/js?callback=initialize"></script> -->
    
    <style>
      
       
       
       #map {
        height: 600px;
        width:1000px;
       
    	
    	left: 0;
    	right: 0;

    margin: auto;
      }
      
   
      
      #map-canvas{
      height: 300px;
        width:400px;
      }
      </style>


	</head>
	<body >

		<!-- Header -->
			<header id="header" class="alt">
				<h1><strong><a href="ScavengerHunt?action=HomePage"><img alt="" src="images/universityLogo.png" height="80" width="270"></a></a></strong></h1>
				<nav id="nav">
					<ul>
						
						
						<li><a href=""><img alt="" src="images/frontDesign.png" height="120" width="180"></a></li>
					</ul>
				</nav>
			</header>

		<!-- Main -->
		
		
			<section id="main" class="wrapper">
				<div class="container">

					<header class="major special">
						<h2>Scavenger Hunt</h2>
						<p>There is more treasure in the books than in all the treasure island</p>
						
					</header>
					
					
					<a href="#" class="image fit">
					<div id="map"></div>
					<%-- <c:set var="start" value="${start} }"></c:set> --%>
					
	
					
					<!-- Javascript to display code  -->
					
					</a>
			
				
			 	<script type="text/javascript">
			 	var start;
			 	var end;
			 	//var d=new Date();
			 	
				function getPlayerName(){
					
					    var person = prompt("Please enter your name","Your Name");
					    if(person=="" || person=="Your Name"){
					    	window.location.href = "ScavengerHunt?action=HomePage";
					    }
					    else{
					    	start=new Date();
					       $.ajax({
					 			type:'post',
					 			url: 'ScavengerHunt?action=getPlayerName&person='+person,
					 			async: true,
					 			cache: true,
					 			headers: {
					 				  Accept: "application/json; charset=utf-8",
					 				  "Content-Type": "application/json; charset=utf-8"
					 			  },
					 			success: function(){
					 				
					 				//alert("Hi, " + person);
					 			}
					 		});
					    }
					   
					
				}
			 	
			 	 $(document).ready(function(){
			 		
			 		getPlayerName();
			 	});
			 	  
			 	var map;
			 	var minzoom = 16;
			 	var maxzoom = 18;
			 	var present,next;
			 	var flag=0;

			 	var currentMarkers;
			 	var marker, presentMarker;
			 	var currentWin;
			 	var visited=[];
			 	var infowindow;
			 	var alreadyClicked=0;
			 	var prev;
			 	var cluewindow="closed";
			 	
			 	//var clues=[[0,'']];
			 	var locations = [
			 					 [0, 'Dunn Hall (Computer Science Department)', 35.121280, -89.938016, 'Find the building where cyber security classes are held'],
			 					 [1, 'Psychology Building', 35.121240, -89.939134, 'Find the building where students study about human behaviour and mind'],
			 					 [2, 'FedEx Institute of Technology', 35.121763, -89.940034, 'Find the building in the university that is build by a fortune 500 company headquatered in Memphis'],
			 					 [3, 'The Fogelman College of Business & Economics', 35.122606, -89.939541, 'Find the building in the campus which is one of the premier schools of business in the Mid-South'],
			 					 [4, 'Art and Communication Building', 35.121995, -89.937317, 'Find the building that is the destination for arts-centered training'],
			 					 [5, 'John S. Wilder Tower', 35.117837, -89.939784, 'Find the tallest building in University of Memphis'],
			 					 [6, 'Ned R. McWherter Library', 35.121072, -89.935969, 'If you are a nerd then you will love this building'],
			 					 [7, 'Theatre Building', 35.122516, -89.937214, 'Do you like acting? if you do, then find out the building where you can learn it'],
			 					 [8, 'Hudson Health Center', 35.120024, -89.936507, 'Where will you take your friend if he/she is injured?'],
			 					 [9, 'Rudi E. Schollof Music', 35.122410, -89.936323, 'Find the building where you can find atleast one guitar player'],
			 					 [10, 'Holiday Inn', 35.123598, -89.938339, 'Find the building where you will most probably find the tourists']
			 					    ];


			 	function getListOfMarkers(){
			 		  var visitedMarker=[];
			 		  var i = parseInt(Math.random()*11);
			 		  var j=0;
			 	   	 while(visitedMarker.length<6){
			 	   		 if(!check(i,visitedMarker)){
			 	   			 visitedMarker[j]=i;
			 				 j++;
			 				 }
			 	   		 i=parseInt(Math.random()*11);
			 		   	 }
			 	   	 return visitedMarker;
			 	}

			 	function check(j,arr){
			 		for (var i =0;i<arr.length;i++){
			 			if(arr[i]==j){
			 				return true;
			 			}
			 		}
			 		return false;
			 	}

			 	var arrayOfmarkers = getListOfMarkers();

			 	function getPresentMarker(){
			 			
			 			for(var i=0;i<arrayOfmarkers.length-1;i++){
			 				if(visited.length==0)
			 					{
			 					present=arrayOfmarkers[i];
			 					next=arrayOfmarkers[i+1];
			 					visited[0]=present;
			 					//alert("present: "+present+" next:"+next+" visited: "+visited.toString());
			 					return present +","+next;
			 					}
			 				
			 				else if(visited.length<6){
			 					//alert("visited.length: "+visited.length);
			 					if(!check(arrayOfmarkers[i],visited)){
			 						present=arrayOfmarkers[i];
			 						next=arrayOfmarkers[i+1];
			 						for(var j=0;j<visited.length;j++);
			 						visited[j]=present;
			 						//alert("present: "+present+" next:"+next+" visited: "+visited.toString());
			 						return present +","+next;
			 					}
			 				}
			 				else{
			 					return null;
			 				}
			 				//alert("present: "+present+" next:"+next+" visited: "+visited.toString());
			 				
			 			}
			 			
			 		}
			 		

			 	function initMap() {
			 		var myCenter={lat: 35.121641, lng: -89.937788};
			 		  
			 		map = new google.maps.Map(document.getElementById('map'), {
			 			  center: myCenter,
			 				streetViewControl:false,
			 				zoom:16,
			 				mapTypeId: google.maps.MapTypeId.SATELLITE
			 		  });
			 		  
			 			//setting zoom limitation
			 				google.maps.event.addListener(map, 'zoom_changed', function() {
			 				     if (map.getZoom() < minzoom) map.setZoom(minzoom);
			 				   if (map.getZoom() > maxzoom) map.setZoom(maxzoom);
			 				   });
			 				
			 				//bounds for UoM
			 				
			 				var strictBounds = new google.maps.LatLngBounds(
			 					     new google.maps.LatLng(35.121586, -89.940079), 
			 					     new google.maps.LatLng(35.122370, -89.935571)
			 					   );
			 				
			 			// Listen for the dragend event
			 			   google.maps.event.addListener(map, 'dragend', function() {
			 			     if (strictBounds.contains(map.getCenter())) return;

			 			     // We're out of bounds - Move the map back within the bounds

			 			     var c = map.getCenter(),
			 			         x = c.lng(),
			 			         y = c.lat(),
			 			         maxX = strictBounds.getNorthEast().lng(),
			 			         maxY = strictBounds.getNorthEast().lat(),
			 			         minX = strictBounds.getSouthWest().lng(),
			 			         minY = strictBounds.getSouthWest().lat();

			 			     if (x < minX) x = minX;
			 			     if (x > maxX) x = maxX;
			 			     if (y < minY) y = minY;
			 			     if (y > maxY) y = maxY;

			 			     map.setCenter(new google.maps.LatLng(y, x));
			 			   });
			 			
			 			
			 			   
			 					var value=getPresentMarker();
			 					if(value!=null){
			 							currentMarkers=value.split(",");
			 							present=parseInt(currentMarkers[0]);
			 							next=parseInt(currentMarkers[1]);
			 						//alert("present: "+present+" next: "+next)	; 
			 						}
			 					else{
			 						currentWin.close();
			 						end= new Date();
			 						var timeTaken=calculateTime(start,end);
			 						//sendTime(start);
			 						if (confirm("Good Game!!! you took "+timeTaken+" to finish the game.</br> Do you want to Play Again?") == true) {
			 					        window.location.href = "ScavengerHunt?action=ScavengerHuntMainPage";
			 					    } else {
			 					    	window.location.href = "ScavengerHunt?action=HomePage";
			 					    }
			 					    
			 						
			 					}
			 					
			 				
			 		  
			 		  
			 		  
			 		  var contentString = '<div id="content">'+
			 		      '<div id="siteNotice">'+
			 		      '</div>'+
			 		      '<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
			 		      '<div id="bodyContent">'+
			 		      '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
			 		      'sandstone rock formation in the southern part of the '+
			 		      'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) '+
			 		      'south west of the nearest large town, Alice Springs; 450&#160;km '+
			 		      '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major '+
			 		      'features of the Uluru - Kata Tjuta National Park. Uluru is '+
			 		      'sacred to the Pitjantjatjara and Yankunytjatjara, the '+
			 		      'Aboriginal people of the area. It has many springs, waterholes, '+
			 		      'rock caves and ancient paintings. Uluru is listed as a World '+
			 		      'Heritage Site.</p>'+
			 		      '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
			 		      'https://en.wikipedia.org/w/index.php?title=Uluru</a> '+
			 		      '(last visited June 22, 2009).</p>'+
			 		      '</div>'+
			 		      '</div>';
			 		      
			 		     
			 		     
			 		      var marker, presentMarker, infowindow;
			 		      var infowindowStart = new google.maps.InfoWindow();
			 			  var infowindowLocation = new google.maps.InfoWindow();
			 			  var infowindowQuestion = new google.maps.InfoWindow();
			 			  var infowindowClue = new google.maps.InfoWindow();
			 			 infowindow = new google.maps.InfoWindow({
			 				    content: contentString
			 				  });
			 				
			 		      for(var i=0;i<locations.length;i++){
			 					//alert("locations[i][0]: "+locations[i][0]);
			 					//alert("present: "+present)
			 					if(locations[i][0]!=present){
			 					marker = new google.maps.Marker({
			 				    	  position:{lat:locations[i][2], lng: locations[i][3]},
			 				    	  map: map,
			 				    	  title: locations[i][1],
			 				    	  //mid=locations[i][0]
			 				    	  });
			 					  
			 					google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
			 					        return function() {
			 					          infowindowLocation.setContent(locations[i][1]);
			 					          infowindowLocation.open(map, marker);
			 					         
			 					        }
			 					      })(marker, i));
			 					 
			 				  	google.maps.event.addListener(marker, 'mouseout', (function(marker, i) {
			 					        return function() {
			 					         setTimeout(function(){ infowindowLocation.close();},500);
			 					        }
			 					      })(marker, i)); 
			 					  
			 				 	google.maps.event.addListener(marker, 'click', (function(marker, i) {
			 				        return function() {
			 				        	//map.setCenter(marker.getPosition());
			 				        	
			 				        	if(clueFlag==1){
			 				        		if(locations[i][4]==locations[next][4]){
			 					        		clueFlag==0;
			 					        		cluewindow="closed";
			 					        		initMap();
			 					        		}
			 				        	}
			 				        }
			 				      })(marker, i));
			 	 
			 					}
			 					
			 					else{
			 						//alert("i am in else and present: "+present);
			 						alreadyClicked=0;
			 						infowindow.setContent("");
			 							presentMarker = new google.maps.Marker({
			 		  					    	  position:{lat:locations[present][2], lng: locations[present][3]},
			 		  					    	  map: map,
			 		  					    	  title: locations[i][1],
			 		  					    	  animation:google.maps.Animation.BOUNCE
			 		  					    	  });
			 							infowindow = new google.maps.InfoWindow({
			 							    content: contentString
			 							  });
			 							if(visited.length==1){
			 								//alert("in if");
			 								//start=new Date();
			 								infowindowStart.setContent("<b>Click me to start</b>");
			 								infowindowStart.open(map,presentMarker);
			 								
			 								
			 								presentMarker.addListener('click', function() {
			 									//map.setCenter(presentMarker.get);
			 									infowindowStart.close();
			 									google.maps.event.addListener(infowindow, 'domready', function(){
			 										
				 								    $(".gm-style-iw").next("div").hide();
				 								});
			 									//infowindowClue.open(map,presentMarker);
			 									load_content(map,this,infowindow);
			 									infowindowLocation.close();			
			 	    	  					  presentMarker.setAnimation(null);
			 	    	  					  });
			 							}
			 							else{
			 								
			 								infowindow.setContent("<p><strong>Good Job!</strong> Click me for your next Question.<p>");
			 								infowindow.open(map,presentMarker);
			 								presentMarker.addListener('click', function() {
			 									//infowindowClue.open(map,presentMarker);
			 									if(alreadyClicked==0){
			 										google.maps.event.addListener(infowindow, 'domready', function(){
					 								    $(".gm-style-iw").next("div").hide();
					 								});
			 									load_content(map,this,infowindow);}
			 									infowindowLocation.close();
			 	    	  					  presentMarker.setAnimation(null);
			 	    	  					  });
			 								}
			 							
			 					}
			 		      }
			 		}
			 		
			 	function calculateTime(start,end){
			 		//var today = new Date();
			 		//var Christmas = new Date("12-25-2012");
			 		//if()
			 		//alert("start: "+start+" end: "+end);
			 		var diffMs = (end-start); // milliseconds between now & Christmas
			 		var diffDays = Math.round(diffMs / 86400000); // days
			 		var diffHrs = Math.round((diffMs % 86400000) / 3600000); // hours
			 		var diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000); // minutes
			 		var diffsec = Math.round(((diffMs % 86400000) % 3600000 % 60000) / 1000);
			 		var time="";
			 		
			 		
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
			 			time= ""+diffDays + " days, " + diffHrs + " hours, " + diffMins + " minutes, "+diffsec+" seconds "
			 		}
			 		sendTime(diffMs,time);
			 		//alert(diffDays + " days, " + diffHrs + " hours, " + diffMins + " minutes, "+diffsec+" seconds ");
			 		return time;
			 	}

			 	
			 	function sendTime(diff, time){
			 		//alert("inside sendTime")
			 		if(end>start){
			 			//alert("inside sendtime-->if")
			 		$.ajax({
				 			type:'GET',
				 			url: 'ScavengerHunt?action=getTotalTime&timeDiff='+diff+'&time='+time,
				 			async: true,
				 			cache: true,
				 			
				 			headers: {
				 				  Accept: "application/json; charset=utf-8",
				 				  "Content-Type": "application/json; charset=utf-8"
				 			  },
				 			success: function(){
				 				 alert("done");
				 			}
				 			
				 		});
			 		}
			 	}
			 	function load_content(map,marker,infowindow){
			 		if(prev!=marker.getPosition()){
			 		var html="";
			 		$.ajax({
			 			type:'get',
			 			url: 'ScavengerHunt?action=GamePage',
			 			async: true,
			 			cache: true,
			 			headers: {
			 				  Accept: "application/json; charset=utf-8",
			 				  "Content-Type": "application/json; charset=utf-8"
			 			  },
			 			success: function(result){
			 				  var questions=$.parseJSON(result);
			 				  //alert("success");
			 				  html='<form id="questionBlock"'+' onsubmit='+'"showResult('+questions.correctAns+'); return false"'+'>'+
			 					'<div style="font-size: 20px;" id="question"><b>'+questions.question+'</b></div>'+
			 						'<INPUT TYPE="radio" VALUE="1" NAME="option" id="option1">'+questions.option1+'<BR>'+
			 						'<INPUT TYPE="radio" VALUE="2" NAME="option" id="option2">'+questions.option2+'<BR>'+
			 						'<INPUT TYPE="radio" VALUE="3" NAME="option" id="option3">'+questions.option3+'<BR>'+
			 						'<INPUT TYPE="radio" VALUE="4" NAME="option" id="option4">'+questions.option4+'<BR>'+
			 						'</b><INPUT TYPE="SUBMIT" VALUE="Submit Answer">'+
			 						'</form>';
			 						alreadyClicked=1;
			 				  infowindow.setContent(html);
			 					infowindow.open(map,marker);
			 					currentWin=infowindow;
			 					prev=marker.getPosition();
			 			}
			 		});
			 	}
			 		
			 		
			 	}


			 	var clueFlag=0;


			 	function get_radio_value() {
			 		var inputs = document.getElementsByName("option");
			 		for (var i = 0; i < inputs.length; i++) {
			 			if (inputs[i].checked) {
			 				return inputs[i].value;
			 			}
			 		}
			 	}
			 			      
			 	function showResult(ans){
			 		var option= get_radio_value();
			 		 if (parseInt(option)==parseInt(ans)){
			 			 //alert("correct");
			 			 
			 			     currentWin.setContent('<div>'+locations[next][4]+'</div>');
			 			    clueFlag=1;
			 			    cluewindow="open";
			 			    return false;
			 			    // goToQuestion();
			 			     
			 		 }
			 		 
			 		 else{
			 			 alert("Wrong Answer");
			 		 } 
			 	}
			</script> 
		<script src="https://maps.googleapis.com/maps/api/js?callback=initMap"></script>
   
 
			</section>

		<!-- Footer -->
			<footer id="footer">
				<div class="container">
					<ul class="icons">
						<li><a href="#" class="icon fa-facebook"></a></li>
						<li><a href="#" class="icon fa-twitter"></a></li>
						<li><a href="#" class="icon fa-instagram"></a></li>
					</ul>
					<ul class="copyright">
						<li>&copy; Untitled</li>
						<li>Design: <a href="http://templated.co">TEMPLATED</a></li>
						<li>Images: <a href="http://unsplash.com">Unsplash</a></li>
					</ul>
				</div>
			</footer>

	</body>
</html>