<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page
import="java.sql.*, javax.servlet.*,javax.servlet.http.*, java.util.*"%>
<%@ page import="com.yourpackages.DbUtil"%>

<!DOCTYPE html>
<html>
<head>
    <title>Navigation</title>
    <style>
        .x {
            height: 100px;
            width: 80px;
        }

        .y {
            padding-left: 100px;
            padding-top: 0px;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #2c3e50; /* Dark blue background for the sidebar */
            color: white;
            height: 100vh;
            overflow-y: auto; /* Allow vertical scrolling if content overflows */
            /* Target Chrome */
        }

        .sidebar {
            width: 250px;
            display: flex;
            flex-direction: column;
            height: 100%;
            border: none !important; /* Ensure no border on the sidebar */
            box-shadow: none !important;
            -webkit-box-shadow: none !important; /* Target Chrome */
        }

        .sidebar img {
            margin: 0 auto;
            display: block;
        }

        .sidebar h1 {
            text-align: center;
            margin: 0;
            padding: 0.5rem 0;
        }

        .sidebar h2 {
            text-align: center;
            padding: 1rem;
            border-bottom: 1px solid #34495e;
            margin: 0;
        }

        .sidebar a {
            padding: 1rem;
            color: white;
            text-decoration: none;
            display: block;
            border-bottom: 1px solid #34495e;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e; /* Slightly lighter blue on hover */
        }

        /* Chrome-specific fix for frame content */
        @media screen and (-webkit-min-device-pixel-ratio:0) {
            body, .sidebar {
                border: none !important;
                border-width: 0 !important;
                box-shadow: none !important;
                -webkit-box-shadow: none !important;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <img class="x" src="<%=request.getAttribute("imagePath") != null ? request.getAttribute("imagePath") : "../images/VVIT_Logo.png"%>" alt="VVIT Logo">
        <h1 class="y">VVIT</h1>
        <h2>Admin Dashboard</h2>
        <a href="home.jsp" target="rightFrame">Home</a>
        <a href="updateProfile.jsp" target="rightFrame">Update Profile</a>
        <a href="attendance.jsp" target="rightFrame">Attendance</a>
        <a href="discipline.jsp" target="rightFrame">Discipline</a>
        <a href="familyDetails.jsp" target="rightFrame">Family Details</a>
        <a href="grades.jsp" target="rightFrame">Grades</a>
        <a href="logout.jsp" target="rightFrame">Logout</a>
    </div>
</body>
</html>