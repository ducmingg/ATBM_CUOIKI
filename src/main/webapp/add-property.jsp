<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Thêm Sản Phẩm Mới</h1>
    <form action="addProperty" method="POST" enctype="multipart/form-data">
        <%--@declare id="additional_images"--%><label for="title">Tên:</label>
        <input type="text" id="title" name="title" required>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" step="0.01" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" required>

        <label for="area">Diện tích (m²):</label>
        <input type="number" id="area" name="area" required>

        <label for="file">Chọn hình ảnh chính:</label>
        <input type="file" id="file" name="file" accept="image/*" required onchange="previewMainImage(event)">

        <!-- Hiển thị ảnh chính đã chọn -->
        <div>
            <img id="mainImage" src="#" alt="Preview Image" style="max-width: 200px; display: none;"/>
        </div>

        <label for="additional_images">Chọn hình ảnh bổ sung:</label>
        <input type="file" name="additional_images" accept="image/*" multiple onchange="previewAdditionalImages(event)">

        <!-- Hiển thị các hình ảnh bổ sung đã chọn -->
        <div id="additionalImagesPreview"></div>

        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="type">Loại sản phẩm:</label>
        <input type="text" id="type" name="type" required>

        <label for="status">Trạng thái:</label>
        <input type="text" id="status" name="status">

        <button type="submit">Thêm Sản Phẩm</button>
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

        // Hàm xem trước các hình ảnh phụ
        function previewAdditionalImages(event) {
            var files = event.target.files;
            var previewContainer = document.getElementById('additionalImagesPreview');
            previewContainer.innerHTML = ''; // Clear previous previews

            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                var reader = new FileReader();

                reader.onload = function(e) {
                    var imgElement = document.createElement('img');
                    imgElement.src = e.target.result;
                    imgElement.style.maxWidth = '100px';
                    imgElement.style.maxHeight = '100px';
                    imgElement.style.marginRight = '10px';
                    previewContainer.appendChild(imgElement);  // Thêm ảnh vào preview container
                }

                if (file) {
                    reader.readAsDataURL(file);  // Đọc file và hiển thị
                }
            }
        }
    </script>
</div>

</body>
</html>
