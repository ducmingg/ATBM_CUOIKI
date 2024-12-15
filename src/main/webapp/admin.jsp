<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Dao.CommentDAO" %>
<%@ page import="Dao.PropertyBystatusDAO" %>
<%@ page import="Entity.Property1" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<%
    // Kiểm tra quyền admin
    String role = (String) session.getAttribute("role");

    if (!"admin".equals(role)) {
        // Nếu không phải admin, chuyển hướng tới trang không có quyền truy cập
        response.sendRedirect("access-denied.jsp");
        return;
    }

    // Khởi tạo các đối tượng DAO
    CommentDAO commentDAO = new CommentDAO();
    PropertyBystatusDAO propertyBystatusDAO = new PropertyBystatusDAO();

    // Lấy tổng số bình luận
    int totalComments = commentDAO.getTotalComments();

    // Lấy số lượng bất động sản theo các trạng thái
    int status1Count = propertyBystatusDAO.countPropertiesByStatus(1);  // Kích hoạt
    int status2Count = propertyBystatusDAO.countPropertiesByStatus(2);  // Vô hiệu hóa
    int status3Count = propertyBystatusDAO.countPropertiesByStatus(3);  // Trạng thái khác (nếu có)

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
            <li><a href="home-manager">Quản lý nhà phân phối</a></li>
            <li><a href="orders">Quản lý đơn đặt hàng</a></li>
            <li><a href="comments-manager.jsp">Quản lý bình luận</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="dashboard-header">
            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Tổng bất động sản</h3>
                <p><%= status1Count + status2Count + status3Count %></p> <!-- Tổng số bình luận -->
            </div>

            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Bất động sản - Bán</h3>
                <p><%= status1Count %></p> <!-- Số lượng bất động sản có trạng thái "Kích hoạt" -->
            </div>

            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Bất động sản - Cho thuê</h3>
                <p><%= status2Count %></p> <!-- Số lượng bất động sản có trạng thái "Vô hiệu hóa" -->
            </div>

            <div class="dashboard-item">
                <h3><i class="fas fa-box"></i> Bất động sản - Trạng thái khác</h3>
                <p><%= status3Count %></p> <!-- Số lượng bất động sản có trạng thái khác (nếu có) -->
            </div>

            <div class="dashboard-item">
                <h3><i class="fas fa-comments"></i> Tổng bình luận</h3>
                <p><%= totalComments %></p> <!-- Tổng số bình luận -->
            </div>
        </div>
    </div>
</div>
</body>
</html>
