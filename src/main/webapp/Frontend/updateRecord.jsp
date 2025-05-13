<%@ page import="java.sql.*" %>
<%
    String recordId = request.getParameter("recordId");  // Use recordId for identification
    String incidentDate = request.getParameter("incidentDate");
    String incident = request.getParameter("incident");
    String description = request.getParameter("description");
    String damage = request.getParameter("damage");
    String actionTaken = request.getParameter("actionTaken");

    String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    String USER = "SYSTEM";
    String PASSWORD = "system";

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
    PreparedStatement stmt = conn.prepareStatement("UPDATE Discipline SET IncidentDate=?, Incident=?, Description=?, Damage=?, ActionTaken=? WHERE recordId=?");
    stmt.setDate(1, java.sql.Date.valueOf(incidentDate));
    stmt.setString(2, incident);
    stmt.setString(3, description);
    stmt.setString(4, damage);
    stmt.setString(5, actionTaken);
    stmt.setString(6, recordId);  // Use recordId to update the specific record

    int rows = stmt.executeUpdate();
    if (rows > 0) {
        out.println("<p>Record updated successfully!</p>");
    } else {
        out.println("<p>Error updating record.</p>");
    }
    stmt.close();
    conn.close();
%>
<a href="discipline.jsp">Go Back</a>
