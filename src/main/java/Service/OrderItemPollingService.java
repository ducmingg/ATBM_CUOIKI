package Service;

import DBcontext.Database;
import Mail.EmailService;

import javax.mail.MessagingException;
import java.sql.*;

public class OrderItemPollingService {
    public static void main(String[] args) {
        // Giám sát sự thay đổi trong cơ sở dữ liệu (polling)
        while (true) {
            checkForChangesAndSendEmail();
            try {
                Thread.sleep(60000); // Kiểm tra mỗi phút
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public static void checkForChangesAndSendEmail() {
        try (Connection conn = Database.getConnection()) {
            // Truy vấn bảng orderitems để kiểm tra sự thay đổi
            String query = "SELECT * FROM orderitems WHERE status = 'changed'"; // Giả sử có cột status để đánh dấu sự thay đổi
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
                while (rs.next()) {
                    // Lấy thông tin cần thiết từ orderitems
                    int orderItemId = rs.getInt("order_item_id");
                    String orderId = rs.getString("order_id"); // Order ID từ bảng orderitems
                    double oldPrice = rs.getDouble("price");
                    int oldQuantity = rs.getInt("quantity");

                    // Lấy email của người sở hữu đơn hàng từ bảng orders và users
                    String emailQuery = "SELECT u.email FROM users u " +
                            "JOIN orders o ON u.id = o.user_id " +
                            "WHERE o.order_id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(emailQuery)) {
                        ps.setString(1, orderId);
                        try (ResultSet emailRs = ps.executeQuery()) {
                            if (emailRs.next()) {
                                String email = emailRs.getString("email");

                                // Lấy thông tin mới từ bảng orderitems (giả sử có sự thay đổi)
                                double newPrice = rs.getDouble("new_price");
                                int newQuantity = rs.getInt("new_quantity");

                                // Gửi email thông báo sự thay đổi
                                String message = "Order Item đã thay đổi:\n" +
                                        "Order ID: " + orderId + "\n" +
                                        "Order Item ID: " + orderItemId + "\n" +
                                        "Số lượng cũ: " + oldQuantity + "\n" +
                                        "Số lượng mới: " + newQuantity + "\n" +
                                        "Giá cũ: " + oldPrice + "\n" +
                                        "Giá mới: " + newPrice;

                                EmailService emailService = new EmailService();
                                emailService.sendEmail(email, "Thông báo thay đổi Order Item", message);

                                // Cập nhật trạng thái là đã xử lý (tùy chọn)
                                String updateQuery = "UPDATE orderitems SET status = 'processed' WHERE order_item_id = ?";
                                try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                                    updatePs.setInt(1, orderItemId);
                                    updatePs.executeUpdate();
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException | MessagingException e) {
            e.printStackTrace();
        }
    }
}
