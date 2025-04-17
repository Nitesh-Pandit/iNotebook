

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class SendNoteEmailServlet
 */
public class SendNoteEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendNoteEmailServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	        // Step 1: Read the raw JSON string from the request
	        BufferedReader reader = request.getReader();
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }
	        String rawJson = sb.toString();

	        // Step 2: Simple parsing without external libraries
	        // Example of rawJson:
	        // {"email":"example@gmail.com","note":{"title":"My Note","content":"Note content","created":"2024-04-15"}}

	        // Extract email
	        String email = extractValue(rawJson, "email");

	        // Extract note fields
	        String noteJson = extractObject(rawJson, "note");
	        String title = extractValue(noteJson, "title");
	        String content = extractValue(noteJson, "content");
	        String created = extractValue(noteJson, "created");

	        // Step 3: Send email
	        response.setContentType("application/json");
	        PrintWriter out = response.getWriter();
	        try {
	            String subject = "Shared Note: " + title;
	            String message = "Title: " + title + "\n\nContent: " + content + "\n\nCreated at: " + created;
	            EmailUtil.sendEmail(email, subject, message);  // your helper class
	            response.getWriter().write("Email sent successfully!");
	        } catch (Exception e) {
	            e.printStackTrace();
	            out.write("Failed to send email.");
	        }
	    }

	    // Helper to extract simple key-value from JSON string
	    private String extractValue(String json, String key) {
	        String pattern = "\"" + key + "\":\"";
	        int startIndex = json.indexOf(pattern);
	        if (startIndex == -1) return "";
	        startIndex += pattern.length();
	        int endIndex = json.indexOf("\"", startIndex);
	        return json.substring(startIndex, endIndex);
	    }

	    // Helper to extract inner object (e.g., "note": {...})
	    private String extractObject(String json, String key) {
	        String pattern = "\"" + key + "\":{";
	        int startIndex = json.indexOf(pattern);
	        if (startIndex == -1) return "";
	        startIndex += pattern.length() - 1;

	        int braceCount = 1;
	        int endIndex = startIndex + 1;
	        while (endIndex < json.length() && braceCount > 0) {
	            char c = json.charAt(endIndex);
	            if (c == '{') braceCount++;
	            if (c == '}') braceCount--;
	            endIndex++;
	        }
	        return json.substring(startIndex, endIndex);
	    }}
	
