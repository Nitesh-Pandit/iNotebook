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
import jakarta.servlet.http.HttpSession;

@WebServlet("/MoveToTrashServlet")
public class MoveToTrashServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String noteIdParam = request.getParameter("noteId");
        		
        if (noteIdParam == null || noteIdParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error: Invalid Note ID");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            int noteId = Integer.parseInt(noteIdParam);

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");

            // SQL query to update the note status (soft delete) only if the note belongs to the logged-in user
            String sql = "UPDATE notes SET is_deleted = 1 WHERE id = ? AND user_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, noteId);
            ps.setInt(2, userId);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("notesDashboard.jsp?msg=Note moved to trash");
            } else {
                response.sendRedirect("notesDashboard.jsp?error=Failed to move note or unauthorized access");
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error: Invalid Note ID format");
        } catch (ClassNotFoundException | SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}