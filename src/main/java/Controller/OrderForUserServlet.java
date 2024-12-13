package Controller;

import Dao.OrderDAO;
import Entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/order-for-user")
public class OrderForUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderDAO dao = new OrderDAO();
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        List<Order> orders = dao.getOrderByUserId(userId);

        req.setAttribute("orders", orders);

        // Chuyển tiếp đến trang JSP
        req.getRequestDispatcher("orders.jsp").forward(req, resp);
    }
}
