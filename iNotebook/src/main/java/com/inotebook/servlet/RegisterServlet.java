package com.inotebook.servlet;


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



/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        
	        String name = request.getParameter("first_name");
	        String lastname = request.getParameter("last_name");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        try {
	            // Database connection
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            String jdbcURL = "jdbc:mysql://localhost:3306/notebook";
	            String dbUser = "root";
	            String dbPassword = "";

	            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

	            // Insert query
	            String sql = "INSERT INTO register_user1 (name, lastname, email, password) VALUES (?, ?, ?, ?)";
	            PreparedStatement statement = conn.prepareStatement(sql);
	            statement.setString(1, name);
	            statement.setString(2, lastname);
	            statement.setString(3, email);
	            statement.setString(4, password);

	            int rowsInserted = statement.executeUpdate();
	            HttpSession session = request.getSession();

	            if (rowsInserted > 0) {
	                session.setAttribute("message", "Registration successful Now You can Login!");
	                session.setAttribute("alertType", "success"); // Bootstrap alert type
	            } else {
	                session.setAttribute("message", "Registration failed. Please try again.");
	                session.setAttribute("alertType", "danger");
	            }

	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	            HttpSession session = request.getSession();
	            session.setAttribute("message", "Error: " + e.getMessage());
	            session.setAttribute("alertType", "danger");
	        }

	        response.sendRedirect("Signup.jsp"); // Redirect to Signup page
	    }

}
