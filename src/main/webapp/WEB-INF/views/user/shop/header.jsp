<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #333;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        .header .brand {
            display: flex;
            align-items: center;
        }
        .header .brand img {
            width: 50px;
            height: auto;
            margin-right: 10px;
        }
        .header .user-info {
            display: flex;
            align-items: center;
            position: relative;
            padding: 0 10px;
            margin-right: 40px;
        }
        .header .user-info img.avatar {
            border-radius: 50%;
            width: 40px;
            height: 40px;
            margin-left: 10px;
        }
        .header .user-info .username-container {
            position: relative;
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        .header .user-info .username-container span {
            margin-left: 10px;
        }
        .header .cart-container {
            display: flex;
            align-items: center;
            padding: 0 10px;
            position: relative;
        }
        .header .cart-container .cart {
            font-size: 24px;
            cursor: pointer;
            position: relative;
        }
        .header .cart-container .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: red;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .header .cart-items {
            display: none;
            position: absolute;
            background: white;
            color: black;
            right: 0;
            top: 50px;
            width: 350px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
            z-index: 1001;
        }
        .cart-items table {
            width: 100%;
            border-collapse: collapse;
        }
        .cart-items th, .cart-items td {
            padding: 8px 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .cart-items th {
            background-color: #f2f2f2;
        }
        .cart-items img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
        .cart-items td {
            vertical-align: middle;
        }
        .cart-items .product-name {
            white-space: normal; /* Cho phép xuống dòng khi tên sản phẩm quá dài */
        }
        .cart-total {
            padding: 10px;
            font-weight: bold;
            text-align: right;
            border-top: 1px solid #ddd;
        }
        .cart-checkout {
            padding: 10px;
            text-align: right;
        }
        .cart-checkout button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }
        .cart-checkout button:hover {
            background-color: #218838;
        }
        .header .logout {
            display: none;
            position: absolute;
            right: 0;
            top: 20px;
            background-color: #f44336;
            border: none;
            color: white;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
        }
        .header .logout:hover {
            background-color: #d32f2f;
        }
        .header .user-info .username-container:hover .logout {
            display: block;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="brand">
        <img src="/img/svg/logo.svg" alt="Logo">
        <span>ORDER Uy Tín</span>
    </div>
    <div class="user-info">
        <!-- <img src="${user.avatarUrl}" alt="Avatar" class="avatar"> -->
        <div class="username-container">
            <span>${loginUser.userName}</span>
            <form action="/logout" method="post" style="margin: 0;">
                <button type="submit" class="logout">Logout</button>
            </form>
        </div>
        <div class="cart-container">
            <i class="fas fa-shopping-cart cart"></i>
            <span class="cart-count">0</span>
            <div class="cart-items">
                <table>
                    <thead>
                        <tr>
                            <th>Mẫu</th>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                        </tr>
                    </thead>
                    <tbody class="cart-items-list">
                        <!-- Danh sách các vật phẩm trong giỏ hàng sẽ được thêm vào đây -->
                    </tbody>
                </table>
                <div class="cart-total">
                    <!-- Tổng giá trị giỏ hàng -->
                </div>
                <div class="cart-checkout">
                    <form action="/shop/checkout" method="get">
                        <button type="submit">Thanh toán</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/float-contact.jsp"/>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const cartIcon = document.querySelector('.cart-container .cart');
    const cartItemsContainer = document.querySelector('.cart-items');
    const cartItemsList = document.querySelector('.cart-items-list');
    const cartTotal = document.querySelector('.cart-total');
    const cartCount = document.querySelector('.cart-count');

    document.addEventListener('click', function(event) {
        const isClickInside = cartIcon.contains(event.target) || cartItemsContainer.contains(event.target);
        if (!isClickInside) {
            cartItemsContainer.style.display = 'none';
        }
    });

    cartIcon.addEventListener('click', function(event) {
        event.stopPropagation();
        cartItemsContainer.style.display = cartItemsContainer.style.display === 'none' ? 'block' : 'none';
    });

    // Function to update cart UI
    function updateCartUI(cart) {
        cartItemsList.innerHTML = '';
        cartTotal.innerHTML = '';

        let total = 0;
        let count = 0;
        cart.forEach(item => {
            const itemRow = document.createElement('tr');

            const imgCell = document.createElement('td');
            const img = document.createElement('img');
            img.src = item.image;
            img.alt = item.name;
            img.style.width = '50px';
            img.style.height = '50px';
            imgCell.appendChild(img);

            const nameCell = document.createElement('td');
            nameCell.textContent = item.name;
            nameCell.className = 'product-name';

            const priceCell = document.createElement('td');
            priceCell.textContent = item.price.toFixed(2);

            const quantityCell = document.createElement('td');
            quantityCell.textContent = item.quantity;

            itemRow.appendChild(imgCell);
            itemRow.appendChild(nameCell);
            itemRow.appendChild(priceCell);
            itemRow.appendChild(quantityCell);

            cartItemsList.appendChild(itemRow);
            total += item.price * item.quantity;
            count += item.quantity;
        });

        cartTotal.textContent = `Total: ` + total.toFixed(2);
        cartCount.textContent = count;
    }

    // Fetch cart items from the server
    function fetchCartItems() {
        fetch('/shop/get-cart')
            .then(response => response.json())
            .then(data => {
                updateCartUI(data.cart);
            });
    }

    // Initial fetch
    fetchCartItems();
});
</script>

</body>
</html>
