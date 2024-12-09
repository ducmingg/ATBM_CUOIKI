<%@ page import="Entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="Entity.Notification" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        .bell-icon {
            font-size: 24px;
            color: #4b5563;
            cursor: pointer;
            transition: color 0.3s, transform 0.2s, box-shadow 0.3s;
            margin-left: 50px;
        }

        .bell-icon:hover {
            color: #4CAF50;
            transform: scale(1.2);
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);
        }

        .bell-icon:active {
            color: #FF5722;
            transform: scale(0.95);
        }

        .bell-icon:focus {
            outline: none;
        }

        .bell-icon.new-notification {
            color: #FF5722;
        }

        .notification-list {
            display: none;
        }

        .notification-list.show {
            display: block;
        }
    </style>
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Quản lý Đơn hàng</h1>

    <%-- Kiểm tra quyền admin --%>
    <%
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("admin")) {
            response.sendRedirect("access-denied.jsp");
            return;
        }
    %>


    <%-- Nút quay lại trang admin --%>
    <div class="mb-5">
        <a href="admin.jsp" class="text-blue-600">Quay lại trang quản trị</a>
    </div>

    <%-- Lấy danh sách đơn hàng --%>
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
            <th class="px-4 py-2">Mã khách hàng</th>
            <th class="px-4 py-2">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Order order : orders) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %></td>
            <td class="px-4 py-2"><%= order.getUserName() %></td>
            <td class="px-4 py-2"><%= order.getUserId() %></td>
            <td class="px-4 py-2 action-cell">
                <a href="order-detail?orderId=<%= order.getOrderId() %>" class="text-blue-600">Xem</a> |
                <a href="editOrder.jsp?orderId=<%= order.getOrderId() %>" class="text-green-600">Sửa</a>
                <i class="fa-solid fa-bell bell-icon" onclick="toggleNotifications(<%= order.getOrderId() %>)"></i>
                <div id="notification-list-<%= order.getOrderId() %>" class="notification-list"></div>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%-- Nếu không có đơn hàng --%>
    <%
    } else {
    %>
    <p class="text-center text-red-500">Không có đơn hàng nào.</p>
    <%
        }
    %>
</div>

<script>
    function toggleNotifications(orderId) {
        let notificationList = document.getElementById("notification-list-" + orderId);
        if (notificationList.style.display === "block") {
            notificationList.style.display = "none";
        } else {
            // Fetch thông báo mà không cần adminId, chỉ cần kiểm tra role là admin
            fetch('/NotificationServlet') // Không cần tham số adminId nữa
                .then(response => response.json())
                .then(data => {
                    notificationList.innerHTML = data.map(notification => `
                        <p>${notification.message} - ${notification.createdAt}</p>
                    `).join("");
                    notificationList.style.display = "block";
                })
                .catch(error => {
                    console.error('Error fetching notifications:', error);
                });
        }
    }
</script>
</body>
</html>
