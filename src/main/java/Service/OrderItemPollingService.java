
package Service;

import DBcontext.Database;
import Mail.EmailService;

import javax.mail.MessagingException;
import java.sql.*;

public class OrderItemPollingService {

    public static void main(String[] args) {
        // Kiểm tra thay đổi trong bảng orderitems mỗi giây (hoặc bạn có thể điều chỉnh tần suất)
        while (true) {
            checkForChangesAndSendEmail();
            try {
                Thread.sleep(1000); // Chờ 1 giây trước khi kiểm tra lại
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public static void checkForChangesAndSendEmail() {
        // Kết nối đến cơ sở dữ liệu
        try (Connection conn = Database.getConnection()) {
            if (conn != null) {
                System.out.println("Kết nối cơ sở dữ liệu thành công!");
            } else {
                System.out.println("Kết nối cơ sở dữ liệu thất bại!");
                return;
            }
            // Kiểm tra thay đổi trong bảng orderitems (có thể dựa trên cột status hoặc timestamp)
            String query = "SELECT * FROM orderitems WHERE status = 'pending'";  // Kiểm tra trạng thái 'pending'
            System.out.println("Đang thực thi truy vấn: " + query);

            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
                if (!rs.next()) {
                    System.out.println("Không có đơn hàng có trạng thái 'pending'.");
                } else {
                    do {
                        // Lấy thông tin thay đổi
                        int orderItemId = rs.getInt("order_item_id");
                        double newPrice = rs.getDouble("price");
                        int newQuantity = rs.getInt("quantity");
                        String orderId = rs.getString("order_id");

                        // Lấy email của người sở hữu đơn hàng
                        String emailQuery = "SELECT email FROM users WHERE id IN (SELECT user_id FROM orders WHERE order_id = ?)";
                        try (PreparedStatement ps = conn.prepareStatement(emailQuery)) {
                            ps.setString(1, orderId);
                            ResultSet userResult = ps.executeQuery();
                            if (userResult.next()) {
                                String userEmail = userResult.getString("email");

                                // Gửi email thông báo thay đổi
                                // Tạo thông điệp email với thông tin chi tiết về Order Item đã thay đổi
                                String message = "Thông báo thay đổi Order Item:\n\n" +
                                        "Chào bạn,\n\n" +
                                        "Đơn hàng của bạn đã có thay đổi. Chi tiết thay đổi như sau:\n" +
                                        "--------------------------------------------\n" +
                                        "ID Order Item: " + orderItemId + "\n" +
                                        "Số lượng thay đổi: " + newQuantity + "\n" +
                                        "Giá tiền thay đổi: " + newPrice + " VNĐ\n" +
                                        "--------------------------------------------\n\n" +
                                        "Nếu bạn không phải là người thực hiện thay đổi này, vui lòng liên hệ ngay với người quản trị hệ thống.\n\n" +
                                        "Trân trọng,\n" +
                                        "Đội ngũ hỗ trợ hệ thống";

                                EmailService emailService = new EmailService();
                                try {
                                    emailService.sendEmail(userEmail, "Thông báo thay đổi Order Item", message);
                                    System.out.println("Email đã gửi thành công đến: " + userEmail);
                                } catch (MessagingException e) {
                                    e.printStackTrace();
                                    System.out.println("Gửi email thất bại đến: " + userEmail);
                                }

                            }
                        }

                        // Cập nhật lại trạng thái để tránh gửi lại thông báo nhiều lần
                        String updateQuery = "UPDATE orderitems SET status = 'processed' WHERE order_item_id = ?";
                        try (PreparedStatement ps = conn.prepareStatement(updateQuery)) {
                            ps.setInt(1, orderItemId);
                            int rowsAffected = ps.executeUpdate();
                            if (rowsAffected > 0) {
                                System.out.println("Cập nhật trạng thái thành công cho Order Item ID " + orderItemId);
                            } else {
                                System.out.println("Không có đơn hàng nào cần cập nhật trạng thái.");
                            }
                        }
                    } while (rs.next());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
