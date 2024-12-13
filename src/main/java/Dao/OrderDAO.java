package Dao;

import DBcontext.Database;
import Entity.Order;
import com.google.api.client.util.DateTime;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static DBcontext.Database.getConnection;

public class OrderDAO {

    // Hàm lấy tất cả đơn hàng đã được xử lý (status = 'processed')
    public List<Order> getProcessedOrders() {
        List<Order> processedOrders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
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

    public List<Order> getOrderByUserId(int userId){
        String sql = "select * from orders where user_id = ?";
        List<Order> orders  = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId); // Gán tham số cho câu lệnh SQL
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                int order_id = rs.getInt(2);
                Date order_date = rs.getDate(3);
                int verify = rs.getInt(6);
                int is_report = rs.getInt(7);
                orders.add(new Order(order_id,order_date,verify,is_report));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        List<Order> orders = o.getOrderByUserId(32);
        for (Order oo: orders             ) {
            System.out.println(oo.toString());
        }
    }
}