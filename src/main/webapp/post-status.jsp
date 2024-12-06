<%
    Integer userId = (Integer) session.getAttribute("userId"); // Kiểm tra userId trong session
    String username = (String) session.getAttribute("username"); // Kiểm tra username trong session

    if (userId == null || username == null) {
        // Nếu chưa đăng nhập, chuyển hướng đến trang login
        response.sendRedirect("login.jsp?redirect=post-status.jsp");
    }
%>

<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Property Details</title>

    <style>
        /* Toàn bộ trang */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        /* Container chính */
        .container {
            width: 60%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* Tiêu đề */
        h2 {
            text-align: center;
            color: #333;
        }

        /* Form */
        form {
            display: flex;
            flex-direction: column;
        }

        form label {
            margin-top: 10px;
            font-weight: bold;
        }

        form input, form textarea {
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form input[type="file"] {
            padding: 5px;
        }

        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Phần thông báo lỗi */
        .error-message {
            color: #f44336;
            font-weight: bold;
            background-color: #fff3f3;
            padding: 10px;
            margin-top: 20px;
            border: 1px solid #f44336;
            border-radius: 4px;
        }

        /* Phần danh sách file đã tải lên */
        .uploaded-files {
            margin-top: 20px;
        }

        .uploaded-files h3 {
            font-size: 18px;
            color: #333;
        }

        .uploaded-files ul {
            list-style-type: none;
            padding: 0;
        }

        .uploaded-files ul li {
            margin-bottom: 10px;
        }

        .uploaded-files img {
            max-width: 300px;
            height: auto;
            border-radius: 4px;
        }

        .uploaded-files a {
            color: #007bff;
            text-decoration: none;
        }

        .uploaded-files a:hover {
            text-decoration: underline;
        }

        /* Phần khi không có file */
        .no-files {
            color: #777;
            font-style: italic;
            margin-top: 20px;
        }
        .exit-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
            margin-top: 20px;
        }

        .exit-link:hover {
            background-color: #d32f2f;
          ;}

    </style>
</head>

<body>

<div class="container">
    <h2> Đăng tin</h2>
    <form action="uploadProperty" method="post" enctype="multipart/form-data">
        <label for="title">Tiêu đề:</label>
        <input type="text" name="title" id="title" required>

        <label for="description">Mô tả:</label>
        <textarea name="description" id="description" required></textarea>

        <label for="price">Giá:</label>
        <input type="number" name="price" id="price" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" name="address" id="address" required>

        <label for="type">Loại:</label>
        <input type="text" name="type" id="type" required>

        <label for="status">Tình trạng:</label>
        <input type="text" name="status" id="status" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" name="area" id="area" required>

        <input type="hidden" name="poster_id" id="poster_id" value="<%= session.getAttribute("posterId") %>">

        <!-- Hình ảnh chính -->
        <label for="file">Tải lên hình ảnh chính:</label>
        <input type="file" name="file" id="file" required accept="image/*" onchange="previewMainImage(event)">

        <div id="mainImagePreview" style="margin-top: 10px;">
            <img id="mainImage" src="" alt="Preview" style="max-width: 200px; max-height: 200px; display: none;">
        </div>

        <!-- Hình ảnh bổ sung -->
        <label for="additional_images">Tải lên hình ảnh bổ sung (không bắt buộc):</label>
        <input type="file" name="additional_images" id="additional_images" multiple accept="image/*" onchange="previewAdditionalImages(event)">

        <div id="additionalImagesPreview" style="margin-top: 10px;">
            <!-- Các hình ảnh bổ sung sẽ hiển thị ở đây -->
        </div>

        <input type="submit" value="Đăng Bất Động Sản">
        <a href="deletePoster" class="exit-link" style="text-align: center" onclick="return confirmExit()">Thoát</a>
    </form>

    <script>
        // Hàm xem trước hình ảnh chính
        function previewMainImage(event) {
            var file = event.target.files[0];  // Lấy file ảnh
            var reader = new FileReader();

            reader.onload = function(e) {
                var imgElement = document.getElementById('mainImage');
                imgElement.style.display = 'block';  // Hiển thị ảnh
                imgElement.src = e.target.result;   // Cập nhật nguồn ảnh
            }

            if (file) {
                reader.readAsDataURL(file);  // Đọc file và hiển thị
            }
        }

        // Hàm xem trước các hình ảnh bổ sung
        function previewAdditionalImages(event) {
            var files = event.target.files;  // Lấy tất cả các file ảnh
            var previewContainer = document.getElementById('additionalImagesPreview');
            previewContainer.innerHTML = '';  // Xóa các hình ảnh cũ trước khi thêm mới

            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                var reader = new FileReader();

                reader.onload = function(e) {
                    // Tạo phần tử <img> cho mỗi ảnh bổ sung
                    var imgElement = document.createElement('img');
                    imgElement.src = e.target.result;  // Đặt nguồn ảnh
                    imgElement.style.maxWidth = '100px';
                    imgElement.style.maxHeight = '100px';
                    imgElement.style.margin = '5px';
                    imgElement.style.display = 'inline-block';

                    previewContainer.appendChild(imgElement);  // Thêm ảnh vào preview
                }

                if (file) {
                    reader.readAsDataURL(file);  // Đọc file và hiển thị
                }
            }
        }
    </script>



    <script>
        function confirmExit() {
            // Hiển thị hộp thoại xác nhận khi người dùng nhấn "Thoát"
            return confirm("Bạn có chắc chắn muốn thoát? Mọi thông tin sẽ bị xóa nếu bạn thoát.");
        }
    </script>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <div class="error-message">
        <%= errorMessage %>
    </div>
    <%
        }
    %>

    <%-- Nếu có file được tải lên, hiển thị các file đó --%>
    <%
        List<String> uploadedFiles = (List<String>) request.getAttribute("uploadedFiles");
        if (uploadedFiles != null && !uploadedFiles.isEmpty()) {
    %>
    <div class="uploaded-files">
        <h3>Danh sách các file đã tải lên:</h3>
        <ul>
            <% for (String file : uploadedFiles) { %>
            <li>
                <%-- Kiểm tra xem file có phải là ảnh hay không --%>
                <%
                    String fileExtension = file.substring(file.lastIndexOf(".") + 1).toLowerCase();
                    if (fileExtension.equals("jpg") || fileExtension.equals("jpeg") || fileExtension.equals("png") || fileExtension.equals("gif")) {
                %>
                <img src="<%= file %>" alt="Uploaded Image">
                <% } else { %>
                <a href="<%= file %>" target="_blank">Download: <%= file %></a>
                <% } %>
            </li>
            <% } %>
        </ul>
    </div>
    <%
    } else {
    %>
    <div class="no-files">
        Không có file nào được tải lên.
    </div>
    <%
        }
    %>

</div>


</body>
</html>
