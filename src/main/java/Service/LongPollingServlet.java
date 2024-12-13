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
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        // Đặt thời gian timeout của response lâu (chờ đợi lâu)
        response.setBufferSize(1024 * 1024);  // 1MB buffer
        response.setHeader("Cache-Control", "no-cache");

        PrintWriter out = response.getWriter();

        // Lấy thời gian hiện tại và ước tính thời gian chờ
        long startTime = System.currentTimeMillis();

        // Thực hiện long polling, kiểm tra nếu có thay đổi trong `orderitem_logs`
        while (System.currentTimeMillis() - startTime < POLL_INTERVAL) {
            // Truy vấn bảng `orderitem_logs` để kiểm tra có thay đổi không
            OrderItemLogService service = new OrderItemLogService();
            List<OrderItemLog> logs = service.getChangedLogsInLast24Hours();

            if (!logs.isEmpty()) {
                // Nếu có thay đổi, gửi thông báo cho từng đơn hàng thay đổi
                for (OrderItemLog log : logs) {
                    int orderItemId = log.getOrderItemId(); // Mã item của đơn hàng
                    String orderId = service.getOrderDetails(orderItemId); // Lấy order_id từ orderitems và orders
                    out.write("<div class='notification text-green-500'>Đơn hàng " + orderId + " đã thay đổi!</div>");
                }
                out.flush();

                // Đánh dấu logs là đã kiểm tra
                service.markLogsAsChecked(logs);
                break;
            }

            // Nếu không có thay đổi, tạm dừng một chút trước khi kiểm tra lại
            try {
                Thread.sleep(1000);  // Ngừng 1 giây trước khi tiếp tục quét
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        // Nếu hết thời gian mà không có thay đổi, gửi phản hồi mặc định
        if (System.currentTimeMillis() - startTime >= POLL_INTERVAL) {
            out.write("<div class='notification text-yellow-500'>Không có thay đổi mới.</div>");
            out.flush();
        }

        // Kết thúc response
        out.close();
    }
}

