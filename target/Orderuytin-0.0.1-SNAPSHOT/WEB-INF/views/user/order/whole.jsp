<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <nav class="main-nav--bg" style="background-color: black">
            <div class="container main-nav">
                <div class="main-nav-start">
                    <form  action="/user/search/searchOrder" method="post">
                        <div class="search-wrapper" style="display:flex;flex-direction:row">
                            <i data-feather="search" aria-hidden="true"></i>
                            <input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng qua miêu tả sản phẩm !!! ..." required>
                            <button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;boder-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
                        </div>
                    </form>
                </div>
                <div class="main-nav-end">
                    <button class="sidebar-toggle transparent-btn" class="mainnavIcon" title="Menu" type="button">
                        <span class="sr-only">Toggle menu</span>
                        <span class="icon menu-toggle--gray" aria-hidden="true"></span>
                    </button>

                    <div style="color:white;font-size:35px" >
                        <a href="/user/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
                    </div>

                    <div style="color:white;font-size:35px" ><a href="/user/home"><i class="fa-solid fa-house-user"></i> </a> </div>
                    <div style="color:white;">
                        <a href="/user/item/cart">
                            <p style="color:red;font-size:15px;float:right">${countCartItem}</p> <i style="font-size:35px" class="fa-solid fa-cart-shopping"></i>
                        </a>
                    </div>

                    <div >
                        <!-- Add a logout button -->
                        <form:form action="/logout"   method="POST">
                            <button type="submit"  style="color:white;background-color:black;font-size:35px"><i class="fa-solid fa-right-from-bracket"></i></button>
                        </form:form>
                    </div>
                </div>
            </div>
            <div style="display:flex;flex-direction:row;justify-content:space-between;margin:5px;text-align:center;color:white">
                <div>
                    <p style="font-size:15px;float:right">${countWholeOrder}</p> </br><a style="color:yellow;font-size:25px;font-weight:bold" href="/user/order/whole">Tất cả</a>
                </div>
                <div>
                    </br>|</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countPendingOrder}</p>  </br><a style="font-size:15px"  href="/user/order/pending"> Chờ mua </a>
                </div>
                <div>
                    </br> |</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countBoughtOrder}</p></br> <a style="font-size:15px"  href="/user/order/bought"> Đã mua</a>
                </div>
                <div>
                    </br> |</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countDeliveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/deliveried"> Đã phát</a>
                </div>
                <div>
                    </br>|</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countArriveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/arrivered">Về kho </a>
                </div>
                <div>
                    </br> |</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countComplainOrder}</p> </br><a style="font-size:15px"  href="/user/order/complain"> Khiếu nại </a>
                </div>
                <div>
                    </br> |</br>|
                </div>
                <div >
                    <p style="font-size:15px;float:right">${countFinishedOrder}</p></br> <a style="font-size:15px;font-weight:bold"  href="/user/order/finished"> Thành công </a>
                </div>
                <div>
                    </br> |</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countCancelOrder+countCancelItem}</p></br> <a style="font-size:15px"  href="/user/order/cancel"> Đơn huỷ  </a>
                </div>
            </div>
        </nav>

        <!-- ! Main -->
        <div style="padding:10px">
        <main class="main users chart-page" id="skip-target" style="height: 70vh; overflow: scroll">
            <div class="container">
                <div class="row stat-cards">
                    <c:forEach items="${showWholeOrderListofClient}" var="swol" >

                        <c:set var="totalCN" value="${totalCN + swol.totalCN }"></c:set>
                        <c:set var="totalVN" value="${totalVN + swol.totalVN }"></c:set>
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;boder-radius:10px;border-style:solid;border-width: thin;border-color:white">

                        <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                <div >Ngày đặt hàng : </br> <fmt:formatDate value = "${swol.receivedDate}" type = "date"/> </div>
                <div> <a href="detail/${swol.orderNo}" target="_blank" > Click xem </br> <p style="font-weight: bold;color:red">CHI TIỂT </p></a> </div>
            </div>
            <div class="row">
                <c:forEach items="${swol.items}" var="i" >
                    <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                    <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                    <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin:5px">
                </c:forEach >
            <table style="display:none">
                <c:forEach var="wb" items="${swol.waybills}">
                    <c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
                    <c:set var="totalFreightVN" value="${totalFreightVN + wb.freight}"></c:set>
                <tr >
                    <td>${wb.wayBillCode}</td>
                    <td>${wb.freight}</td>
                    <td><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
                    <td>${wb.kg}</td>
                    <td>${wb.cubic}</td>
                    <td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/> </td>
                    <td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
                </tr>
                </c:forEach>
            </table>
            <div style="margin:5px">
                Tổng cước về VN : <fmt:formatNumber value = "${totalFreight}" type = "number"/> đ</br>
                Tổng tiền đơn hàng : <fmt:formatNumber maxFractionDigits="0" value = "${totalFreight+swol.totalVN}" type = "number"/> đ
            </div>
                </div>
        </article>
                        <c:set var="totalFreight" value="0"></c:set>
                        <c:set var="totalItemCN" value="0"></c:set>
                        <c:set var="totalItemVN" value="0"></c:set>
                    </c:forEach>
                </div>
            </div>

        </main>
            <footer class="footer">
                <div class="container footer--flex">
                    <div class="footer-start">
                        <nav aria-label="..." style="width:300px">
                            <ul class="pagination">
                                <div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
                                    <div>
                                        <li class="page-item <c:if test="${page == 1}">disabled</c:if>">
                                            <a class="page-link" href="/user/order/whole?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                                        </li>
                                    </div>
                                <c:forEach begin="1" end="${total}" step="1" var="num">
                                    <div>
                                        <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                        <a class="page-link" href="/user/order/whole?page=${num}&perpage=${perpage}">${num}</a>
                                        </li>
                                    </div>
                                </c:forEach>
                                    <div>
                                        <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                            <a class="page-link" href="/user/order/whole?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                                        </li>
                                    </div>
                                </div>
                            </ul>
                        </nav>
                    </div>
                    <ul class="footer-end">
                        <li><p>Tổng tiền tất cả đơn hàng đã mua ：<fmt:formatNumber value = "${totalVN}" type="number" maxFractionDigits="0"/>đ(<fmt:formatNumber value = "${totalCN}" type="number" maxFractionDigits="0"/>¥)</p> </li>
                        <li><p>Tổng tiền cước về VN ：<fmt:formatNumber value = "${totalFreightVN}" type="number" maxFractionDigits="0"/>đ</p> </li>
                    </ul>
                </div>
            </footer>
    </div>


<!-- Chart library -->
<script src="/plugins/chart.min.js"></script>
<!-- Icons library -->
<script src="/plugins/feather.min.js"></script>
<!-- Custom scripts -->
<script src="/js/script.js"></script>

    </div>
</body>

</html>


