<!DOCTYPE html>
<html lang="vi">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Báo Lộ Key</title>
    <link rel="stylesheet" href="css/key.css">
</head>
<body>
<div class="container">
    <h1>Thông Báo Lộ Key</h1>
    <p>Khóa của bạn đã bị lộ, vui lòng kiểm tra lại các thông tin bảo mật!</p>

    <!-- Chọn ngày và giờ -->
    <div class="datetime-section">
        <label for="date-time">Chọn ngày và giờ:</label>
        <input type="datetime-local" id="date-time">
    </div>
    <div class="notification-section">
        <button id="reveal-key-btn">Báo cáo</button>
    </div>
    <a href="create-key.jsp">
        <div>
            <button onclick="goBack()">Quay lại trang trước</button>
        </div>
    </a>
</div>


</body>
</html>
