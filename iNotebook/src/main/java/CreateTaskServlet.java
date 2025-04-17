import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/CreateTaskServlet")
@MultipartConfig
public class CreateTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String taskName = request.getParameter("task_name");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("due_date");

        
        // Get the logged-in user's ID from session
        HttpSession session = request.getSession(false);
        int userId = (session != null) ? (Integer) session.getAttribute("userId") : 0;

        // Return an error if user is not logged in
        if (userId == 0) {
            response.setContentType("text/plain");
            response.getWriter().write("Error: User not logged in.");
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/notebook";
        String dbUser = "root";
        String dbPassword = "";

        // Insert task into database
        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "INSERT INTO tasks (user_id, task_name, description, due_date) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, userId); // Store the logged-in user's ID
            statement.setString(2, taskName);
            statement.setString(3, description);
            statement.setString(4, dueDate);

            int rowsInserted = statement.executeUpdate();

            // Send response message
            response.setContentType("text/plain");
            if (rowsInserted > 0) {
                response.getWriter().write("Task added successfully!");
            } else {
                response.getWriter().write("Error: Task creation failed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
