import java.io.*;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
@WebServlet("/ShareNoteServlet")
public class ShareNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String recipientEmail = request.getParameter("recipient_email");

        HttpSession session = request.getSession(false);
        Integer senderId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (senderId == null || recipientEmail == null) {
            response.getWriter().write("error: missing data");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
            String sql = "INSERT INTO shared_notes (sender_id, recipient_email) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, senderId); // senderId is the logged-in user
            ps.setString(2, recipientEmail); // recipient email

            int result = ps.executeUpdate();
            if (result > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error: insert failed");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error: " + e.getMessage());
        }
    }
}
