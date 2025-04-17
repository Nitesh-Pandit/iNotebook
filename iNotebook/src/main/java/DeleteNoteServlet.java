import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteNoteServlet")
public class DeleteNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String noteId = request.getParameter("id");

        if (noteId == null || noteId.trim().isEmpty()) {
            response.getWriter().write("Error: Note ID is missing.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM notes WHERE id = ?")) {

                stmt.setInt(1, Integer.parseInt(noteId));
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("FetchUsersServlet"); // Reload admin panel
                } else {
                    response.getWriter().write("Error: Note not found.");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
