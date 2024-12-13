package Dao;

import DBcontext.Database;
import Entity.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Hàm lấy tất cả đơn hàng đã được xử lý (status = 'processed')
    public List<Order> getProcessedOrders() {
        List<Order> processedOrders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = Database.getConnection();
            String sql = "SELECT * FROM orders ";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getDate("order_date"));
                order.setUsername(rs.getString("username"));
                order.setSignature(rs.getString("signature"));
                processedOrders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Trả về danh sách (có thể rỗng hoặc chứa các đơn hàng đã xử lý)
        return processedOrders;
    }

}
