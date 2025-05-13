<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*,java.sql.*,java.util.logging.*"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        form {
            width: 100%;
        }
        input[type="text"], textarea, input[type="date"] {
            padding: 5px;
            margin: 10px 0;
            width: 200px;
        }
        input[type="submit"], input[type="button"] {
            padding: 5px 15px;
            background-color: #ff4500;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #e13c00;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        table th {
            background-color: #f4f4f4;
        }
        #addForm {
            display: none;
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
        .error {
            color: red;
        }
        .icon {
            cursor: pointer;
            margin: 0 5px;
            font-size: 18px;
            display: inline-block;
        }
        .icon:hover {
            transform: scale(1.2);
            color: darkblue;
        }
    </style>
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
            document.getElementById('searchForm').style.display = 'none';
        }

        function editRow(element) {
            const row = element.closest("tr");
            const recordId = row.cells[0].textContent;
            window.location.href = 'editRecord.jsp?recordId=' + recordId;
        }

        function deleteRow(element) {
            const row = element.closest("tr");
            const recordId = row.cells[0].textContent;
            if (confirm("Are you sure you want to delete record ID: " + recordId + "?")) {
                window.location.href = 'deleteRecord.jsp?recordId=' + recordId;
            }
        }
    </script>
</head>
<body>
    <div>
        <form id="searchForm" method="post">
            Roll Number: <input type="text" name="rollNumber" placeholder="Enter Roll Number"><br>
            <input type="submit" value="Search">
            <input type="button" value="Add Record" onclick="showAddForm()">
        </form>

        <form id="addForm" method="post">
            <h3>Add New Discipline Record</h3>
            <input type="hidden" name="action" value="add">
            Student ID: <input type="text" name="studentId" required><br>
            Date: <input type="date" name="incidentDate" required><br>
            Incident: <input type="text" name="incident" required><br>
            Description: <textarea name="description" required></textarea><br>
            Damage: <input type="text" name="damage" required><br>
            Action Taken: <input type="text" name="actionTaken" required><br>
            <input type="submit" value="Submit">
        </form>

        <%
        Logger logger = Logger.getLogger("DisciplineJSP");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String studentId = request.getParameter("studentId");
            String incidentDateStr = request.getParameter("incidentDate");
            String incident = request.getParameter("incident");
            String description = request.getParameter("description");
            String damage = request.getParameter("damage");
            String actionTaken = request.getParameter("actionTaken");

            String URL = "jdbc:oracle:thin:@localhost:1521:xe";
            String USER = "SYSTEM";
            String PASSWORD = "system";

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO Discipline (StudentId, IncidentDate, Incident, Description, Damage, ActionTaken) VALUES (?, ?, ?, ?, ?, ?)")) {

                Class.forName("oracle.jdbc.driver.OracleDriver");

                java.sql.Date incidentDate = java.sql.Date.valueOf(incidentDateStr);

                stmt.setString(1, studentId);
                stmt.setDate(2, incidentDate);
                stmt.setString(3, incident);
                stmt.setString(4, description);
                stmt.setString(5, damage);
                stmt.setString(6, actionTaken);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>Record added successfully!</p>");
                } else {
                    out.println("<p class='error'>Error adding record.</p>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                logger.log(Level.SEVERE, "Database Error: " + e.getMessage(), e);
            }
        }

        String rollNumber = request.getParameter("rollNumber");
        if (rollNumber != null && !rollNumber.trim().isEmpty() && !"add".equals(action)) {
            String URL = "jdbc:oracle:thin:@localhost:1521:xe";
            String USER = "SYSTEM";
            String PASSWORD = "system";

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Discipline WHERE StudentId = ?")) {

                Class.forName("oracle.jdbc.driver.OracleDriver");

                stmt.setString(1, rollNumber);
                ResultSet rs = stmt.executeQuery();

                boolean hasResults = false;
                out.println("<table border='1' id='disciplineTable'>");
                out.println("<tr><th>Record ID</th><th>Student ID</th><th>Date</th><th>Incident</th><th>Description</th><th>Damage</th><th>Action Taken</th><th>Edit</th><th>Delete</th></tr>");

                while (rs.next()) {
                    hasResults = true;
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("RecordId") + "</td>");
                    out.println("<td>" + rs.getString("StudentId") + "</td>");
                    out.println("<td>" + rs.getDate("IncidentDate") + "</td>");
                    out.println("<td>" + rs.getString("Incident") + "</td>");
                    out.println("<td>" + rs.getString("Description") + "</td>");
                    out.println("<td>" + rs.getString("Damage") + "</td>");
                    out.println("<td>" + rs.getString("ActionTaken") + "</td>");
                    out.println("<td>");
                    out.println("<span class='icon edit-icon' onclick='editRow(this)'>✏️</span>");
                    out.println("</td>");
                    out.println("<td>");
                    out.println("<span class='icon delete-icon' onclick='deleteRow(this)'>🗑️</span>");
                    out.println("</td>");
                    out.println("</tr>");
                }
                out.println("</table>");

                if (!hasResults) {
                    out.println("<h2>No records found for Roll Number: " + rollNumber + "</h2>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                logger.log(Level.SEVERE, "Database Error: " + e.getMessage(), e);
            }
        }
        %>
    </div>
</body>
</html>
