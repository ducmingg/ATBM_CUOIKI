package Service;

import DBcontext.Database;
import Entity.OrderItemLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
}
