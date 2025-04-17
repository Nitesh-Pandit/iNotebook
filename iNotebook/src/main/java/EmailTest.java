import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailTest {
    public static void main(String[] args) {
        final String senderEmail = "sonikumar12345abc@gmail.com"; // Replace with your Gmail
        final String senderPassword = "hdys ydee zhsa ekoe"; // Replace with your App Password
        String recipient = "pp5928976@gmail.com";  // Replace with recipient's email

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Test Email from Java");
            message.setText("Hello, this is a test email sent using Java Mail API.");

            // Send email
            Transport.send(message);
            System.out.println("✅ Email sent successfully to: " + recipient);

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Failed to send email!");
        }
    }
}



