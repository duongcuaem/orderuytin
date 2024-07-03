<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật thông tin người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .form-container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-container h2 {
            text-align: center;
        }
        .form-container label {
            display: block;
            margin: 10px 0 5px;
        }
        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="password"],
        .form-container input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Cập nhật thông tin người dùng</h2>
    <form action="/updateUser" method="post">
        <input type="hidden" name="userId" value="${user.userId}">

        <label for="userName">Tên người dùng:</label>
        <input type="text" id="userName" name="userName" value="${user.userName}" required>

        <label for="socialCode">Mã xã hội:</label>
        <input type="text" id="socialCode" name="socialCode" value="${user.socialCode}" required>

        <label for="rate">Tỷ lệ:</label>
        <input type="number" id="rate" name="rate" value="${user.rate}" required>

        <label for="rateKg">Tỷ lệ theo Kg:</label>
        <input type="number" id="rateKg" name="rateKg" value="${user.rateKg}" required>

        <label for="rateM3">Tỷ lệ theo m³:</label>
        <input type="number" id="rateM3" name="rateM3" value="${user.rateM3}" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" value="${user.address}" required>

        <label for="phone">Số điện thoại:</label>
        <input type="text" id="phone" name="phone" value="${user.phone}" required>

        <label for="role">Vai trò:</label>
        <input type="text" id="role" name="role" value="${user.role}" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${user.email}" required>

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" value="${user.password}" required>

        <label for="rePassword">Nhập lại mật khẩu:</label>
        <input type="password" id="rePassword" name="rePassword" value="${user.rePassword}" required>

        <label for="status">Trạng thái:</label>
        <input type="number" id="status" name="status" value="${user.STATUS}" required>

        <button type="submit">Cập nhật</button>
    </form>
</div>
</body>
</html>
