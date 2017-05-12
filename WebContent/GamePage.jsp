<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cyber Security Scavenger Hunt - University of Memphis</title>
<script type="text/javascript" src="js/jquery-1.6.2.js"></script>

<style type="text/css">
html, body { height: 100%; margin: 0; padding: 0; } #map { height: 100%; }

.customButton {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}



</style>


</head>
<body>
<div id="map"></div>
<input type="hidden" id="_ispostback" value="<%=session.getAttribute("currentPlayer")%>" />
<input type="hidden" id="_timeBeforeRefresh" />
<script type="text/javascript">

			 	var start;
			 	var end;
			 	//var d=new Date();
			 	
				function getPlayerName(){
					
					    var p = prompt("Please enter your name","Your Name");
					    var person=p.trim();
					    if(person=="" || person=="Your Name"){
					    	window.location.href = "ScavengerHunt?action=HomePage";
					    }
					    else{
					    	start=new Date().getTime();
					    	//alert("start in get player name: "+start);
					       $.ajax({
					 			type:'post',
					 			url: 'ScavengerHunt?action=getPlayerName&person='+person+'&startTime='+start,
					 			async: true,
					 			cache: true,
					 			headers: {
					 				  Accept: "application/json; charset=utf-8",
					 				  "Content-Type": "application/json; charset=utf-8"
					 			  },
					 			success: function(){
					 				
					 				//alert("Hi, " + person+"! Your start time is "+start);
					 			}
					 		});
					    }
					   
					
				}
				
				//var timet;
				function IsPostBack(){
					var refresh=document.getElementById("_ispostback").value;
					//alert(document.getElementById('_timeBeforeRefresh').value);
					//alert(timet);
					if(refresh==""||refresh==null)
						return false;
					
					
					var _timeBeforeRefresh=new Date().getTime();
					
					//alert("t: "+t+" start: "+start);
					$.ajax({
			 			type:'POST',
			 			url: 'ScavengerHunt?action=refreshed&_timeBeforeRefresh='+_timeBeforeRefresh,
			 			async: true,
			 			cache: true,
			 			
			 			headers: {
			 				  Accept: "application/json; charset=utf-8",
			 				  "Content-Type": "application/json; charset=utf-8"
			 			  },
			 			success: function(result){
			 				var _timeBeforeRefresh=$.parseJSON(result);
			 				//alert("_timeBeforeRefresh: "+_timeBeforeRefresh);
			 			}
			 			
			 		});
					
					//timet=document.getElementById('_timeBeforeRefresh').value;
					return true;
				}
				
				
				
			 	 $(document).ready(function(){
			 		if(!IsPostBack())
			 			getPlayerName();
			 	});
			 	  
			 	var map;
			 	var minzoom = 17;
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
			 					 [0, 'Dunn Hall (Computer Science Department)', 35.121280, -89.938016, 'Go to the building where programming classes are most likely held'],
			 					 [1, 'Psychology Building', 35.121240, -89.939134, 'Find the building where students study about human behaviour and the mind'],
			 					 [2, 'FedEx Institute of Technology', 35.121763, -89.940034, 'This building is named after the no. 1 shipping company'],
			 					 [3, 'Memorial field', 35.118984, -89.935362, 'Click on the spot that you think is the best place to play outdoor games like soccer'],
			 					 [4, 'Art Building', 35.120033, -89.938845, 'Which building would encourage you to express your artistic abilities?'],
			 					 [5, 'John S. Wilder Tower', 35.117837, -89.939784, 'Find the tallest building in University of Memphis'],
			 					 [6, 'Ned R. McWherter Library', 35.121072, -89.935969, 'If you love books then you will love this building'],
			 					 [7, 'Theatre Building', 35.122516, -89.937214, 'Do you like acting? if you do, then find out the building where you can learn it'],
			 					 [8, 'Hudson Health Center', 35.120024, -89.936507, 'Where will you take your friend if he/she is injured?'],
			 					 [9, 'Rudi E. School of Music', 35.122410, -89.936323, 'If you want to learn Piano, where would you go?'],
			 					 [10, 'Holiday Inn', 35.123598, -89.938339, 'This building most likely has classes for Hospitality Management Training.'],
			 					 [11, 'University Center', 35.117542, -89.937314, 'This is where students often get together as a community or take breaks between classes.</br>It has a whole lot of options for good eats.'],
			 					 [12, 'Michael D. Rose Theater', 35.118167, -89.936009,'This building is the most entertaining one.</br> If you want to see a stage performance or shows,</br> this is where you go. Guess the building'],
			 					 [13, 'Engineering and Technology Building',35.121666, -89.935287,'Most of the engineering classes are held here'],
			 					 [14, 'Fogelman College of Business and Economics',35.122276, -89.939595,'This building is one of the premier schools and business and economics in mid south. Find the building.'],
			 					 [15, 'Campus Elementary School',35.116708, -89.934524,'Find a school in the university campus.']
			 					 ];


			 	function getListOfMarkers(){
			 		  var visitedMarker=[];
			 		  var i = parseInt(Math.random()*16);
			 		  var j=0;
			 	   	 while(visitedMarker.length<6){
			 	   		 if(!check(i,visitedMarker)){
			 	   			 visitedMarker[j]=i;
			 				 j++;
			 				 }
			 	   		 i=parseInt(Math.random()*16);
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
			 		var myCenter={lat: 35.120435, lng: -89.936797};
			 		  
			 		map = new google.maps.Map(document.getElementById('map'), {
			 			  center: myCenter,
			 				streetViewControl:false,
			 				zoom:17,
			 				mapTypeId: google.maps.MapTypeId.SATELLITE
			 		  });
			 		  
			 			//setting zoom limitation
			 				google.maps.event.addListener(map, 'zoom_changed', function() {
			 				     if (map.getZoom() < minzoom) map.setZoom(minzoom);
			 				   if (map.getZoom() > maxzoom) map.setZoom(maxzoom);
			 				   });
			 				
			 				//bounds for UoM
			 				
			 				var strictBounds = new google.maps.LatLngBounds(
			 					     new google.maps.LatLng(35.117821, -89.941464), 
			 					     new google.maps.LatLng(35.122709, -89.934093)
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
			 						end= new Date().getTime();
			 						var extraTime=<%= session.getAttribute("_timeBeforeRefresh") %>;
			 						var startTime=<%= session.getAttribute("startTime") %>;
			 						//alert("extra time:"+extraTime+" startTime: "+startTime+" end: "+end);
			 						//var timeTaken=TotalTime();
			 						//var timeTaken=calculateTime(startTime,end,extraTime);
			 						//sendTime(start);
			 						
			 						$.ajax({
								 			type:'post',
								 			url: 'ScavengerHunt?action=totalTime',
								 			async: true,
								 			cache: true,
								 			headers: {
								 				  Accept: "application/json; charset=utf-8",
								 				  "Content-Type": "application/json; charset=utf-8"
								 			  },
								 			success: function(result){
								 				var time=$.parseJSON(result);
								 				alert("Good Game!!! You took "+time+" to finish the game.");
						 						window.location.href = "ScavengerHunt?action=HomePage";
								 			}
								 		});
			 						
			 						
			 						
			 						/* if (confirm("Good Game!!! you took "+timeTaken+" to finish the game. Do you want to Play Again?") == true) {
			 					        window.location.href = "ScavengerHunt?action=ScavengerHuntMainPage";
			 					    } else {
			 					    	window.location.href = "ScavengerHunt?action=HomePage";
			 					    }
			 					     */
			 						
			 					}
			 					
			 				
			 		  
			 		  
			 		  
			 		  var contentString = "";
			 		      
			 		     
			 		     
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
			 					          infowindowLocation.setContent('<div style="color:#808000; font-size:14px; font-weight:bold;">'+locations[i][1]+'</div>');
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
			 								infowindowStart.setContent("<div style='font-size: 16px; font-weight:bold; color:#303030;'>Click me to start</div>");
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
			 								
			 								infowindow.setContent("<div style='font-size: 16px; color:#003300;'><strong>Good Job!</strong> Click the bouncing marker for your next Question.</div>");
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
			 	
			 	function wrong(){
			 		document.getElementById("wrong").innerHTML="Wrong Answer. Try Again";
			 		setTimeout(function(){ document.getElementById("wrong").innerHTML="";},2000);

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
			 					'<div style="font-size: 20px;" id="question"><b><label style="font: italic small-caps bold 24px Georgia, sans-serif; color:#303030; ">'+questions.question+'</label></b></div></br>'+
			 						'<INPUT TYPE="radio" VALUE="1" NAME="option" id="option1"><label style="font: italic bold 16px Georgia, sans-serif; color:#303030;"><b>	'+questions.option1+'</b></label><BR>'+
			 						'<INPUT TYPE="radio" VALUE="2" NAME="option" id="option2"><label style="font: italic bold 16px Georgia, sans-serif; color:#303030;"><b>	'+questions.option2+'</b></label><BR>'+
			 						'<INPUT TYPE="radio" VALUE="3" NAME="option" id="option3"><label style="font: italic bold 16px Georgia, sans-serif; color:#303030;"><b>	'+questions.option3+'</b></label><BR>'+
			 						'<INPUT TYPE="radio" VALUE="4" NAME="option" id="option4"><label style="font: italic bold 16px Georgia, sans-serif; color:#303030;"><b>	'+questions.option4+'</b></label><BR>'+
			 						'<b><label id="wrong" style="color: red;"></label></b><br>'+
			 						'</b><INPUT TYPE="SUBMIT" VALUE="Submit Answer" onclick="wrong()" class="customButton">'+
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
			 			 
			 			     currentWin.setContent('<div style="font-size: 12px;"><b>Clue: </b><div style="font-size: 16px;"><strong>'+locations[next][4]+'</strong></div>');
			 			    clueFlag=1;
			 			    cluewindow="open";
			 			    return false;
			 			    // goToQuestion();
			 			     
			 		 }
			 		 
			 	}
			</script> 
		<script src="https://maps.googleapis.com/maps/api/js?callback=initMap"></script>
		
</body>
</html>