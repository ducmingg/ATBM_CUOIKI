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
            <td class="px-4 py-2">
                <!-- Biểu tượng chuông thông báo -->
                <i class="fas fa-bell ml-3 text-yellow-500 cursor-pointer relative"
                   id="bell-icon-<%= order.getOrderId() %>"></i>
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
    function fetchNotifications() {
        fetch('/longPolling') // Gọi đến Servlet longPolling
            .then(response => response.json())
            .then(data => {
                if (data.notifications && data.notifications.length > 0) {
                    data.notifications.forEach(notification => {
                        const orderId = notification.orderId;
                        const bellIcon = document.getElementById('bell-icon-' + orderId); // Lấy chuông theo orderId

                        if (bellIcon) {
                            // Thêm badge số thông báo vào chuông
                            let badge = bellIcon.querySelector('.notification-badge');
                            if (!badge) {
                                badge = document.createElement('span');
                                badge.classList.add(
                                    'absolute',
                                    'top-0',
                                    'right-0',
                                    'rounded-full',
                                    'bg-red-500',
                                    'text-white',
                                    'text-xs',
                                    'w-5',
                                    'h-5',
                                    'flex',
                                    'items-center',
                                    'justify-center',
                                    'notification-badge'
                                );
                                bellIcon.appendChild(badge);
                            }
                            badge.textContent = '1'; // Hiển thị số thông báo
                        }
                    });
                }
            })
            .catch(error => console.error('Error fetching notifications:', error));
    }

    // Gọi lại fetchNotifications mỗi 5 giây
    setInterval(fetchNotifications, 5000);

</script>

</body>
</html>
