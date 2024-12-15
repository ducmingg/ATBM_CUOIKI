package Controller;

import Dao.OrderDAO;


import Entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/processed-order")
public class ViewProcessedOrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Tạo đối tượng OrderDAO để lấy danh sách đơn hàng đã xử lý
        OrderDAO orderDAO = new OrderDAO();
        List<Order> processedOrders = orderDAO.getProcessedOrders();

        // Kiểm tra xem danh sách có được trả về không
        if (processedOrders == null || processedOrders.isEmpty()) {
            System.out.println("Không có đơn hàng đã xử lý.");
        }

        // Lưu danh sách đơn hàng đã xử lý vào request để hiển thị trên JSP
        request.setAttribute("processedOrders", processedOrders);

        // Forward đến trang JSP để hiển thị kết quả
        request.getRequestDispatcher("processed-order.jsp").forward(request, response);
    }
}

