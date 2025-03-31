import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/SaveNotes")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB max file size
public class SaveNotes extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String noteTitle = request.getParameter("title");
        String noteContent = request.getParameter("content");
        Part filePart = request.getPart("file"); // Image file

        if (noteTitle == null || noteTitle.trim().isEmpty() || noteContent == null || noteContent.trim().isEmpty()) {
            out.write("Error: Title and content are required.");
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.write("Error: Session expired. Please log in again.");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
             PreparedStatement ps = con.prepareStatement("INSERT INTO notes (user_id, title, content, file_path) VALUES (?, ?, ?, ?)")) {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            ps.setInt(1, userId);
            ps.setString(2, noteTitle);
            ps.setString(3, noteContent);

            // Store image as a BLOB
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileContent = filePart.getInputStream();
                ps.setBinaryStream(4, fileContent, (int) filePart.getSize());
            } else {
                ps.setNull(4, java.sql.Types.BLOB);
            }

            int result = ps.executeUpdate();
            if (result > 0) {
                out.write("success"); // Send response back to JavaScript
            } else {
                out.write("error");
            }

        } catch (ClassNotFoundException | SQLException e) {
            out.write("Error: Database issue. " + e.getMessage());
        }
    }
}
