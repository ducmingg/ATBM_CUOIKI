<%@ page import="java.util.List" %>
<%@ page import="Entity.Property1" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="vi">
<head>
    <!-- Tải thư viện CSS và JS cần thiết -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/4.0.1/css/fixedHeader.dataTables.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            max-width: 1200px;
            margin: auto;
        }

        .sidebar {
            width: 200px;
            background-color: #333;
            color: white;
            padding: 20px;
            border-radius: 5px 0 0 5px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin-bottom: 15px;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        .sidebar ul li a:hover {
            text-decoration: underline;
        }

        .main-content {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 0 5px 5px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: left;
            color: #333;
            margin-bottom: 20px;
        }

        .add-button {
            padding: 10px 20px;
            background-color: dodgerblue;
            color: black;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            margin-left: 700px;
            display: inline-block;
        }

        .property-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .property-table th, .property-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .property-table img {
            max-width: 100px;
            height: auto;
            border-radius: 5px;
        }

        .btn-disable {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-enable {
            background-color: green;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-enable:hover, .btn-disable:hover {
            opacity: 0.8;
        }
    </style>

    <title>Danh sách bất động sản</title>
</head>
<body>

<div class="container">
    <div class="main-content">
        <h2>Danh sách bất động sản</h2>
        <a href="add-property.jsp" class="add-button">Thêm bất động sản mới</a>

        <!-- Bảng bất động sản -->
        <table id="propertyTable" class="display property-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Địa chỉ</th>
                <th>Diện tích (m²)</th>
                <th>Hình ảnh</th>
                <th>Thao tác</th>
                <th>Trạng thái</th> <!-- Cột mới cho nút kích hoạt/vô hiệu hóa -->
            </tr>
            </thead>
            <tbody>
            <%
                List<Property1> properties = (List<Property1>) request.getAttribute("properties");
                if (properties != null && !properties.isEmpty()) {
                    for (Property1 property : properties) {
            %>
            <tr>
                <td><%= property.getId() %></td>
                <td><%= property.getTitle() %></td>
                <td><%= property.getPrice() %> tỷ</td>
                <td><%= property.getAddress() %></td>
                <td><%= property.getArea() %> m²</td>
                <td>
                    <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>" alt="Image">
                </td>
                <td>
                    <a href="view-property.jsp?property_id=<%= property.getId() %>">Xem</a> |
                    <a href="edit-property.jsp?property_id=<%= property.getId() %>">Sửa</a> |
                    <a href="add-thumbnail.jsp?property_id=<%= property.getId() %>">Thumbnails</a> |
                    <form action="properties" method="POST" style="display: inline;">
                        <input type="hidden" name="id" value="<%= property.getId() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa bất động sản này không?')">Xóa</button>
                    </form>
                </td>
                <td>
                    <form action="properties" method="POST" style="display: inline;">
                        <input type="hidden" name="id" value="<%= property.getId() %>">
                        <input type="hidden" name="action" value="<%= property.getStatus().equals("0") ? "enable" : "disable" %>">
                        <button type="submit" class="<%= property.getStatus().equals("0") ? "btn-enable" : "btn-disable" %>"
                                onclick="return confirm('Bạn có chắc chắn muốn <%= property.getStatus().equals("0") ? "kích hoạt" : "vô hiệu hóa" %> bất động sản này không?')">
                            <i class="fa <%= property.getStatus().equals("0") ? "fa-check-circle" : "fa-ban" %>"></i>
                            <%= property.getStatus().equals("0") ? "Kích hoạt" : "Vô hiệu hóa" %>
                        </button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8" style="text-align: center;">Không có bất động sản nào.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Các script cho DataTables -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>

</body>
</html>
