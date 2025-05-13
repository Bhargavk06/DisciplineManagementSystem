<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*, java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Home</title>
<style>
form {
	width: 100%;
}

input[type="text"] {
	padding: 5px;
	margin: 10px 0;
	width: 200px;
}

input[type="submit"] {
	padding: 5px 15px;
	background-color: #ff4500;
	color: white;
	border: none;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #e13c00;
}
</style>
</head>
<body>
	<div>
		<form  method="get">
			Roll Number: <input type="text" name="rollNumber"
				placeholder="Enter Roll Number"><br> <input
				type="submit" value="Search">
		</form>

		<%
       String rollNumber=request.getParameter("rollNumber");
       if(rollNumber!= null && !rollNumber.trim().isEmpty()){
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
               String sql="select * from StudentInfo where s_rollNumber=?";
               stmt=conn.prepareStatement(sql);
               stmt.setString(1,rollNumber);
               rs=stmt.executeQuery();
               if(rs.next()){
            	   String studentName=rs.getString("s_name");
            	   String branch=rs.getString("s_branch");
            	   String year=rs.getString("s_year");
            	   String section=rs.getString("s_section");
            	   String phoneNumber=rs.getString("s_phone");
            	   String email=rs.getString("s_email");
            	   %>
            	   <h2>Student Details for rollnumber: <%=rollNumber%> </h2>
            	   <h3>StudentName: <%=studentName%></h3>
            	   <h3>branch: <%=branch%></h3>
            	   <h3>year: <%=year%></h3>
            	   <h3>section: <%=section%></h3>
            	   <h3>phoneNumber: <%=phoneNumber%></h3>
            	   <h3>email: <%=email%></h3>
            	   <%    	   
            	   
               }else{
            	   %>
            	   <h3>Student Not found with rollnumber <%=rollNumber %></h3>
            	   <% 
               }
           }
            		   
           catch(Exception e){
        	   e.printStackTrace();
           }
           finally{
        	   if(rs!=null) rs.close();
        	   if(stmt!=null) stmt.close();
        	   if(conn!=null) conn.close();
           }
    	   
       }
       
       
       
       
       
       %>
	</div>
</body>
</html>