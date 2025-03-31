import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String jdbcURL = "jdbc:mysql://localhost:3306/notebook";
            String dbUser = "root";
            String dbPassword = "";

            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Query to check user credentials
            String sql = "SELECT id, name, password FROM register_user1 WHERE email = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);
            
            ResultSet resultSet = statement.executeQuery();
            
            HttpSession session = request.getSession();
            if (resultSet.next()) {
                int userId = resultSet.getInt("id");
                String storedPassword = resultSet.getString("password");
                String userName = resultSet.getString("name");

                // Compare passwords
                if (password.equals(storedPassword)) {
                    // Store user info in session
                    session.setAttribute("message", "Successfully Logged In!");
                    session.setAttribute("alertType", "success");
                    session.setAttribute("userId", userId);
                    session.setAttribute("userName", userName);
                    session.setAttribute("userEmail", email);
                    response.sendRedirect("notesDashboard.jsp");
                } else {
                    session.setAttribute("message", "Invalid email or password!");
                    session.setAttribute("alertType", "danger");
                    response.sendRedirect("Signup.jsp");
                }
            } else {
                session.setAttribute("message", "User does not exist!");
                session.setAttribute("alertType", "danger");
                response.sendRedirect("Signup.jsp");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
