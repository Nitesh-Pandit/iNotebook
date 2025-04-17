//package your.package.name; // Update your package if needed

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
@WebServlet("/GetTasksServlet")
public class GetTasksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/notebook", "root", "");

            // ✅ Only fetch task_name
            String query = "SELECT task_name FROM tasks";
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    jsonBuilder.append(",");
                }

                String taskName = rs.getString("task_name");

                jsonBuilder.append("{");
                jsonBuilder.append("\"task_name\":\"").append(taskName.replace("\"", "\\\"")).append("\"");
                jsonBuilder.append("}");

                first = false;
            }

            rs.close();
            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        jsonBuilder.append("]");
        out.print(jsonBuilder.toString());
        out.flush();
    }
}
