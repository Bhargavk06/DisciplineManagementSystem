<%@ page import="java.sql.*" %>
<%
    String recordId = request.getParameter("recordId");  // Use recordId for identification

    String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    String USER = "SYSTEM";
    String PASSWORD = "system";

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
    PreparedStatement stmt = conn.prepareStatement("DELETE FROM Discipline WHERE recordId = ?");
    stmt.setString(1, recordId);  // Query using recordId

    int rows = stmt.executeUpdate();
    if (rows > 0) {
        out.println("<p>Record deleted successfully!</p>");
    } else {
        out.println("<p>No record found to delete.</p>");
    }
    stmt.close();
    conn.close();
%>
<a href="discipline.jsp">Go Back</a>
