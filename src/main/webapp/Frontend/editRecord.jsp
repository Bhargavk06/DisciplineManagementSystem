<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Record</title>
</head>
<body>
<%
    String recordId = request.getParameter("recordId");  // Use recordId for unique identification
    String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    String USER = "SYSTEM";
    String PASSWORD = "system";
    Class.forName("oracle.jdbc.driver.OracleDriver");

    Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Discipline WHERE recordId = ?");
    stmt.setString(1, recordId);  // Query using recordId
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
%>
    <h2>Edit Discipline Record</h2>
    <form method="post" action="updateRecord.jsp">
        <input type="hidden" name="recordId" value="<%= rs.getString("recordId") %>"> <!-- Use recordId -->
        Date: <input type="date" name="incidentDate" value="<%= rs.getDate("IncidentDate") %>"><br>
        Incident: <input type="text" name="incident" value="<%= rs.getString("Incident") %>"><br>
        Description: <textarea name="description"><%= rs.getString("Description") %></textarea><br>
        Damage: <input type="text" name="damage" value="<%= rs.getString("Damage") %>"><br>
        Action Taken: <input type="text" name="actionTaken" value="<%= rs.getString("ActionTaken") %>"><br>
        <input type="submit" value="Update">
    </form>
<%
    } else {
        out.println("<p>No record found.</p>");
    }
    rs.close();
    stmt.close();
    conn.close();
%>
</body>
</html>
