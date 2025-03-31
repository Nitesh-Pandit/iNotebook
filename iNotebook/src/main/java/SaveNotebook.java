import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SaveNotebook")
public class SaveNotebook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        // ✅ Get notebook name from request
        String notebookName = request.getParameter("notebookName");
        if (notebookName == null || notebookName.trim().isEmpty()) {
            out.write("Error: Notebook name is required");
            return;
        }

        // ✅ Sanitize input (only letters, numbers, and spaces)
        notebookName = notebookName.replaceAll("[^a-zA-Z0-9 ]", "");

        // ✅ Get user ID from session
        HttpSession session = request.getSession(false); // Prevent creating a new session
        if (session == null || session.getAttribute("userId") == null) {
            out.write("Error: Session expired. Please log in again.");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // ✅ Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");

            // ✅ Check if notebook already exists for the user
            String checkQuery = "SELECT COUNT(*) FROM notebooks WHERE user_id = ? AND name = ?";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setInt(1, userId);
            checkPs.setString(2, notebookName);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                out.write("Error: Notebook already exists.");
                return;
            }
            checkPs.close();
            rs.close();

            // ✅ Insert new notebook
            String query = "INSERT INTO notebooks (user_id, name) VALUES (?, ?)";
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, notebookName);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.write("Success");
            } else {
                out.write("Error: Could not save notebook");
            }

        } catch (ClassNotFoundException e) {
            out.write("Error: JDBC Driver not found");
        } catch (SQLException e) {
            out.write("Error: Database issue. " + e.getMessage());
        } finally {
            // ✅ Ensure resources are closed
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
