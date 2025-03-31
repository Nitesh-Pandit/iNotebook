import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailTest {
    public static void main(String[] args) {
        final String senderEmail = "pp5928976@gmail.com"; // Replace with your email
        final String senderPassword = "srwf jlqv viza toji"; // Replace with your app password

        String recipient = "npandit669@rku.ac.in"; // Test with your email

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
            message.setSubject("Test Email");
            message.setText("This is a test email from Java.");

            Transport.send(message);
            System.out.println("Test email sent successfully.");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
