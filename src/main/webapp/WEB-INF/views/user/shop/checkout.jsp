<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
        }
        .cart-summary {
            margin-bottom: 20px;
        }
        .cart-summary table {
            width: 100%;
            border-collapse: collapse;
        }
        .cart-summary th, .cart-summary td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .cart-summary th {
            background-color: #f2f2f2;
        }
        .cart-summary img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
        .total {
            text-align: right;
            font-weight: bold;
            margin-top: 20px;
        }
        .checkout-form {
            margin-top: 20px;
        }
        .checkout-form label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .checkout-form input, .checkout-form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .checkout-form button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 15px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        .checkout-form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Trang Thanh Toán</h1>
        </div>
        <div class="cart-summary">
            <h2>Thông tin giỏ hàng</h2>
            <table>
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cart}" var="item">
                        <tr>
                            <td>
                                <img src="${item.image}" alt="${item.name}">
                                ${item.name}
                            </td>
                            <td>${item.price}</td>
                            <td>${item.quantity}</td>
                            <td>${item.price * item.quantity}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="total">
                Tổng cộng: $<c:out value="${total}"/>
            </div>
        </div>
        <div class="checkout-form">
            <h2>Thông tin thanh toán</h2>
            <form action="/complete-checkout" method="post">
                <label for="name">Họ và tên:</label>
                <input type="text" id="name" value="${user.userName}" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" value="${user.email}" name="email" required>

                <label for="address">Địa chỉ:</label>
                <input type="text" id="address" value="${user.address}" name="address" required>
                
                <button type="submit">Hoàn tất thanh toán</button>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/float-contact.jsp"/>
</body>
</html>
