import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");

        try {
        	// Load the Oracle JDBC driver (optional in modern JDBC, but good practice)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// Establish database connection
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "system");
            
            String sql = "INSERT INTO users (fname, lname, username, email, phone, gender, password) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, username);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, gender);
            ps.setString(7, password); // In production, hash this password
            
            int rows = ps.executeUpdate();
            
            JSONObject json = new JSONObject();
            json.put("success", rows > 0);
            
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}