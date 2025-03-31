import java.io.*;
import java.sql.*;
import java.util.Base64;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ShareNoteServlet")
public class ShareNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String noteId = request.getParameter("noteId");

        if (email == null || email.trim().isEmpty() || noteId == null || noteId.trim().isEmpty()) {
            response.getWriter().write("status=error&message=Invalid input data");
            return;
        }

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notebook", "root", "")) {

                // Fetch note details including the image
                String sql = "SELECT title, content, file_path FROM notes WHERE id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(noteId));
                    try (ResultSet rs = ps.executeQuery()) {

                        if (rs.next()) {
                            String title = rs.getString("title");
                            String content = rs.getString("content");

                            // Convert image BLOB to Base64
                            String base64Image = "";
                            Blob imageBlob = rs.getBlob("file_path");
                            if (imageBlob != null) {
                                try (InputStream inputStream = imageBlob.getBinaryStream()) {
                                    byte[] imageBytes = inputStream.readAllBytes();
                                    base64Image = Base64.getEncoder().encodeToString(imageBytes);
                                }
                            }

                            // Send email
                            if (sendEmail(email, title, content, base64Image)) {
                                response.getWriter().write("status=success");
                            } else {
                                response.getWriter().write("status=error&message=Failed to send email");
                            }
                        } else {
                            response.getWriter().write("status=error&message=Note not found");
                        }
                    }
                }
            }
        } catch (Exception e) {
            response.getWriter().write("status=error&message=Database Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private boolean sendEmail(String recipient, String noteTitle, String noteContent, String base64Image) {
        final String senderEmail = System.getenv("EMAIL_USER");  // Fetch email from environment variable
        final String senderPassword = System.getenv("EMAIL_PASS"); // Fetch password from environment variable

        if (senderEmail == null || senderPassword == null) {
            System.err.println("Error: Email credentials not set!");
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Shared Note: " + noteTitle);

            // Construct email content with image
            StringBuilder emailContent = new StringBuilder();
            emailContent.append("<h3>").append(noteTitle).append("</h3>");
            if (!base64Image.isEmpty()) {
                emailContent.append("<img src='data:image/png;base64,").append(base64Image)
                        .append("' style='width: 300px; display: block; margin: 10px 0;' />");
            }
            emailContent.append("<p>").append(noteContent).append("</p>");

            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(emailContent.toString(), "text/html");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);

            message.setContent(multipart);
            Transport.send(message);
            System.out.println("Email sent successfully to: " + recipient);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
