import java.io.IOException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/GenerateOtpServlet")
public class GenerateOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String phone = request.getParameter("phone");
            System.out.println("Phone received: " + phone); // Debug log
            
            Random rand = new Random();
            String otp = String.format("%06d", rand.nextInt(1000000));
            System.out.println("Generated OTP: " + otp); // Debug log
            
            JSONObject json = new JSONObject();
            json.put("otp", otp);
            
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "OTP generation failed");
        }
    }
}