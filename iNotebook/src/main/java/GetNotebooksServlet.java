//package com.notebook;

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

@WebServlet("/GetNotebooksServlet")
public class GetNotebooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html"); // Returning HTML response
        PrintWriter out = response.getWriter();

        // Validate session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.write("SessionExpired");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try {
            // Database connection (Update credentials accordingly)
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "");

            // Get notebooks for the logged-in user
            String query = "SELECT id, name FROM notebooks WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            // Build HTML list items
            StringBuilder notebooksHtml = new StringBuilder();
            while (rs.next()) {
                int notebookId = rs.getInt("id");
                String notebookName = rs.getString("name");
                notebooksHtml.append("<li data-id='").append(notebookId).append("' style='cursor:pointer; padding:5px 10px; border-bottom:1px solid #ccc;'>")
                             .append("<i class='fas fa-book'></i> ")
                             .append(notebookName)
                             .append("</li>");
            }

            ps.close();
            con.close();

            out.write(notebooksHtml.toString()); // Send response to frontend

        } catch (Exception e) {
            e.printStackTrace();
            out.write("Error"); // Handle errors
        }
    }
}
