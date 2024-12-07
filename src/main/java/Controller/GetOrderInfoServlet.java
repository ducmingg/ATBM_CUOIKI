package Controller;

import Dao.DigitalSignatureDAO;
import Entity.OrderInfo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/get_order_info")
public class GetOrderInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int user_id = (int) session.getAttribute("userId");
        DigitalSignatureDAO dao = new DigitalSignatureDAO();
        String re = dao.getCartItemInfo(user_id);
        resp.setContentType("text/plain");  // Đặt kiểu dữ liệu là văn bản thuần túy
        resp.getWriter().write(re);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
