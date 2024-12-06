<!DOCTYPE html>
<html lang="vi">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asymmetric Encryption Example</title>
    <link rel="stylesheet" href="css/key.css">
</head>
<body>
<div class="container">
    <h1><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></h1>
    <h1>Tạo khóa</h1>
    <form id="key-form" method="post" action="/digital-signature">
        <div class="key-generation-section">
            <button type="submit" name="action" value="generateKey" id="generate-keys-btn">Tạo Khóa Mới</button>
            <div>
                <label for="public-key">Khóa Công Khai (Public Key):</label>
                <textarea id="public-key" name="publickey" rows="4" readonly placeholder="Khóa công khai sẽ hiển thị ở đây..."><%= request.getAttribute("publickey") != null ? request.getAttribute("publickey") : "" %></textarea>
            </div>
            <div>
                <label for="private-key">Khóa Riêng (Private Key):</label>
                <textarea id="private-key" rows="4" readonly placeholder="Khóa riêng sẽ hiển thị ở đây..."><%= request.getAttribute("privatekey") != null ? request.getAttribute("privatekey") : "" %></textarea>
            </div>
            <div>
                <button type="button" id="download-private-key-btn">Tải Khóa Riêng Xuống</button>
            </div>
        </div>
        <div class="file-upload-section">
            <label for="upload-key">Tải khóa từ tệp (txt):</label>
            <input type="file" id="upload-key" accept=".txt">
        </div>
        <div class="submit-section">
            <button type="submit" name="action" value="submitForm" id="submit-btn">Gửi Khóa</button>
        </div>
        <div class="notification-section">
            <a href="notify.jsp">
                <button type="button" id="reveal-key-btn">Thông Báo Lộ Key</button>
            </a>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/jsrsasign@10.0.6/lib/jsrsasign-all-min.js"></script>
<script src="script.js"></script>
<script>
    // Tạo chức năng tải khóa riêng xuống
    document.getElementById('download-private-key-btn').addEventListener('click', function() {
        // Lấy nội dung từ textarea (Khóa Riêng)
        const privateKeyText = document.getElementById('private-key').value;

        const blob = new Blob([privateKeyText], { type: 'text/plain' });

        const url = URL.createObjectURL(blob);

        const link = document.createElement('a');
        link.href = url;
        link.download = 'private_key.txt';
        link.click();

        URL.revokeObjectURL(url);
    });
</script>
</body>
</html>