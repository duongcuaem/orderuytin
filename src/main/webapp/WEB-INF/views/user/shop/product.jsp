<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
</head>
<body>
<h2>${product.name}</h2>
<p>Price: ${product.price}</p>
<p>Type: ${product.type}</p>
<p>Quantity: ${product.quantity}</p>
<c:forEach items="${product.images}" var="image">
    <img src="${image.url}" style="width: 100%;">
</c:forEach>
<form action="/add-to-cart" method="post">
    <input type="hidden" name="productId" value="${product.id}">
    <button type="submit">Add to Cart</button>
</form>
<a href="/products">Back to Products</a>
</body>
</html>
