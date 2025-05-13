<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            border: none !important; /* Remove any default border */
            border-width: 0 !important; /* Ensure no border width */
            margin: 0 !important;
            padding: 0 !important;
            overflow: hidden; /* Prevent unwanted scrolling unless needed */
            outline: none !important;
            box-shadow: none !important;
            -webkit-box-shadow: none !important; /* Target Chrome */
        }
        .header {
            background-color: #ff4500; /* Orange header */
            color: white;
            text-align: center;
            padding: 20px 0;
            font-size: 18px;
            font-style:bold;
            margin-left:20px;
            margin-top:20px;
            margin-right:20px;
        }
        .logo {
            float: left;
            margin: 10px;
            width: 100px; /* Adjust as needed */
        }
        

        /* Chrome-specific fix for frame content */
        @media screen and (-webkit-min-device-pixel-ratio:0) {
            body {
                border: none !important;
                border-width: 0 !important;
                box-shadow: none !important;
                -webkit-box-shadow: none !important;
            }
        }
    </style>
</head>
<body>
    <div class="header">
    <h1>Admin Dashboard</h1>
    </div>
    <div style="padding: 20px;">
        <!-- Additional content can be added here if needed -->
    </div>
</body>
</html>