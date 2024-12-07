<%@ page import="Entity.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.CartItemDAO" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đặt lịch</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: antiquewhite;
            margin: 0;
            padding: 20px;


        }

        .appointment-form {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 450px;
            width: 100%;
        }

        .appointment-form h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            border: none;
            background-color: #007bff;
            color: #fff;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="appointment-form">

    <%
        String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cartItems = null;

        if (userId != null) {
            CartItemDAO cartItemDAO = new CartItemDAO();
            try {
                cartItems = cartItemDAO.getCartItemsByUserId(userId);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
    <h2>Nhập thông tin đặt lịch</h2>

        <input class="info" type="text" name="info">
        <button type="submit" id="btn_getinfo" class="submit-btn">Tải đơn hàng xuống</button>
    <form id="schedule-form" method="post" action="schedule-appointment">

    </form>

    <form id="orderForm" action="createOrder" method="POST">
        <input type="hidden" name="userId" value="<%= userId %>">
        <input type="hidden" name="username" value="<%= username %>">

        <% for (CartItem item : cartItems) { %>
        <input type="hidden" name="propertyId" value="<%= item.getPropertyId() %>">
        <input type="hidden" name="title" value="<%= item.getTitle() %>">
        <input type="hidden" name="price" value="<%= item.getPrice() %>">
        <input type="hidden" name="area" value="<%= item.getArea() %>">
        <input type="hidden" name="address" value="<%= item.getAddress() %>">
        <% } %>
        <input type="hidden" name="orderDate" value="<%= new java.util.Date() %>">
        <div class="form-group">
            <label for="address">Nhập chữ kí của đơn hàng:</label>
            <input type="text" id="address" name="signature" required>
        </div>
        <button type="submit" class="submit-btn">Xác nhận đặt lịch</button>
    </form>


</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.getElementById("btn_getinfo").addEventListener('click',(e)=>{
        $.ajax({
            url:"/get_order_info",
            type:"GET",
            success:(resp)=>{
                $(".info").val(resp)
                // const infoVal = $(".info").val();  // Lấy giá trị của input .info
                const blob = new Blob([resp],{type:'text/plain'});
                const url = URL.createObjectURL(blob);
                const link = document.createElement('a');
                link.href = url;
                link.download = 'products.txt';
                link.click();

                URL.revokeObjectURL(url);
            }
        })



    })

</script>
<script>
    const cartItems = JSON.parse(sessionStorage.getItem('cartItems')) || [];
    const productListDiv = document.getElementById('product-list');

    cartItems.forEach((item, index) => {
        const productNameInput = document.createElement('input');
        productNameInput.type = 'hidden';
        productNameInput.name = 'productName' + index;
        productNameInput.value = item.name;

        const productQuantityInput = document.createElement('input');
        productQuantityInput.type = 'hidden';
        productQuantityInput.name = 'productQuantity' + index;
        productQuantityInput.value = 1;

        const productPriceInput = document.createElement('input');
        productPriceInput.type = 'hidden';
        productPriceInput.name = 'productPrice' + index;
        productPriceInput.value = item.price;

        productListDiv.appendChild(productNameInput);
        productListDiv.appendChild(productPriceInput);
    });

    const productCountInput = document.createElement('input');
    productCountInput.type = 'hidden';
    productCountInput.name = 'productCount';
    productCountInput.value = cartItems.length;
    productListDiv.appendChild(productCountInput);
</script>
</body>
</html>
