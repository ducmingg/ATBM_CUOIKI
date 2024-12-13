<%@ page import="Entity.Order" %>
<%@ page import="Entity.OrderItemChangeCount" %>
<%@ page import="java.util.List" %>
<%@ page import="Service.OrderItemLogService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
    <!-- Thêm Font Awesome để sử dụng biểu tượng chuông -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Quản lý Đơn hàng</h1>

    <!-- Liên kết quay lại trang admin -->
    <a href="admin.jsp" class="text-blue-500 mb-5 inline-block">Quay lại trang quản lý admin</a>
    <div>
        <a href="processed-order" class="text-red-500">Xem chi tiết đơn hàng đã xác nhận</a>
    </div>

    <%-- Lấy danh sách đơn hàng từ request --%>
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        OrderItemLogService orderItemLogService = new OrderItemLogService();

        // Lấy số lần thay đổi của từng đơn hàng
        List<OrderItemChangeCount> changeCounts = orderItemLogService.getOrderItemChangeCounts();
    %>

    <%-- Nếu có đơn hàng --%>
    <%
        if (orders != null && !orders.isEmpty()) {
    %>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Mã đơn hàng</th>
            <th class="px-4 py-2">Tên khách hàng</th>
            <th class="px-4 py-2">Mã khách hàng</th>
            <th class="px-4 py-2">Ngày đơn hàng</th>
            <th class="px-4 py-2">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Lặp qua từng đơn hàng và hiển thị thông tin
            for (Order order : orders) {
                // Lấy số lần thay đổi cho đơn hàng hiện tại

                int changeCount = 0;
                for (OrderItemChangeCount change : changeCounts) {
                    if (String.valueOf(change.getOrderId()).equals(String.valueOf(order.getOrderId()))) {
                        changeCount = change.getChangeCount();
                        break;
                    }
                }
        %>


        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %>
            </td>
            <td class="px-4 py-2"><%= order.getUsername() %>
            </td>
            <td class="px-4 py-2"><%= order.getUserId() %>
            </td>
            <td class="px-4 py-2"><%= order.getOrderDate() %>


            <td class="px-4 py-2 relative">
                <!-- Biểu tượng chỉnh sửa -->
                <a href="order-change.jsp?orderId=<%= order.getOrderId() %>" class="text-blue-500 hover:text-blue-700">
                    <i class="fas fa-pencil-alt"></i>
                </a>

                <!-- Thông báo số lần thay đổi -->
                <span id="notification-count-<%= order.getOrderId() %>"
                      class="absolute top-0 right-0 rounded-full bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center -top-2 -right-2">
        <%= changeCount %> <!-- Hiển thị số lần thay đổi -->
    </span>
            </td>

        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <% } else { %>
    <p class="text-center text-red-500">Không có đơn hàng nào.</p>
    <% } %>

    <!-- Nút khởi tạo long-polling -->
    <button id="start-polling-btn" class="bg-blue-500 text-white px-4 py-2 rounded mt-5 hover:bg-blue-700">
        Kiểm tra thông báo thay đổi
    </button>

    <script>
        // Script chính - Gọi servlet long-polling
        const targetUrl = "http://localhost:8080/Batdongsan/longPolling"; // URL đến Servlet

        // Hàm long-polling
        function longPolling() {
            fetch(targetUrl)
                .then(response => response.json())  // Phản hồi JSON từ server
                .then(data => {
                    const notifications = data.notifications;

                    // Kiểm tra và xử lý thông báo nếu có
                    if (notifications && notifications.length > 0) {
                        notifications.forEach(notification => {
                            console.log(`Order ID: ${notification.orderId}, Message: ${notification.message}`);
                        });
                    } else {
                        console.log("Không có thay đổi nào.");
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gọi long-polling:', error);
                });
        }

        // Gọi long-polling khi trang load
        longPolling();

        // Lặp lại long-polling sau mỗi 5 giây (có thể tùy chỉnh thời gian)
        setInterval(longPolling, 5000);
    </script>


</div>


</body>
</html>
