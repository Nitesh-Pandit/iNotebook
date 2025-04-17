import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteNotebookServlet")
public class DeleteNotebookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String notebookId = request.getParameter("id");

        if (notebookId == null || notebookId.trim().isEmpty()) {
            response.getWriter().write("Error: Notebook ID is missing.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM notebooks WHERE id = ?")) {

                stmt.setInt(1, Integer.parseInt(notebookId));
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("FetchUsersServlet"); // Reload admin panel
                } else {
                    response.getWriter().write("Error: Notebook not found.");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
