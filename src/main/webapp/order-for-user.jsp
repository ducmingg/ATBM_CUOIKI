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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-5">

<div class="container mx-auto">
    <h1 class="text-2xl font-bold mb-5">Danh sách Đơn hàng</h1>

    <%
        // Lấy danh sách orders từ attribute
        List<Order> orders = (List<Entity.Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
    <table class="table-auto w-full border-collapse border border-gray-300">
        <thead>
        <tr class="bg-gray-200">
            <th class="border border-gray-300 px-4 py-2">Mã Đơn hàng</th>
            <th class="border border-gray-300 px-4 py-2">Ngày đặt hàng</th>
            <th class="border border-gray-300 px-4 py-2">Trạng thái xác minh</th>
            <th class="border border-gray-300 px-4 py-2">Đã báo cáo</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Duyệt qua danh sách orders
            for (Entity.Order order : orders) {
        %>
        <tr class="bg-white hover:bg-gray-100">
            <td class="border border-gray-300 px-4 py-2"><%= order.getOrderId() %></td>
            <td class="border border-gray-300 px-4 py-2">
                <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(order.getOrderDate()) %>
            </td>
            <td class="border border-gray-300 px-4 py-2">
                <%= (order.getVerify() == 1) ? "Đã xác minh" : "Chưa xác minh" %>
            </td>
            <td class="border border-gray-300 px-4 py-2">
                <%= (order.getIs_report() == 1) ? "Đã báo cáo" : "Chưa báo cáo" %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p class="text-red-500">Không có đơn hàng nào được tìm thấy.</p>
    <%
        }
    %>
</div>

</body>
</html>
