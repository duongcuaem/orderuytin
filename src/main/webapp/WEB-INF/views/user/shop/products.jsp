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
    </style>
</head>
<body>
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
            <form action="/add-to-cart" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <button type="submit">Thêm vào giỏ</button>
            </form>
        </div>
        <c:if test="${status.index % 4 == 3}">
            <div style="clear: both;"></div>
        </c:if>
    </c:forEach>
</div>
</body>
</html>
