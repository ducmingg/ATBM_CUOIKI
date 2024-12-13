package Service;

import Entity.OrderItemLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/longPolling")
public class LongPollingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int POLL_INTERVAL = 5000; // Thời gian chờ giữa các lần quét (5 giây)

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        long startTime = System.currentTimeMillis();

        // Tạo JSON phản hồi
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{\"notifications\":[");

        boolean hasNotification = false;

        while (System.currentTimeMillis() - startTime < POLL_INTERVAL) {
            // Truy vấn logs
            OrderItemLogService service = new OrderItemLogService();
            List<OrderItemLog> logs = service.getChangedLogsInLast24Hours();

            if (!logs.isEmpty()) {
                for (OrderItemLog log : logs) {
                    int orderItemId = log.getOrderItemId();
                    String orderId = service.getOrderDetails(orderItemId);

                    // Thêm thông báo vào JSON
                    if (hasNotification) {
                        jsonBuilder.append(",");
                    }
                    jsonBuilder.append("{\"orderId\":\"").append(orderId).append("\",")
                            .append("\"message\":\"Đơn hàng ").append(orderId).append(" đã thay đổi!\"}");
                    hasNotification = true;
                }

                // Đánh dấu logs là đã kiểm tra
                service.markLogsAsChecked(logs);
                break;
            }

            try {
                Thread.sleep(1000);  // Tạm ngừng 1 giây
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        jsonBuilder.append("]}");
        out.write(jsonBuilder.toString());
        out.flush();
        out.close();
    }
}





