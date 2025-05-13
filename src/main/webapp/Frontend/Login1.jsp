<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<script> 
            window.onpageshow = function(event) {
                if (event.persisted) {
                    window.location.reload();
                }
            };  
            
            function preventBack() {
                window.history.forward();
            }
            
            // Call preventBack when the page loads and every time it gains focus
            window.onload = preventBack;
            window.onpageshow = function(event) {
                if (event.persisted) preventBack();
            };
            window.onunload = function() { null };
			function regfun() {   
				window.location.href = "UserTypeSelection1.jsp"; 
			}
			
			// For scrollable nature when clicked on explore button
			function scrollToSection(sectionId) {
				const section = document.getElementById(sectionId);
				if (section) {
					section.scrollIntoView({ behavior: "smooth" });
				}
			}
			
			function scrollToSection(sectionId) {
				const section = document.getElementById(sectionId);
				if (section) {
					section.scrollIntoView({ behavior: "smooth" });
				}
			} 
            
            
			 window.onload = function() {
	                if (typeof history.pushState === "function") {
	                    history.pushState(null, null, document.URL);
	                    window.onpopstate = function () {
	                        history.pushState(null, null, document.URL);
	                    };
	                } else {
	                    window.location.hash = "no-back";
	                    window.onhashchange = function () {
	                        if (window.location.hash !== "no-back") {
	                            window.location.hash = "no-back";
	                        }
	                    };
	                }
	            };
			
			</script> 
	
  </head>
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">  <!--For report the problme text  -->
  <style>
    
	body {
            font-family: 'Open Sans', sans-serif; 
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center; 
            align-items: center;
            background-color: white;
        }
        
        .top-frame {
            background: white;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 7%;
            color: #fff;
            padding: 10px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 2; 
            filter: drop-shadow(1px 5px 5px rgba(0, 0, 0, 0.703));        
        }
      
        h2 {
            color: orangered;
            text-align: center;
        }
  
        .logo {
            margin-left: 10px;
            width: 100px;
            height: 72.5px;
			cursor: pointer;
			
        }
        
        .bottom-image {
            margin-left: auto;
            width: 100%; 
            height: 100%; 
        }
      
        .image-text {
            position: absolute;
            top: 55%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 35px;
            color: white;
			background: rgba(0,0,0,0.5);
            z-index: 1;
            padding: 10px 20px;
            line-height: 30px;
            text-align: center; 
        }
        .abouthead {
            color: rgb(0, 0, 0);
            text-align: center;
			margin-top: 80px;
        }
        .aboutcont {
            color: black;
            text-align: center;
            padding: 0 100px;
            font-size: 18px; 
            font-family: 'Open Sans', sans-serif;
            line-height: 2.0;
			
        }
  
        h2 {
            text-align: center; /* Changed from left to center */
        }
        p {
            text-align: center; /* Changed from left to center */
        }
      
        .maxwidth {
            max-width: 100%;
        }
      
        
        button { /*For explore and login button*/
            background-color: rgb(213, 105, 28);
            color: #fff;
            border: none;
            padding: 10px 25px;
            border-radius: 30px;
            cursor: pointer;
			font-size: 18px;
        }
	
		.title { /* For Meliora title */
            margin-right: auto;
            font-family: 'Open Sans', sans-serif;
            font-size: 28px;
            font-weight: 800;
            color: black;
            text-align: center;
			cursor: pointer;
        }                               
        ::-webkit-scrollbar {
            width: 10px;
            height: 3px;
        }
        
</style>

  <body>
		<div class="maxiwidth">
		<div class="top-frame">
			<div class="logo">
			<img src="../images/vvit.jpg" alt="Your Logo" height="70px"></div>
			<div class="title">
			<h3>Meliora</h3>
			</div>
			<div class="menu">
                
				<button href="#" onclick="regfun()"><strong>Login</strong></button></div>
			</div>

		<div class="bottom-frame">
			<div class="shade"></div>
			<img class="bottom-image" src="../images/vvit.jpg"   >
			<div class="image-text">
			<h1 style="font: size 600;">   
			<p><h2>REPORT THE</h2></p>
            <p><h2>PROBLEM</h2></p>
			<p><h2>HERE!</p></h2></h1>
			<button onclick="scrollToSection('About')"><strong>Explore</strong></button>
		   
			</div>
		</div>
		<div id="About"></div>
		<div class="abouthead">
		<h1>ABOUT</h1></div>
		<div class="aboutcont">
			<p>The VVIT Discipline Management System is designed to foster a culture of accountability and excellence within our college. 
			This platform streamlines the monitoring and management of student conduct, ensuring a harmonious campus environment. 
			With features for real-time reporting, transparent communication, and effective resolution of disciplinary issues, the system empowers 
			both faculty and students to maintain a positive and respectful atmosphere.</p> 
				 
			<p>Our mission is to uphold VVIT's core values of integrity, respect, and academic excellence by leveraging technology to manage and promote discipline seamlessly. 
			Together, we aim to create an environment where students can thrive academically and personally while adhering to the highest standards of behavior.</p>
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
		
	</div>
	</body>
</html>