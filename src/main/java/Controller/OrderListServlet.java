package Controller;

import DBcontext.Database;
import Entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrderListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // List to store orders
        List<Order> orders = new ArrayList<>();

        // Get database connection
        try (Connection conn = Database.getConnection()) {
            // Query lấy thông tin đơn hàng và trạng thái từ bảng orderitems
            String query = "SELECT * FROM orders";
            try (PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {

                // Fetch orders and their statuses from result set
                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    int userId = rs.getInt("user_id");
                    String username = rs.getString("username");
                    Date date = rs.getDate("order_date");

                    // Tạo đối tượng Order với trạng thái
                    orders.add(new Order(orderId, userId, username, date));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Set the list of orders in the request
        request.setAttribute("orders", orders);

        // Forward to JSP page
        request.getRequestDispatcher("orders.jsp").forward(request, response);
    }
}

