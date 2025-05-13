<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <title>User Type Selection</title>
    <style>
        body {
            text-align: center;
            font-family: 'Open Sans', sans-serif;
            background-color: white;
            margin-top: 1%;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 70vh;
            width: 218vh;
        }

        .title {
            padding: 10px;
            margin: 15px;
            border-radius: 10px;
            margin-top: 1%;
        }

        .top-cards {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            background-color: whitesmoke;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        .user-card {
            flex: 1;
            background-color: #ffffff;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            margin: 70px 90px;

        }

        img {
            width: 200px;
            height: 200px;
            margin: 10px 10px;
            display: block;
            cursor: pointer;
        }

        button {
            color: black;
            border: none;
            padding: 10px 25px;
            cursor: pointer;
            margin-top: 10px;
            font-family: "Open Sans", sans-serif;   
        }

        .back-button {
            color: black;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 50px;
            font-family: "Open Sans", sans-serif;
            filter: drop-shadow( 0 0 100px rgba(0, 0, 0, 0.2));
        }
    </style>
</head>
<body>
    <div class="title">
        <h1>Select User Type</h1>
    </div>
    <div class="container">        
        <div class="top-cards">
            <div class="user-card">
                <img onclick="redirectToStudentLogin()" src="https://static.vecteezy.com/system/resources/previews/026/614/078/original/student-icon-or-logo-isolated-sign-symbol-suitable-for-display-website-logo-and-designer-high-quality-black-style-icon-icon-design-free-vector.jpg" alt="User">
                <p onclick="redirectToStudentLogin()"><strong>USER</strong></p>
            </div>
            <div class="user-card">
                <img src="../images/admin1.png" onclick="redirectToAdminLogin()" alt="Admin">
                <p onclick="redirectToAdminLogin()"><strong>ADMIN</strong></p>
            </div>
        </div>
        <button class="back-button" onclick="goBack()"> <strong>Back</strong> </button>
    </div>

    <script>
        function redirectToStudentLogin() {
            window.location.href = "UserLogin1.jsp"; 
        }

        function redirectToAdminLogin() {
            window.location.href = "AdminLogin1.jsp"; 
        }

        function goBack() {
            window.location.href = "index1.jsp"; 
        }
    </script>
</body>
</html>
