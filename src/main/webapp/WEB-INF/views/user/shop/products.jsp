<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sản phẩm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .product {
            width: 23%;
            box-sizing: border-box;
            margin: 1%;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 350px; /* Điều chỉnh chiều cao phù hợp */
        }
        .product img {
            max-width: 100%;
            max-height: 150px; /* Đảm bảo ảnh không vượt quá thẻ chứa */
            height: auto;
        }
        .product h3 {
            margin: 10px 0;
        }
        .product p {
            margin: 5px 0;
        }
        .product form {
            margin-top: auto;
        }
        .cart-items {
            overflow-y: auto;
            max-height: 400px;
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
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/user/shop/header.jsp"></jsp:include>

<h2>Sản phẩm</h2>
<div class="product-container">
    <c:forEach items="${products}" var="product" varStatus="status">
        <div class="product">
            <h3>${product.name}</h3>
            <p>Giá: ${product.price}</p>
            <p>Loại: ${product.type}</p>
            <p>Số lượng: ${product.quantity}</p>
            <c:if test="${!empty product.images}">
                <img src="${product.images[0].url}" alt="${product.name}">
            </c:if>
            <form action="/shop/add-to-cart" method="post" onsubmit="addToCart(event, '${product.id}', '${product.name}', '${product.price}', '${product.images[0].url}')">
                <input type="hidden" name="productId" value="${product.id}">
                <button type="submit">Thêm vào giỏ</button>
            </form>
        </div>
        <c:if test="${status.index % 4 == 3}">
            <div style="clear: both;"></div>
        </c:if>
    </c:forEach>
</div>
<jsp:include page="/WEB-INF/views/common/float-contact.jsp"/>

</body>
<script>
    function addToCart(event, productId, productName, productPrice, productImage) {
        event.preventDefault();
        fetch('/shop/add-to-cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ 
                productId: productId,
                name: productName,
                price: parseFloat(productPrice),
                quantity: 1,
                image: productImage
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                fetchCartItems(); // Update cart UI
            } else {
                alert('Thêm vào giỏ hàng thất bại');
            }
        });
    }

    // Định nghĩa hàm fetchCartItems
    function fetchCartItems() {
        fetch('/shop/get-cart')
            .then(response => response.json())
            .then(data => {
                updateCartUI(data.cart);
            });
    }

    function updateCartUI(cart) {
        console.log('Cart:', cart);
        const cartItemsList = document.querySelector('.cart-items-list');
        const cartTotal = document.querySelector('.cart-total');
        const cartCount = document.querySelector('.cart-count');

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

    // Initial fetch
    fetchCartItems();
</script>
</html>
