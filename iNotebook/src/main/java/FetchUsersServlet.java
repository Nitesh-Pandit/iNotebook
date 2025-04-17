import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/FetchUsersServlet")
public class FetchUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> users = new ArrayList<>();
        List<Map<String, String>> tasks = new ArrayList<>();
        List<Map<String, String>> notes = new ArrayList<>();
        List<Map<String, String>> notebooks = new ArrayList<>();

        Connection conn = null;

        try {
            // Load driver and connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");

            // Fetch users
            try (PreparedStatement userStmt = conn.prepareStatement("SELECT name, email FROM register_user1");
                 ResultSet userRs = userStmt.executeQuery()) {
                while (userRs.next()) {
                    Map<String, String> user = new HashMap<>();
                    user.put("name", userRs.getString("name"));
                    user.put("email", userRs.getString("email"));
                    users.add(user);
                }
            }

            // Fetch tasks
            try (PreparedStatement taskStmt = conn.prepareStatement("SELECT id, task_name, created_at, due_date FROM tasks");
                 ResultSet taskRs = taskStmt.executeQuery()) {
                while (taskRs.next()) {
                    Map<String, String> task = new HashMap<>();
                    task.put("id", taskRs.getString("id"));
                    task.put("task_name", taskRs.getString("task_name"));
                    task.put("created_at", taskRs.getString("created_at"));
                    task.put("due_date", taskRs.getString("due_date"));
                    tasks.add(task);
                }
            }

            // Fetch notes
            try (PreparedStatement noteStmt = conn.prepareStatement("SELECT id, title, content, created_at, file_path FROM notes");

                 ResultSet noteRs = noteStmt.executeQuery()) {
                while (noteRs.next()) {
                    Map<String, String> note = new HashMap<>();
                    note.put("id", noteRs.getString("id"));
                    note.put("title", noteRs.getString("title"));
                    note.put("content", noteRs.getString("content"));
                    note.put("created_at", noteRs.getString("created_at"));
                    note.put("file_path", noteRs.getString("file_path"));
                    notes.add(note);
                }
            }

            // ✅ Fetch notebooks
            try (PreparedStatement notebookStmt = conn.prepareStatement("SELECT id, name, created_at FROM notebooks");
                 ResultSet notebookRs = notebookStmt.executeQuery()) {
                while (notebookRs.next()) {
                    Map<String, String> notebook = new HashMap<>();
                    notebook.put("name", notebookRs.getString("name"));
                    notebook.put("id", notebookRs.getString("id"));  // Add this line
                    notebook.put("created_at", notebookRs.getString("created_at"));
                    notebooks.add(notebook);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        // Set attributes for JSP
        request.setAttribute("users", users);
        request.setAttribute("tasks", tasks);
        request.setAttribute("notes", notes);
        request.setAttribute("notebooks", notebooks); // ✅ Added notebook data

        // Forward to JSP
        request.getRequestDispatcher("AdminPannel.jsp").forward(request, response);
    }
}
