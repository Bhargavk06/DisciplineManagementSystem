<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<frameset cols="20%,80%">
    <!-- Left Frame: Navigation Menu (200 pixels wide) -->
    <frame src="navigation.jsp" name="leftFrame" noresize="noresize"/>
    
    <!-- Right Frame: Content Area (remaining width) -->
    <frame src="adminDashboard.jsp" name="rightFrame" />
    
    <noframes>
        <body>Your browser does not support frames.</body>
    </noframes>
</frameset>
</html>