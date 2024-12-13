package Service;

import Controller.User;
import DBcontext.Database;
import Entity.OrderItemChangeCount;
import Entity.OrderItemLog;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static Mail.MailConfig.SMTP_HOST;
import static Mail.MailConfig.SMTP_PORT;

public class OrderItemLogService {


    public List<OrderItemLog> getChangedLogsInLast24Hours() {
        List<OrderItemLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM orderitem_logs WHERE change_time > NOW() - INTERVAL 24 HOUR";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OrderItemLog log = new OrderItemLog();
                log.setLogId(rs.getInt("log_id"));
                log.setOrderItemId(rs.getInt("order_item_id"));
                log.setAction(rs.getString("action"));
                log.setOldQuantity(rs.getInt("old_quantity"));
                log.setNewQuantity(rs.getInt("new_quantity"));
                log.setOldPrice(rs.getDouble("old_price"));
                log.setNewPrice(rs.getDouble("new_price"));
                log.setChangeTime(rs.getTimestamp("change_time"));
                log.setChangedBy(rs.getString("changed_by"));
                log.setChecked(rs.getBoolean("checked"));
                logs.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }

    public void markLogsAsChecked(List<OrderItemLog> logs) {
        // Câu lệnh SQL để cập nhật trường 'checked' thành 1
        String sql = "UPDATE orderitem_logs SET checked = 1 WHERE log_id = ?";

        // Mở kết nối và thực thi câu lệnh SQL
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Duyệt qua từng bản ghi trong danh sách logs và thực hiện cập nhật
            for (OrderItemLog log : logs) {
                // Lấy logId từ đối tượng OrderItemLog và gán vào PreparedStatement
                stmt.setInt(1, log.getLogId());

                // Thực thi câu lệnh cập nhật
                stmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();  // In lỗi nếu có
        }
    }

