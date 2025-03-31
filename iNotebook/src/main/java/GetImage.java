import java.io.IOException;
import java.io.OutputStream;
import java.sql.Blob;
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
public class GetImage extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noteId = Integer.parseInt(request.getParameter("id"));
        String url = "jdbc:mysql://localhost:3306/notebook";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            String sql = "SELECT file_path FROM notes WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, noteId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("file_path");
                byte[] imageBytes = blob.getBytes(1, (int) blob.length());

                // Set the correct content type dynamically
                response.setContentType("image/jpeg"); // Change to image/png if needed
                response.setContentLength(imageBytes.length);
                
                OutputStream out = response.getOutputStream();
                out.write(imageBytes);
                out.flush();
                out.close();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404 if no image found
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
