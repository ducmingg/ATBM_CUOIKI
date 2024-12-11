package Mail;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailService {

    // Gửi email thông báo
    public void sendEmail(String recipientEmail, String subject, String messageBody) throws MessagingException {
        // Cấu hình SMTP
        String senderEmail = MailConfig.APP_EMAIL;
        String senderPassword = MailConfig.APP_PASSWORD;
        String host = MailConfig.HOST_NAME;

        // Cấu hình các thuộc tính cho phiên làm việc gửi email
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", String.valueOf(MailConfig.TSL_PORT)); // Chọn cổng TLS (587)
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true"); // Sử dụng TLS

        // Tạo một session mới và xác thực tài khoản gửi email
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Tạo đối tượng Message với thông tin người nhận và chủ đề
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject); // Chủ đề email

            // Nội dung email
            message.setText(messageBody); // Nội dung email

            // Gửi email
            Transport.send(message);
            System.out.println("Email đã được gửi thành công!");

        } catch (MessagingException e) {
            e.printStackTrace(); // In ra lỗi nếu có vấn đề trong quá trình gửi email
            throw new MessagingException("Không thể gửi email. Vui lòng thử lại sau.");
        }
    }
}
