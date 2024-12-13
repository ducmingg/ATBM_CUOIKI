package Service;

import Entity.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationService {

    private Connection connection;

    public NotificationService(Connection connection) {
        this.connection = connection;
    }

    // Thêm thông báo vào bảng notifications
    public void addNotification(int orderId, String message) throws SQLException {
        String query = "INSERT INTO notifications (order_id, message, status) VALUES (?, ?, FALSE)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            stmt.setString(2, message);
            stmt.executeUpdate();
        }
    }

    // Lấy các thông báo mới cho admin
    public List<Notification> getNewNotificationsForAdmin() throws SQLException {
        List<Notification> notifications = new ArrayList<>();
        String query = "SELECT * FROM notifications WHERE status = 0"; // Không cần adminId, chỉ cần lấy những thông báo mới

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Notification notification = new Notification(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
                        rs.getString("message"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at")
                );
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // In ra lỗi SQL chi tiết
            throw e;  // Ném lại exception để servlet có thể xử lý
        }
        return notifications;
    }



    public void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }

}
