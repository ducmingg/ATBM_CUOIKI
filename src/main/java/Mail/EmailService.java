package Mail;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private final String SMTP_HOST = "smtp.gmail.com";
    private final String SMTP_PORT = "587";
    private final String SMTP_USER = "khoangoquan@gmail.com";  // Thay đổi
    private final String SMTP_PASSWORD = "mzrs xvca qstr zegw";  // Thay đổi (Sử dụng App Password nếu bật 2FA)

    // Thiết lập cấu hình gửi email
    private Properties getMailProperties() {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        return properties;
    }

    // Gửi email
    public void sendEmail(String toEmail, String subject, String messageBody) throws MessagingException {
        // Cấu hình mail
        Properties properties = getMailProperties();
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASSWORD);
            }
        });

        // Tạo message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SMTP_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setText(messageBody);

        // Gửi email
        Transport.send(message);
    }
}
