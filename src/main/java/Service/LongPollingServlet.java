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

    private OrderItemLogService logService = new OrderItemLogService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        // Lấy danh sách các bản ghi thay đổi từ bảng orderitem_logs
        List<OrderItemChangeCount> changeCounts = logService.getOrderItemChangeCounts();

        // Nhóm các bản ghi theo orderId và cộng dồn số lần thay đổi
        Map<String, Integer> groupedChanges = new HashMap<>();

        for (OrderItemChangeCount change : changeCounts) {
            groupedChanges.put(change.getOrderId(),
                    groupedChanges.getOrDefault(change.getOrderId(), 0) + change.getChangeCount());
        }

        // Nếu không có thay đổi nào, chờ (giữ kết nối mở)
        if (groupedChanges.isEmpty()) {
            try {
                // Chờ thêm một chút (ví dụ 5 giây) trước khi kiểm tra lại
                Thread.sleep(5000); // Chờ 5 giây trước khi kiểm tra lại
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            // Tiếp tục gọi lại phương thức này để kiểm tra lại
            doGet(request, response);
            return; // Tránh tiếp tục xử lý nếu chưa có thay đổi
        }

        // Tạo JSON phản hồi
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{\"notifications\":[");

        boolean hasNotification = false;

        // Duyệt qua các thay đổi nhóm và tạo thông báo cho mỗi orderId
        for (Map.Entry<String, Integer> entry : groupedChanges.entrySet()) {
            if (hasNotification) {
                jsonBuilder.append(",");
            }
            String orderId = entry.getKey();
            int totalChangeCount = entry.getValue();
            jsonBuilder.append("{\"orderId\":\"").append(orderId).append("\",")
                    .append("\"message\":\"Đơn hàng ").append(orderId)
                    .append(" đã thay đổi ").append(totalChangeCount).append(" lần!\"}");
            hasNotification = true;
        }

        jsonBuilder.append("]}");

        // Trả về JSON
        out.write(jsonBuilder.toString());
        out.flush();
        out.close();

        // **Gọi phương thức markLogsAsChecked() để đánh dấu các bản ghi là đã kiểm tra**
        List<OrderItemLog> logsToCheck = logService.getChangedLogsInLast24Hours();
        logService.markLogsAsChecked(logsToCheck);

        // **Gửi email cho tất cả admin khi có thay đổi**
        String subject = "Thông báo thay đổi trong đơn hàng";

        // Gửi email thông báo đến tất cả admin
        for (Map.Entry<String, Integer> entry : groupedChanges.entrySet()) {
            String orderId = entry.getKey();
            int totalChangeCount = entry.getValue();
//            logService.sendEmailToAdmins(Integer.parseInt(orderId), subject);
        }
    }
}

