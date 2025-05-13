import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

class Jdbc1{
    public static void main(String[] args) {
        // Step 1: Registering the driver or loading the driver class
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");  // Load Oracle JDBC Driver
            System.out.println("Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.out.println( e);
            return;  // Exit if driver not found
        }

        // Step 2: Establishing a connection with the database
        try (Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "system")) {

            if (con != null) {
                System.out.println("Connection established successfully.");
            }

            // Step 3: Statement object creation (to execute SQL queries)
            try (Statement stmt = con.createStatement()) {
                // Step 4: Query processing - creating a table
                String query = "CREATE TABLE student(s_firstname VARCHAR2(20), s_lastname VARCHAR2(20), s_username VARCHAR2(20), s_email VARCHAR2(30), s_phno VARCHAR2(10), s_gender VARCHAR2(7), s_password VARCHAR2(20))";
                stmt.executeUpdate(query);
                System.out.println("Table 'student' created successfully.");
            } catch (SQLException e) {
                System.out.println("Error executing query: " + e.getMessage());
            }

        } catch (SQLException e) {
            System.out.println("Error connecting to the database: " + e.getMessage());
        }
    }
}
