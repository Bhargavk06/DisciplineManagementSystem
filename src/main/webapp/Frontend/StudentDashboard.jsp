<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*, java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Management</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background-color: #f4f4f4;
}

header {
	background-color: #007BFF;
	color: white;
	padding: 10px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

header .logo {
	font-size: 20px;
	font-weight: bold;
}

header .menu {
	display: flex;
	gap: 15px;
}

header .menu a {
	color: white;
	text-decoration: none;
}

header .back-arrow {
	font-size: 24px;
	cursor: pointer;
	margin-right: 20px;
}

main {
	padding: 20px;
	text-align: center;
}

.icon-container {
	display: flex;
	justify-content: center;
	gap: 50px;
	margin-top: 50px;
}

.icon {
	display: flex;
	flex-direction: column;
	align-items: center;
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.icon button {
	background: none;
	border: none;
	cursor: pointer;
}

.icon button img {
	width: 80px;
	height: 80px;
	margin-bottom: 10px;
}

.icon span {
	font-size: 16px;
	font-weight: bold;
}

.search-bar {
	margin-top: 20px;
	text-align: center;
}

.search-bar input {
	width: 50%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.search-bar button {
	padding: 10px 15px;
	font-size: 16px;
	color: white;
	background-color: #007BFF;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.search-bar button:hover {
	background-color: #0056b3;
}

.results {
	margin-top: 20px;
	padding: 15px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	font-size: 18px;
}

.results.not-found {
	color: red;
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
</style>
</head>
<body>
	<header>
		<div class="back-arrow" onclick="window.location.reload()">←</div>
		<div class="logo">EduSys</div>
		<div class="menu">
			<a href="#">Home</a> <a href="#">Support</a> <a href="#">Logout</a>
		</div>
	</header>
	<main>
		<h1>Student Management</h1>
		
		<div class="search-bar">
			<form method="post">
				<input type="text" placeholder="Search..." name="RollNumber">
				<button type="submit">Search</button>
			</form>
		</div>
		
			<%
			String rollNumberFromLogin = (String) session.getAttribute("rollNumber");
			String rollNumberFromSearch = request.getParameter("RollNumber");
			if (rollNumberFromSearch != null && !rollNumberFromSearch.trim().isEmpty()) {
				if (rollNumberFromLogin != null && rollNumberFromLogin.equals(rollNumberFromSearch)) {
					String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Change this URL based on your database configuration
					String USER = "SYSTEM"; // Database username
					String PASSWORD = "system"; // Database password\
					Connection conn = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;
					int emptyFlag = 1;

					try {
				// Load the Oracle JDBC driver (optional for newer versions)
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(URL, USER, PASSWORD);
				String sql = "select * from Discipline where StudentId=?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, rollNumberFromSearch);
				rs = stmt.executeQuery();

				out.println("<table border=1px>");
				out.println("<tr>");
				out.println("<th>Student ID</th>");
				out.println("<th>Date</th>");
				out.println("<th>Incident</th>");
				out.println("<th>Description</th>");
				out.println("<th>Damage</th>");
				out.println("<th>Action Taken</th>");
				out.println("<th>Edit</th>");
				out.println("</tr>");

				while (rs.next()) {
					emptyFlag = 0;
					String StudentId = rs.getString("StudentId");
					String IncidentDate = rs.getString("IncidentDate");
					String Incident = rs.getString("Incident");
					String Description = rs.getString("Description");
					String Damage = rs.getString("Damage");
					String ActionTaken = rs.getString("ActionTaken");

					out.println("<tr>");
					out.println("<td>" + StudentId + "</td>");
					out.println("<td>" + IncidentDate + "</td>");
					out.println("<td>" + Incident + "</td>");
					out.println("<td>" + Description + "</td>");
					out.println("<td>" + Damage + "</td>");
					out.println("<td>" + ActionTaken + "</td>");

					out.println("</tr>");

				}
				out.println("</table>");

				if (emptyFlag == 1) {
			%>
			<br>
			<br>
			<h2>No records found with the roll number <%=rollNumberFromSearch%></h2>	
			<%
				}

					}
				catch (Exception e) {
						e.printStackTrace();
					} 
				finally {
						if (rs != null)
							rs.close();
						if (stmt != null)
							stmt.close();
						if (conn != null)
							conn.close();
					}
				}
				else{
					%>
					<h2> Invalid</h2>
					<% 
				}
			}
			
				%>
	</main>
</body>
</html>