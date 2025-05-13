package com.yourpackages;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/AdminCredentials")
public class AdminCredentials extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String pass = request.getParameter("passw");

        if (name != null && !name.trim().isEmpty() && pass != null && !pass.trim().isEmpty()) {
            try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "system");
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM AdminCredentials WHERE admin_name = ? AND admin_pass = ?")) {
                stmt.setString(1, name);
                stmt.setString(2, pass);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Successful login - redirect to index.jsp
                        response.sendRedirect("index.jsp");
                    } else {
                        // Invalid credentials - set error message and forward back to login page
                        request.setAttribute("errorMessage", "Invalid username or password!");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("AdminLogin1.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("AdminLogin1.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            // Empty fields - set error message and forward back to login page
            request.setAttribute("errorMessage", "Username and password cannot be empty!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminLogin1.jsp");
            dispatcher.forward(request, response);
        }
    }
}