    public String getOrderDetails(int orderItemId) {
        // Giả sử bạn sử dụng JDBC hoặc ORM để truy vấn cơ sở dữ liệu
        String orderId = "";
        String sql = "SELECT o.order_id FROM orderitems oi "
                + "JOIN orders o ON oi.order_id = o.order_id "
                + "WHERE oi.order_item_id = ?";

        // Kết nối với cơ sở dữ liệu và thực thi truy vấn, sau đó trả về order_id
        try (Connection connection = Database.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, orderItemId); // Set the order_item_id parameter
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                orderId = rs.getString("order_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public List<OrderItemChangeCount> getOrderItemChangeCounts() {
        List<OrderItemChangeCount> changeCounts = new ArrayList<>();
        String sql = "SELECT order_item_id, COUNT(*) AS change_count " +
                "FROM orderitem_logs " +
                "GROUP BY order_item_id";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int orderItemId = rs.getInt("order_item_id");
                int changeCount = rs.getInt("change_count");

                // Lấy thông tin về order và order_item
                String orderId = getOrderDetails(orderItemId);  // Lấy order_id từ order_item_id
                OrderItemChangeCount change = new OrderItemChangeCount(orderItemId, changeCount, orderId);
                changeCounts.add(change);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return changeCounts;
    }

    public List<OrderItemLog> getOrderItemLogsByOrderId(int orderId) {
        List<OrderItemLog> logs = new ArrayList<>();

        // Truy vấn SQL để lấy các trường cần thiết trong 24 giờ qua cho một đơn hàng cụ thể
        String sql = "SELECT log_id, order_item_id, action, old_quantity, new_quantity, " +
                "old_price, new_price, change_time, changed_by, checked " +
                "FROM orderitem_logs " +
                "WHERE change_time > NOW() - INTERVAL 24 HOUR " +
                "AND order_item_id IN (SELECT order_item_id FROM orderitems WHERE order_id = ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set giá trị cho tham số orderId
            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                // Duyệt qua kết quả trả về từ truy vấn SQL
                while (rs.next()) {
                    OrderItemLog log = new OrderItemLog();
                    log.setLogId(rs.getInt("log_id"));
                    log.setOrderItemId(rs.getInt("order_item_id"));
                    log.setAction(rs.getString("action"));
                    log.setOldQuantity(rs.getInt("old_quantity"));
                    log.setNewQuantity(rs.getInt("new_quantity"));
                    log.setOldPrice(rs.getDouble("old_price"));
                    log.setNewPrice(rs.getDouble("new_price"));
                    log.setChangeTime(rs.getTimestamp("change_time"));
                    log.setChangedBy(rs.getString("changed_by"));
                    log.setChecked(rs.getBoolean("checked"));

                    // Thêm log vào danh sách
                    logs.add(log);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Nên thay thế bằng logging để dễ theo dõi
        }

        return logs;
    }

//    public void sendEmailToAdmins(int orderId, String subject) {
//        // Lấy danh sách các admin email
//        List<String> adminEmails = getAdminEmails();
//
//        // Lấy các log thay đổi của đơn hàng
//        List<OrderItemLog> logs = getOrderItemLogsByOrderId(orderId);
//
//        // Tạo nội dung email
//        StringBuilder emailBody = new StringBuilder();
//        emailBody.append("Thông tin thay đổi trong đơn hàng với Order ID: ").append(orderId).append("\n\n");
//
//        if (logs.isEmpty()) {
//            emailBody.append("Không có thay đổi nào trong 24 giờ qua.\n");
//        } else {
//            emailBody.append("Các thay đổi trong 24 giờ qua:\n");
//            for (OrderItemLog log : logs) {
//                emailBody.append("Log ID: ").append(log.getLogId())
//                        .append(", Order Item ID: ").append(log.getOrderItemId())
//                        .append(", Hành động: ").append(log.getAction())
//                        .append(", Số lượng cũ: ").append(log.getOldQuantity())
//                        .append(", Số lượng mới: ").append(log.getNewQuantity())
//                        .append(", Giá cũ: ").append(log.getOldPrice())
//                        .append(", Giá mới: ").append(log.getNewPrice())
//                        .append(", Thời gian thay đổi: ").append(log.getChangeTime())
//                        .append(", Người thay đổi: ").append(log.getChangedBy())
//                        .append(", Đã kiểm tra: ").append(log.isChecked() ? "Có" : "Không")
//                        .append("\n");
//            }
//        }
//
//        // Cấu hình gửi email
//        String fromEmail = "WebbdsHomeLander"; // Địa chỉ email người gửi
//        Properties properties = new Properties();
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
//        properties.put("mail.smtp.host", SMTP_HOST);
//        properties.put("mail.smtp.port", SMTP_PORT);
//        // Tạo đối tượng Session
//        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication("khoangoquan@gmail.com", "mzrs xvca qstr zegw");  // Thông tin tài khoản email của bạn
//            }
//        });
//
//        try {
//            // Duyệt qua danh sách các admin và gửi email cho từng người
//            for (String adminEmail : adminEmails) {
//                // Tạo đối tượng MimeMessage
//                MimeMessage message = new MimeMessage(session);
//                message.setFrom(new InternetAddress(fromEmail));
//                message.addRecipient(Message.RecipientType.TO, new InternetAddress(adminEmail));  // Email của admin
//                message.setSubject(subject);  // Tiêu đề email
//                message.setText(emailBody.toString());  // Nội dung email
//
//                // Gửi email
//                Transport.send(message);
//                System.out.println("Email đã được gửi đến: " + adminEmail);
//            }
//        } catch (MessagingException e) {
//            e.printStackTrace();  // Xử lý lỗi nếu có
//        }
//    }
//
//    public List<String> getAdminEmails() {
//        List<String> adminEmails = new ArrayList<>();
//        String sql = "SELECT email FROM users WHERE role = 'admin'"; // Câu truy vấn lấy email của các admin
//
//        try (Connection conn = Database.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql);
//             ResultSet rs = ps.executeQuery()) {
//
//            while (rs.next()) {
//                String email = rs.getString("email");
//                adminEmails.add(email);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return adminEmails;
//    }
}


