<%@ page import="Entity.OrderItemLog" %>
<%@ page import="Service.OrderItemLogService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">

    <%-- Lấy thông tin đơn hàng từ request --%>
    <%
        String orderIdParam = request.getParameter("orderId");
        OrderItemLogService orderItemLogService = new OrderItemLogService();
        List<OrderItemLog> logs = null;

        // Kiểm tra nếu orderId có trong request
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                // Lấy các thay đổi của đơn hàng theo orderId
                logs = orderItemLogService.getOrderItemLogsByOrderId(orderId);
            } catch (NumberFormatException e) {
                logs = null; // Xử lý trường hợp orderId không hợp lệ
            }
        }
    %>

    <%-- Hiển thị danh sách các thay đổi --%>
    <h3 class="text-xl font-bold mb-3">Lịch sử Thay đổi Đơn hàng</h3>

    <table class="table-auto w-full bg-white shadow-md rounded mb-5">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Hành động</th>
            <th class="px-4 py-2">Số lượng cũ</th>
            <th class="px-4 py-2">Số lượng mới</th>
            <th class="px-4 py-2">Giá cũ</th>
            <th class="px-4 py-2">Giá mới</th>
            <th class="px-4 py-2">Thời gian thay đổi</th>
            <th class="px-4 py-2">Người thay đổi</th>
            <th class="px-4 py-2">Đã kiểm tra</th>
        </tr>
        </thead>
        <tbody>
        <%-- Lặp qua từng bản ghi thay đổi và hiển thị --%>
        <%
            if (logs != null && !logs.isEmpty()) {
                for (OrderItemLog log : logs) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= log.getAction() %></td>
            <td class="px-4 py-2"><%= log.getOldQuantity() %></td>
            <td class="px-4 py-2"><%= log.getNewQuantity() %></td>
            <td class="px-4 py-2"><%= log.getOldPrice() %></td>
            <td class="px-4 py-2"><%= log.getNewPrice() %></td>
            <td class="px-4 py-2"><%= log.getChangeTime() %></td>
            <td class="px-4 py-2"><%= log.getChangedBy() %></td>
            <td class="px-4 py-2"><%= log.isChecked() ? "Đã kiểm tra" : "Chưa kiểm tra" %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" class="text-center px-4 py-2 text-red-500">Không có thay đổi nào trong 24 giờ qua.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
