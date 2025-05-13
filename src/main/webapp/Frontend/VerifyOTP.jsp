<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <!-- Add same CSS and Bootstrap links as in UserSignUp1.jsp -->
</head>
<body>
  <div class="container">
    <h3 style="color: orangered;">OTP Verification</h3>
    <form method="post">
      <div id="span">Enter OTP</div>
      <input class="form-control" type="text" name="otp" required><br/>
      <button class="btn" type="submit">Verify</button>
    </form>
    <%
    if("post".equalsIgnoreCase(request.getMethod())){
      String enteredOtp = request.getParameter("otp");
      String generatedOtp = (String) session.getAttribute("generatedOtp");
      
      if(enteredOtp.equals(generatedOtp)){
        String URL = "jdbc:oracle:thin:@localhost:1521:xe";
        String USER = "SYSTEM";
        String PASSWORD = "system";
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
          Class.forName("oracle.jdbc.driver.OracleDriver");
          conn = DriverManager.getConnection(URL, USER, PASSWORD);
          
          String sql = "insert into users values(?,?,?,?,?,?,?)";
          stmt = conn.prepareStatement(sql);
          stmt.setString(1, (String)session.getAttribute("fname"));
          stmt.setString(2, (String)session.getAttribute("lname"));
          stmt.setString(3, (String)session.getAttribute("rollNumber"));
          stmt.setString(4, (String)session.getAttribute("mail"));
          stmt.setString(5, (String)session.getAttribute("phone"));
          stmt.setString(6, (String)session.getAttribute("gender"));
          stmt.setString(7, (String)session.getAttribute("password"));
          
          int rowsInserted = stmt.executeUpdate();

          String generatedotp= (String)session.getAttribute("generatedOtp");
          out.println(generatedotp);
          if(rowsInserted > 0){
        	 
            %>
            <script>
              alert("Registration successful");
              window.location.href = 'UserLogin1.jsp';
            </script>
            <%
          }
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          if(stmt != null) stmt.close();
          if(conn != null) conn.close();
        }
      } else {
        %>
        <script>
          alert("Invalid OTP");
        </script>
        <%
      }
    }
    %>
  </div>
</body>
</html>