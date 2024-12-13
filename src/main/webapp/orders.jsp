<%@ page import="Entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Quản lý Đơn hàng</h1>

    <!-- Liên kết quay lại trang admin -->
    <a href="admin.jsp" class="text-blue-500 mb-5 inline-block">Quay lại trang quản lý admin</a>
    <div>
        <a href="processed-order" class="text-red-500">Xem chi tiết đơn hàng đã xác nhận</a>
    </div>

    <!-- Thông báo đơn hàng thay đổi -->
    <div id="notificationContainer" class="mb-4">
        <!-- Thông báo sẽ được thêm vào ở đây -->
    </div>

    <%-- Lấy danh sách đơn hàng từ request --%>
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
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

        </tr>
        </thead>
        <tbody>
        <%
            // Lặp qua từng đơn hàng và hiển thị thông tin
            for (Order order : orders) {
                // Lấy trạng thái của đơn hàng
                String status = order.getStatus();
                String displayStatus = "";
                // Kiểm tra trạng thái và gán giá trị hiển thị
                if ("processed".equalsIgnoreCase(status)) {
                    displayStatus = "✔"; // Tích nếu trạng thái là processed
                } else if ("pending".equalsIgnoreCase(status)) {
                    displayStatus = "✘"; // Dấu x nếu trạng thái là pending
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
            </td>
            <td class="px-4 py-2"><%= displayStatus %>
            </td>
            <td class="px-4 py-2">
                <% if ("processed".equalsIgnoreCase(status)) { %>
                <a href="order-detail?orderId=<%= order.getOrderId() %>" class="text-blue-500">Xem chi tiết</a>
                | <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-blue-500">Sửa</a>
                <% } %>
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
</div>

<script>
    function checkForUpdates() {
        fetch('longPolling') // Gọi servlet longPolling
            .then(response => response.text())
            .then(data => {
                if (data) {
                    // Hiển thị thông báo khi có thay đổi
                    document.getElementById('notificationContainer').innerHTML = data;
                }
                // Lặp lại long polling sau khi có phản hồi
                setTimeout(checkForUpdates, 5000); // Kiểm tra lại sau 5 giây
            })
            .catch(error => {
                console.error('Error during long polling: ', error);
                // Thử lại sau 10 giây nếu có lỗi
                setTimeout(checkForUpdates, 10000);
            });
    }

    // Bắt đầu long polling khi trang được tải
    window.onload = checkForUpdates;
</script>

</body>
</html>
