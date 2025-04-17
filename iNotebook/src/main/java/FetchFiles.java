import java.io.IOException;
import java.sql.*;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FetchFiles")
public class FetchFiles extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String url = "jdbc:mysql://localhost:3306/notebook";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            String sql = "SELECT id, file_path FROM notes WHERE file_path IS NOT NULL";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            StringBuilder json = new StringBuilder("[");
            boolean first = true;

            while (rs.next()) {
                if (!first) json.append(",");

                Blob fileBlob = rs.getBlob("file_path");
                String base64File = "";
                if (fileBlob != null) {
                    byte[] fileBytes = fileBlob.getBytes(1, (int) fileBlob.length());
                    base64File = Base64.getEncoder().encodeToString(fileBytes);
                }

                json.append("{\"id\":").append(rs.getInt("id"))
                    .append(",\"file_path\":\"").append(base64File).append("\"}");

                first = false;
            }
            json.append("]");

            response.getWriter().write(json.toString());

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("[]"); // Return empty JSON array if an error occurs
        }
    }
}
