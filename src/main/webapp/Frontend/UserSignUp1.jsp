<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*, java.sql.*"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  

  <style>
    .forumm { width: 80%; }
    .title { margin-right: auto; font-family: Georgia, 'Times New Roman', Times, serif; font-size: 50px; color: orangered; }
    .bottom-frame { padding-top: 70px; z-index: 2; }
    .top-frame { background: black; position: fixed; top: 0; left: 0; width: 100%; height: 10%; color: #fff; padding: 10px 0; display: flex; justify-content: space-between; align-items: center; z-index: 2; }
    .forumm #span { display: inline-block; width: 30%; }
    .forumm input { display: inline-block; width: 110%; }
    body { background-image: url("reg.jpg"); background-repeat: no-repeat; background-size: cover; }
    .container { background: white; margin-top: 30px; border: 1px solid black; border-radius: 7px; width: 50%; }
    .signlog { background-color: white; color: orangered; }
    a:hover { color: red; }
    .container h3 { border-bottom: 5px solid #c0c0c0; text-align: center; padding-bottom: 30px; }
    .btn { background-color: orange; color: white; }
    .navbar-nav { background-color: black; top: 10%; }
    .logo { margin-left: 0px; width: 60px; height: 55px; }
  </style>
</head>
<body>  
  <div class="top-frame">
    <div class="logo">
      <img src="logo.jpg" alt="Your Logo" height="50px">
    </div>
    <div class="title">
      <h3>Meliora</h3>
    </div>
  </div>
  
  <div class="bottom-frame">
    <div class="container">
      <h3 style="color: orangered;">User Registration</h3>
      <form class="forumm" method="post" id="reg">
        <div id="span">First Name</div>
        <input class="form-control" type="text" id="fname" required name="fname">
        <p id="chkfname">*Fill First Name</p><br />
        
        <div id="span">Last Name</div>
        <input class="form-control" type="text" id="lname" name="lname" required>
        <p id="chklname">*Fill Last Name</p><br />
        
        <div id="span">Roll Number</div>
        <input class="form-control" type="text" id="roll" name="rollNumber" required>
        <p id="chkrollNumber">*Fill RollNumber</p><br />
        
        <div id="span">Email</div>
        <input class="form-control" type="email" id="mail" name="mail" required>
        <p id="chkmail">*Fill Email</p><br />
        
        <div id="span">Phone Number</div>
        <input class="form-control" type="tel" id="pn" name="phone" required>
        <p id="chkpn">*Fill phone number</p><br />
        
        <div id="span">Gender</div>
        <select style="width:110.5%;display:inline-block" class="form-control" name="gender">
          <option value="male">Male</option>
          <option value="female">Female</option>
        </select>
        <br/>
        
        <div id="span">Password</div>
        <input class="form-control" type="password" id="pass" name="pass" required><br />
        
        <div id="span">Confirm Password</div>
        <input name="cnfpass" class="form-control" type="text" id="cpass" required>
        <p id="match">Password matched.</p><br />
        <hr/>
        <button class="btn" name="btn" type="submit" id="signupBtn" style="margin-left:45%;width:30%;">SIGN UP</button>
        <hr/>
      </form>
      <%
      if("post".equalsIgnoreCase(request.getMethod())){
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String mail = request.getParameter("mail");
        String phone = request.getParameter("phone");
        String rollNumber = request.getParameter("rollNumber");
        String gender = request.getParameter("gender");
        String password = request.getParameter("pass");
        String confirmPassword = request.getParameter("cnfpass");
        
        String URL = "jdbc:oracle:thin:@localhost:1521:xe";
        String USER = "SYSTEM";
        String PASSWORD = "system";
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
          // Validate phone number length
          if (phone != null && phone.length() != 10) {
            %>
            <script>
              alert("Phone number must contain 10 digits");
              window.location.href = 'UserSignUp1.jsp';
            </script>
            <%
            return;
          }
          
          // Check if passwords match
          if (!password.equals(confirmPassword)) {
            %>
            <script>
              alert("Password and Confirm Password do not match");
              window.location.href = 'UserSignUp1.jsp';
            </script>
            <%
            return;
          }
          
          // Database connection
          Class.forName("oracle.jdbc.driver.OracleDriver");
          conn = DriverManager.getConnection(URL, USER, PASSWORD);
          
          // Check if user already exists
          String checkSql = "SELECT * FROM users WHERE mail = ?";
          stmt = conn.prepareStatement(checkSql);
          stmt.setString(1, mail);
          ResultSet rs = stmt.executeQuery();
          
          if (rs.next()) {
            %>
            <script>
              alert("User already exists");
              window.location.href = 'UserSignUp1.jsp';
            </script>
            <%
          } else {
            // Store details in session
            session.setAttribute("fname", fname);
            session.setAttribute("lname", lname);
            session.setAttribute("mail", mail);
            session.setAttribute("phone", phone);
            session.setAttribute("rollNumber", rollNumber);
            session.setAttribute("gender", gender);
            session.setAttribute("password", password);
            
            // Generate and send OTP
            String fromName = "Meliora";
            String otp = generateOTP(4);
            String subject = "One Time Password (OTP) Confirmation for Meliora";
            String body = "<html>" +
              "<body style='font-family: Times New Roman;'>" +
              "<h3 style='font-size: 24px;'>Dear " + fname + " " + lname + ",</h3>" +
              "<p style='font-size: 18px;'>You got a new message from <strong>" + fromName + "</strong>:</p>" +
              "<p style='font-size: 16px;'>Please use the following One Time Password (OTP) <span style='font-size: 21px; color: black;'>" + otp + "</span> to complete the verification.</p>" +
              "<p>Do not share this OTP with anyone.</p>" +
              "<h4 style='font-size: 18px;'>Best wishes,</h4><br/><p style='font-size: 18px;'>Meliora team.</p>" +
              "</body>" +
              "</html>";
            
            try {
              session.setAttribute("generatedOtp", otp);
              sendEmail(mail, subject, body);
              %>
              <script>
                
                window.location.href = 'VerifyOTP.jsp'; // Create this page separately
              </script>
              <%
            } catch (MessagingException e) {
              out.println("<p>Error sending email: " + e.getMessage() + "</p>");
            }
          }
        } catch(SQLException e) {
          e.printStackTrace();
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          if(stmt != null) stmt.close();
          if(conn != null) conn.close();
        }
      }
      %>
      <hr />
      <h6>Already Signup! <a class="signlog" href="UserLogin1.jsp">Login here</a></h6>
      <br /><hr />
    </div>
  </div>
  
  <%!
    // [Email credentials and methods remain unchanged from your original code]
    private static final String FROM_EMAIL = "meliora945@gmail.com"; 
    private static final String EMAIL_PASSWORD = "spkf tjhu nbxw cqya";

    public String generateOTP(int length) {
        String numbers = "0123456789";
        Random random = new Random();
        StringBuilder otp = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            otp.append(numbers.charAt(random.nextInt(numbers.length())));
        }
        return otp.toString();
    }

    public void sendEmail(String to, String subject, String body) throws MessagingException {
        String host = "smtp.gmail.com";

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setContent(body, "text/html");

        Transport.send(message);
    }
%>
</body>
</html>