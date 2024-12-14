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

<%

    Integer userId = (Integer) session.getAttribute("userId");
    System.out.println(userId);
    if (userId != null) {
%>
<p>User ID: <%= userId %>
</p>
<%
} else {
%>
<p>Không tìm thấy User ID.</p>
<%
    }
%>

<div class="container">

    <%
        // Hiển thị thông báo nếu có
        String message = (String) session.getAttribute("message");
        if (message != null) {
            session.removeAttribute("message"); // Xóa thông báo sau khi hiển thị
    %>
    <div class="alert"
         style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; font-size: 1.2em; font-weight: bold; margin: 10px 0;">
        <%= message %>
    </div>
    <%
        }
    %>


    <h1><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </h1>
    <h1>Tạo khóa</h1>
    <form id="key-form" method="post" action="digital-signature">
        <div class="key-generation-section">
            <button type="submit" name="action" value="generateKey" id="generate-keys-btn">Tạo Khóa Mới</button>
            <div>
                <label for="public-key">Khóa Công Khai (Public Key):</label>
                <textarea id="public-key" name="publickey" rows="4" readonly
                          placeholder="Khóa công khai sẽ hiển thị ở đây..."><%= request.getAttribute("publickey") != null ? request.getAttribute("publickey") : "" %></textarea>
            </div>
            <div>
                <label for="private-key">Khóa Riêng (Private Key):</label>
                <textarea id="private-key" rows="4" readonly
                          placeholder="Khóa riêng sẽ hiển thị ở đây..."><%= request.getAttribute("privatekey") != null ? request.getAttribute("privatekey") : "" %></textarea>
            </div>
            <div>
                <button type="button" id="download-private-key-btn">Tải Khóa Riêng Xuống</button>
            </div>
        </div>
        <div class="file-upload-section">
            <label for="upload-public-key">Tải khóa công khai (Public Key) từ tệp:</label>
            <input type="file" id="upload-public-key" name="uploadPublicKey" accept=".txt">
        </div>
        <div class="public-key-upload">
            <button type="submit" name="action" value="uploadPublicKey">Tải Lên</button>
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
    document.getElementById('download-private-key-btn').addEventListener('click', function () {
        // Lấy nội dung từ textarea (Khóa Riêng)
        const privateKeyText = document.getElementById('private-key').value;

        const blob = new Blob([privateKeyText], {type: 'text/plain'});

        const url = URL.createObjectURL(blob);

        const link = document.createElement('a');
        link.href = url;
        link.download = 'private_key.txt';
        link.click();

        URL.revokeObjectURL(url);
    });
    // Tạo chức năng upload public key
    document.querySelector('button[name="action"][value="uploadPublicKey"]').addEventListener('click', function (event) {
        event.preventDefault(); // Ngăn gửi form tự động

        const fileInput = document.getElementById('upload-public-key');
        const file = fileInput.files[0]; // Lấy tệp đã chọn

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                // Nội dung tệp Public Key
                const publicKeyContent = e.target.result;

                // Hiển thị nội dung trong textarea của public key
                document.getElementById('public-key').value = publicKeyContent;
            };

            reader.readAsText(file); // Đọc tệp dưới dạng text
        } else {
            alert('Vui lòng chọn tệp trước khi tải lên!');
        }
    });

</script>
</body>
</html>