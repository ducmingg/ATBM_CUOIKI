<%@ page import="java.util.List" %>
<%@ page import="Entity.Order" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng đã xử lý</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">
<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Danh sách Đơn hàng đã xử lý</h1>

    <%-- Lấy danh sách đơn hàng đã xử lý --%>
    <%
        // Giả sử danh sách đơn hàng đã xử lý được truyền vào request từ servlet hoặc controller
        List<Order> processedOrders = (List<Order>) request.getAttribute("processedOrders");

        if (processedOrders == null || processedOrders.isEmpty()) {
    %>
    <p class="text-center text-red-500">Không có đơn hàng nào đã được xử lý.</p>
    <%
    } else {
    %>
    <table class="table-auto w-full bg-white shadow-md rounded">
        <thead>
        <tr class="bg-gray-200 text-left">
            <th class="px-4 py-2">Mã đơn hàng</th>
            <th class="px-4 py-2">Tên khách hàng</th>
            <th class="px-4 py-2">Mã khách hàng</th>
            <th class="px-4 py-2">Ngày đặt hàng</th>
<%--            <th class="px-4 py-2">Chữ ký</th>--%>
        </tr>
        </thead>
        <tbody>
        <% for (Order order : processedOrders) { %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= order.getOrderId() %></td>
            <td class="px-4 py-2"><%= order.getUsername() %></td>
            <td class="px-4 py-2"><%= order.getUserId() %></td>
            <td class="px-4 py-2"><%= order.getOrderDate() %></td>
<%--            <td class="px-4 py-2"><%= order.getSignature() %></td>--%>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>

    <div class="mt-5">
        <a href="admin.jsp" class="text-blue-600">Quay lại trang quản trị</a>
    </div>
</div>
</body>
</html>
