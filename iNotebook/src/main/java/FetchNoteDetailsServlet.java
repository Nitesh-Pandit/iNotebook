import java.io.IOException;
import java.sql.*;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FetchNoteDetailsServlet")
public class FetchNoteDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String noteId = request.getParameter("noteId");
        if (noteId == null || noteId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Note ID is missing\"}");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/notebook";
        String user = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(url, user, password)) {
                String sql = "SELECT title, content, created_at, file_path FROM notes WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, Integer.parseInt(noteId));

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            String title = escapeJson(rs.getString("title"));
                            String content = escapeJson(rs.getString("content"));
                            String createdAt = escapeJson(rs.getTimestamp("created_at").toString());

                            // ✅ Convert image BLOB to Base64
                            String base64Image = "";
                            Blob imageBlob = rs.getBlob("file_path");
                            if (imageBlob != null) {
                                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                                base64Image = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
                            }

                            // ✅ Debugging
                            System.out.println("✅ Base64 Image Length: " + base64Image.length());

                            String jsonResponse = String.format(
                                "{ \"title\": \"%s\", \"content\": \"%s\", \"created_at\": \"%s\", \"image\": \"%s\" }",
                                title, content, createdAt, base64Image
                            );

                            response.getWriter().write(jsonResponse);
                        } else {
                            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                            response.getWriter().write("{\"error\": \"Note not found\"}");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t").replace("\\", "\\\\");
    }
}
