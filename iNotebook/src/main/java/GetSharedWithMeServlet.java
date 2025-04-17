import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
@WebServlet("/GetSharedWithMeServlet")
public class GetSharedWithMeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        String myEmail = (session != null) ? (String) session.getAttribute("email") : null;

        if (myEmail == null) {
            out.write("[]");  // Return an empty array if no email is found
            return;
        }

        StringBuilder json = new StringBuilder("[");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
             PreparedStatement ps = con.prepareStatement(
                     "SELECT recipient_email, note_title, shared_at FROM shared_notes WHERE recipient_email = ?")) {

            ps.setString(1, myEmail);
            ResultSet rs = ps.executeQuery();

            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }

                SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, yyyy HH:mm:ss");
                String sharedTime = dateFormat.format(rs.getTimestamp("shared_at"));

                json.append("{")
                    .append("\"email\":\"").append(rs.getString("recipient_email")).append("\",")
                    .append("\"title\":\"").append(rs.getString("note_title")).append("\",")
                    .append("\"sharedTime\":\"").append(sharedTime).append("\"")
                    .append("}");
                first = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.write("[]");  // In case of an error, return an empty array
            return;
        }

        json.append("]");

        out.print(json.toString());  // Return the JSON data
    }
}
