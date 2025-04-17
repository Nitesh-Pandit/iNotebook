import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteTaskServlet")
public class DeleteTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String taskId = request.getParameter("id");

        if (taskId == null || taskId.trim().isEmpty()) {
            response.getWriter().write("Error: Task ID is missing.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM tasks WHERE id = ?")) {

                stmt.setInt(1, Integer.parseInt(taskId));
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("FetchUsersServlet");
                } else {
                    response.getWriter().write("Error: Task not found.");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
