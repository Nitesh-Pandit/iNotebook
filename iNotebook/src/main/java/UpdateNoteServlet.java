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

@WebServlet("/UpdateNoteServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB max file size
public class UpdateNoteServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        
        System.out.println("🔹 UpdateNoteServlet received a request!"); // Debugging log

        // ✅ 1. Retrieve request parameters
        String noteIdStr = request.getParameter("noteId");
        String noteTitle = request.getParameter("title");
        String noteContent = request.getParameter("content");
        Part filePart = request.getPart("file"); // Optional file upload

        System.out.println("📌 Received Note ID: " + noteIdStr);
        System.out.println("📌 Received Title: " + noteTitle);
        System.out.println("📌 Received Content: " + noteContent);

        // ✅ 2. Validate request data
        if (noteIdStr == null || noteIdStr.trim().isEmpty() || 
            noteTitle == null || noteTitle.trim().isEmpty() || 
            noteContent == null || noteContent.trim().isEmpty()) {
            System.out.println("❌ Error: Missing required parameters.");
            out.write("Error: Note ID, Title, and Content are required.");
            return;
        }

        int noteId;
        try {
            noteId = Integer.parseInt(noteIdStr);
        } catch (NumberFormatException e) {
            System.out.println("❌ Error: Invalid Note ID format.");
            out.write("Error: Invalid Note ID.");
            return;
        }

        // ✅ 3. Validate user session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("❌ Error: User session expired.");
            out.write("Error: Session expired. Please log in again.");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        System.out.println("✅ User ID from session: " + userId);

        // ✅ 4. Database connection setup
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "")) {

                // ✅ 5. Prepare SQL query (with or without file)
                String sql;
                PreparedStatement ps;

                if (filePart != null && filePart.getSize() > 0) {
                    sql = "UPDATE notes SET title = ?, content = ?, file_path = ? WHERE id = ? AND user_id = ?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, noteTitle);
                    ps.setString(2, noteContent);
                    InputStream fileContent = filePart.getInputStream();
                    ps.setBinaryStream(3, fileContent, (int) filePart.getSize());
                    ps.setInt(4, noteId);
                    ps.setInt(5, userId);
                } else {
                    sql = "UPDATE notes SET title = ?, content = ? WHERE id = ? AND user_id = ?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, noteTitle);
                    ps.setString(2, noteContent);
                    ps.setInt(3, noteId);
                    ps.setInt(4, userId);
                }

                // ✅ 6. Execute update query
                int result = ps.executeUpdate();
                if (result > 0) {
                    System.out.println("✅ Note updated successfully in DB!");
                    out.write("success");
                } else {
                    System.out.println("❌ Error: Note update failed.");
                    out.write("error");
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Error: MySQL Driver not found.");
            out.write("Error: MySQL Driver not found.");
        } catch (SQLException e) {
            System.out.println("❌ Error: Database issue - " + e.getMessage());
            out.write("Error: Database issue. " + e.getMessage());
        }
    }
}
