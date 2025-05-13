<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*, java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to the Complaint System</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
    <!-- jQuery, Popper.js, Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <!-- JavaScript for custom functions -->
    <script>
        function forgotPassword() {
            window.location.href = 'forgot_password.jsp';
        }
        
       
    </script>
    
    <style>
        body {
            background-color: rgba(255, 255, 255, 0.951);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            border-radius: 20px;
            width: 800px;
            height: 460px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
        }
        .container h3 {
            margin-top: 20px;
            color: #FFA500;
            font-weight: bold;
        }
        .form-control {
            margin-top: 25px;
            margin-bottom: 25px;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }
        .btn-login, .btn-forgot {
            border: none;
            border-radius: 10px;
            padding: 10px;
            margin-top: 10px;
        }
        .btn-login {
            background-color: #FFD700;
            color: black;
            width: 28%;
        }
        .btn-forgot {
            background-color: #D3D3D3;
            color: black;
            width: 68%;
        }
        .btn-account {
            background-color: #FFA500;
            color: white;
            width: 100%;
            border: none;
            border-radius: 10px;
            padding: 10px;
            margin-top: 10px;
        }
        .logo img {
             margin-left: 0px;
             width: 90px;
             height: 70px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="logo1.png" alt="Your Logo">
        </div>
        <h3>User Log in</h3>
        <form method="POST">
            <input type="text" class="form-control" placeholder="RollNumber" name="rollNumber">
            <input type="password" class="form-control" placeholder="Password" name="pass">
             <div class="d-flex justify-content-between">
                <input type="submit" class="btn-login " value="Login">
                <button type="button" class="btn-forgot" onclick="forgotPassword()">Forgot Password</button>
            </div>
        </form>
        <%
        if("post".equalsIgnoreCase(request.getMethod())){
            String rollNumber=request.getParameter("rollNumber");
            String password=request.getParameter("pass");
            
         	   String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Change this URL based on your database configuration
                String USER = "SYSTEM";  // Database username
                String PASSWORD = "system";  // Database password\
                Connection conn=null;
                PreparedStatement stmt=null;
                ResultSet rs=null;
                
                try {
                    // Load the Oracle JDBC driver (optional for newer versions)
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn= DriverManager.getConnection(URL, USER, PASSWORD);
                    String sql="select rollNumber,password from users where rollNumber=? and password=?";
                    stmt=conn.prepareStatement(sql);
                    stmt.setString(1,rollNumber);
                    stmt.setString(2,password); 
                    rs=stmt.executeQuery();
                    if(rs.next()){
                    	session.setAttribute("rollNumber", rs.getString("rollNumber"));
                    	response.sendRedirect("StudentDashboard.jsp");
                  	 
                    }else{
                  	  %>
                  	  <script>
                  	  alert("Invalid credentials, Please try again!");
                  	  
                  	  </script>
                  	  <% 
                 	   
                    }
                }
                 		   
                catch(Exception e){
             	   e.printStackTrace();
             	   //out.println(e.getErrorCode());
                }
                finally{
                	if(rs!=null) rs.close();
             	   if(stmt!=null) stmt.close();
             	   if(conn!=null) conn.close();
                }
         	   
            }
            
            
            
            %>
            
        
        
        
        <form action="UserSignUp1.jsp" method="POST">
            <button type="submit" class="btn-account">Create New Account</button>
        </form>
    </div>
</body>
</html>