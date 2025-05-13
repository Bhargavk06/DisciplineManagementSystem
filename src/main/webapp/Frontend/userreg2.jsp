<%@ page import="java.sql.*" %>
<%
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String password = request.getParameter("pass");

    // Hash the password
   // String hashedPassword = PasswordUtil.hashPassword(password);

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "system");

        String sql = "INSERT INTO student (s_firstname, s_lastname, s_username, s_email, s_phno, s_gender, s_password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, fname);
        pstmt.setString(2, lname);
        pstmt.setString(3, username);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.setString(6, gender);
        pstmt.setString(7,password);

        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            out.println("<h3>User registered successfully!</h3>");
            out.println("<a href='UserLogin.html'>Go to Login Page</a>");
        } else {
            out.println("<h3>Registration failed. Please try again.</h3>");
        }
    } catch (Exception e) {
        System.out.println(e);
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
