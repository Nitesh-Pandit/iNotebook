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
import jakarta.servlet.http.HttpSession;

@WebServlet("/FetchNotes")
public class FetchNotes extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.write("{\"error\": \"Session expired. Please log in again.\"}");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        StringBuilder jsonOutput = new StringBuilder();
        jsonOutput.append("[");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
             PreparedStatement ps = con.prepareStatement("SELECT id, title FROM notes WHERE user_id = ?")) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    jsonOutput.append(",");
                }
                jsonOutput.append("{\"id\":").append(rs.getInt("id"))
                .append(", \"title\":\"").append(rs.getString("title").replace("\"", "'"))
 // Escape quotes
                          .append("\"}");
                first = false;
            }
            jsonOutput.append("]");

            out.write(jsonOutput.toString());
        } catch (Exception e) {
            out.write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        }
    }
}
