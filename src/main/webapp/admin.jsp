<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.CommentDAO" %>
<%@ page import="Dao.PropertyDAO" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<%
    // Sử dụng biến session có sẵn trong JSP
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng đến trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }
    CommentDAO commentDAO = new CommentDAO();
    PropertyDAO productDAO = new PropertyDAO();
    int totalComments = commentDAO.getTotalComments();
    int totalProducts = productDAO.getTotalProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<div class="container">

    <div class="sidebar">
        <ul>
            <li><a href="admin.jsp">Main Dashboard</a></li>
            <li><a href="users">Quản lý tài khoản</a></li>
            <li><a href="home-manager">Quản lý sản phẩm</a></li>
<%--            <li><a href="top-property.jsp">Quản lý sản phẩm bán chạy</a></li>--%>
            <li><a href="home-manager">Quản lý nhà phân phối</a></li>
<%--            <li><a href="top-user-manager">Quản lý top 5 khách</a></li>--%>
<%--            <li><a href="top-employee-manager.jsp">Quản lý top 5 nhân viên</a></li>--%>
            <li><a href="orders">Quản lý đơn đặt hàng</a></li>
            <li><a href="comments-manager.jsp">Quản lý bình luận</a></li>

        </ul>
    </div>

    <div class="main-content">
        <div class="dashboard-header">
            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Tổng bất động sản</h3>
                <p><%= totalProducts %></p>
            </div>

                <div class="dashboard-item">
                    <h3><i class="fas fa-box"></i> Products - Available</h3>
<%--                    <p><%= totalAvailable %></p> <!-- Số lượng sản phẩm còn hàng -->--%>
                </div>
<%--                <div class="dashboard-item">--%>
<%--                    <h3><i class="fas fa-box"></i> Products - Sold</h3>--%>
<%--                    <p><%= totalSold %></p> <!-- Số lượng sản phẩm đã bán -->--%>
<%--                </div>--%>
<%--                <div class="dashboard-item">--%>
<%--                    <h3><i class="fas fa-box"></i> Products - Out of Stock</h3>--%>
<%--                    <p><%= totalOutOfStock %></p> <!-- Số lượng sản phẩm hết hàng -->--%>
<%--                </div>--%>
            </div>

            <div class="dashboard-item">
                <h3><i class="fas fa-comments"></i> Tổng bình luận</h3>
                <p><%= totalComments %></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
