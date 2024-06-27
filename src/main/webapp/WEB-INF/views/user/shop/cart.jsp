<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
</head>
<body>
<h2>Your Cart</h2>
<c:if test="${empty cart}">
    <p>Your cart is empty</p>
</c:if>
<c:if test="${not empty cart}">
    <c:forEach items="${cart}" var="product">
        <div>
            <h3>${product.name}</h3>
            <p>Price: ${product.price}</p>
            <p>Quantity: ${product.quantity}</p>
            <c:forEach items="${product.images}" var="image">
                <img src="${image.url}" style="width: 100px;">
            </c:forEach>
        </div>
    </c:forEach>
    <form action="/checkout" method="post">
        <button type="submit">Checkout</button>
    </form>
</c:if>
<a href="/products">Back to Products</a>
</body>
</html>
