package Mail;

import javax.mail.MessagingException;

public class OrderItemNotification {
    public void notifyOrderItemChange(String recipientEmail, int orderItemId, double newPrice, int newQuantity) {
        // Tạo nội dung email
        String subject = "Thông báo thay đổi thông tin sản phẩm";
        String messageBody = "Thông tin sản phẩm đã thay đổi:\n\n" +
                "Mã sản phẩm: " + orderItemId + "\n" +
                "Giá mới: " + newPrice + " VND\n" +
                "Số lượng mới: " + newQuantity + "\n\n" +
                "Vui lòng kiểm tra lại thông tin và xác nhận.";

        // Gửi email thông báo
        EmailService emailService = new EmailService();
        try {
            emailService.sendEmail(recipientEmail, subject, messageBody);
        } catch (MessagingException e) {
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
        }
    }
}
