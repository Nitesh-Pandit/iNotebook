import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PermanentDeleteServlet")
public class PermanentDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String noteId = request.getParameter("noteId");

        if (noteId == null || noteId.trim().isEmpty()) {
            response.getWriter().write("status=error&message=Invalid Note ID");
            return;
        }

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");

            // Delete query to permanently remove the note
            String sql = "DELETE FROM notes WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(noteId));

            int result = ps.executeUpdate();

            if (result > 0) {
                response.getWriter().write("status=success&noteId=" + noteId);
            } else {
                response.getWriter().write("status=error&message=Unable to delete note.");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            response.getWriter().write("status=error&message=Database Error: " + e.getMessage());
        }
    }
}
