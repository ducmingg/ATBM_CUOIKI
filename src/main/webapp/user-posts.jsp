<%@ page import="Dao.PropertyDAO" %>
<%@ page import="Entity.Property1" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Bài Đăng</title>
    <style>
        /* CSS styles as mentioned earlier */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .action-links a {
            margin: 0 10px;
            text-decoration: none;
            color: #007bff;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .delete-link {
            color: red;
        }
        .delete-link:hover {
            color: darkred;
        }
    </style>
</head>
<body>
<%
    // Lấy userId từ tham số URL
    String userIdParam = request.getParameter("userId");
    if (userIdParam == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer userId = Integer.parseInt(userIdParam);

    // Truy vấn các bài đăng của người dùng này
    PropertyDAO propertyDao = new PropertyDAO();
    List<Property1> properties = propertyDao.getPropertiesByUserId(userId);

    // Hiển thị danh sách bất động sản
    if (properties != null && !properties.isEmpty()) {
%>
<table>
    <thead>
    <tr>
        <th>Tên</th>
        <th>Địa Chỉ</th>
        <th>Giá</th>
        <th>Trạng Thái</th>
        <th>Hình ảnh</th>

        <th>Hành Động</th> <!-- Cột hành động -->
    </tr>
    </thead>
    <tbody>
    <%
        for (Property1 property : properties) {
    %>
    <tr>
        <td><%= property.getTitle() %></td>
        <td><%= property.getAddress() %></td>
        <td><%= property.getPrice() %></td>
        <td><%= property.getStatus() %></td>
        <td>
            <img src="<%= property.getImageUrl() != null ? property.getImageUrl() : "default.jpg" %>"
                 alt="Image" width="100">
        </td>
        <td class="action-links">
            <a href="edit-property.jsp?property_id=<%= property.getId() %>">Sửa</a> |
            <form action="properties" method="POST" style="display: inline;">
                <input type="hidden" name="id" value="<%= property.getId() %>">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="userId" value="<%= request.getParameter("userId") %>">
                <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa bất động sản này không?')">Xóa</button>
            </form>
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
<p>Chưa có bài đăng nào.</p>
<%
    }
%>

<!-- Thêm dòng quay lại trang tài khoản -->
<p><a href="account.jsp?userId=<%= userId %>">Quay lại trang tài khoản</a></p>

</body>
</html>
