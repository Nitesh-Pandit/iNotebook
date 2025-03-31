import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetNoteContent")
public class GetNoteContent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8"); // Ensure correct encoding
        PrintWriter out = response.getWriter();

        String noteId = request.getParameter("noteId");

        // Check if noteId is provided
        if (noteId == null || noteId.isEmpty()) {
            out.write("{\"error\": \"Invalid note ID.\"}");
            return;
        }

        try {
            // Connect to database
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT title, content, created_at FROM notes WHERE id = ?");
            ps.setInt(1, Integer.parseInt(noteId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String title = rs.getString("title").replace("\"", "'");
                String content = rs.getString("content").replace("\"", "'");
                String createdAt = rs.getString("created_at");

                // JSON response
                String jsonResponse = String.format(
                    "{\"title\": \"%s\", \"content\": \"%s\", \"created_at\": \"%s\"}",
                    title, content, createdAt
                );

                out.write(jsonResponse);
            } else {
                out.write("{\"error\": \"Note not found.\"}");
            }
        } catch (Exception e) {
            out.write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        }
    }
}
