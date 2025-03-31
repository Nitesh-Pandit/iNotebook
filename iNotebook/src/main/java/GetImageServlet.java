import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetImage")
public class GetImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noteId = Integer.parseInt(request.getParameter("id"));

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");
             PreparedStatement ps = con.prepareStatement("SELECT file_path FROM notes WHERE id = ?")) {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            ps.setInt(1, noteId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                byte[] imgData = rs.getBytes("file_path"); // Get BLOB data
                response.setContentType("image/jpeg"); // Set response type
                OutputStream out = response.getOutputStream();
                out.write(imgData);
                out.close();
            } else {
                response.getWriter().write("No image found");
            }

        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
