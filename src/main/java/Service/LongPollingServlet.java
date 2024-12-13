package Service;

import Entity.OrderItemChangeCount;
import Entity.OrderItemLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/longPolling")
public class LongPollingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        // Lấy danh sách số lần thay đổi từ phương thức getOrderItemChangeCounts
        OrderItemLogService logService = new OrderItemLogService();
        List<OrderItemChangeCount> changeCounts = logService.getOrderItemChangeCounts();

        // Tạo JSON phản hồi
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{\"notifications\":[");

        boolean hasNotification = false;

        // Duyệt qua các thay đổi và tạo thông báo cho mỗi orderId
        for (OrderItemChangeCount change : changeCounts) {
            if (hasNotification) {
                jsonBuilder.append(",");
            }
            jsonBuilder.append("{\"orderId\":\"").append(change.getOrderId()).append("\",")
                    .append("\"message\":\"Đơn hàng ").append(change.getOrderId())
                    .append(" đã thay đổi ").append(change.getChangeCount()).append(" lần!\"}");
            hasNotification = true;
        }

        jsonBuilder.append("]}");

        // Trả về JSON
        out.write(jsonBuilder.toString());
        out.flush();
        out.close();
    }
}







