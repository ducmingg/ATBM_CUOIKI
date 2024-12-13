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

    <!-- Nút bấm để bắt đầu long-polling -->
    <button id="start-polling-btn" class="bg-blue-500 text-white px-4 py-2 rounded mt-5 hover:bg-blue-700">
        Kiểm tra thông báo thay đổi
    </button>

</div>

<!-- Chèn mã JavaScript để thực hiện long-polling -->
<script>


    // Hàm long-polling
    function longPolling() {
        fetch("http://localhost:8080/Batdongsan/orders")
            .then(response => response.json())
            .then(data => {
                const notifications = data.notifications; // Giả sử bạn nhận được các thông báo từ server
                if (notifications && notifications.length > 0) {
                    notifications.forEach(notification => {
                        const orderId = notification.orderId;
                        const changeMessage = notification.message;

                        // Tìm phần tử thông báo thay đổi theo orderId
                        const notificationElement = document.getElementById(`notification-count-${orderId}`);
                        if (notificationElement) {
                            // Cập nhật số lượng thay đổi
                            notificationElement.textContent = changeMessage;

                            // Thêm hiệu ứng bounce
                            notificationElement.classList.add('bounce');

                            // Sau khi hiệu ứng chạy xong, bỏ lớp bounce để tái sử dụng
                            setTimeout(() => {
                                notificationElement.classList.remove('bounce');
                            }, 300); // Thời gian hiệu ứng là 300ms
                        } else {
                            // Nếu không có phần tử thông báo, tạo mới
                            const newNotification = document.createElement('span');
                            newNotification.id = `notification-count-${orderId}`;
                            newNotification.textContent = changeMessage;
                            newNotification.classList.add('notification-count', 'bounce');
                            document.querySelector(`#order-${orderId}`).appendChild(newNotification);
                        }
                    });
                }
            })
            .catch(error => console.error('Lỗi trong long-polling:', error));

        // Tiếp tục long-polling mỗi 5 giây nếu không có sự thay đổi
        setTimeout(longPolling, 5000); // 5000ms = 5 giây
    }

    // Bắt đầu long-polling khi trang tải xong
    document.addEventListener('DOMContentLoaded', () => {
        longPolling();
    });


    // Thêm sự kiện nhấn nút để bắt đầu long-polling
    document.getElementById('start-polling-btn').addEventListener('click', function () {
        longPolling(); // Kích hoạt long-polling khi người dùng nhấn nút
    });
</script>

</body>
</html>
