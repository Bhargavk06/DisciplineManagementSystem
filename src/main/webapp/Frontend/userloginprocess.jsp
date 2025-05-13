<%@ page import="java.sql.*," %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");


    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "system");

        String sql = "SELECT * FROM users WHERE s_username = ? AND s_password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Successful login
            session.setAttribute("username", username);
            response.sendRedirect("StudentDashboard.jsp");
        } else {
            // Failed login
            %>
            <script>
                alert("Invalid username or password!");
                window.location.href = "UserLogin1.jsp";
            </script>
            <%
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        %>
        <script>
            alert("An error occurred. Please try again.");
            window.location.href = "UserLogin1.jsp";
        </script>
        <%
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>