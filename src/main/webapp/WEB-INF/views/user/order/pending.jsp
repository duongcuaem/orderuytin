<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){
            function setTwoNumberDecimal(event) {
                this.value = parseFloat(this.value).toFixed(2);
            }
        });
    </script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
    <div class="main-wrapper" >
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
                    <p style="font-size:15px;float:right">${countWholeOrder}</p> </br><a style="font-size:15px;" href="/user/order/whole">Tất cả</a>
                </div>
                <div>
                    </br>|</br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countPendingOrder}</p>  </br><a style="color:yellow;font-size:25px;font-weight:bold"  href="/user/order/pending"> Chờ mua </a>
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
                    <p style="font-size:15px;float:right">${countFinishedOrder}</p></br> <a style="font-size:15px"  href="/user/order/finished"> Thành công </a>
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
        <main class="main users chart-page" id="skip-target" style="height: 70vh; overflow: scroll">
            <div class="container" >
                <div class="row stat-cards">
        <c:forEach items="${showPendingListofClient}" var="i" >
            <c:set var="totalItemCN" value="${totalItem + i.price * i.quantity }"></c:set>
            <c:set var="totalItemVN" value="${totalItem + i.price * i.quantity*i.CNYrateVND }"></c:set>
            <c:set var="totalCN" value="${totalCN + i.price * i.quantity }"></c:set>
            <c:set var="totalVN" value="${totalVN + i.price * i.quantity*i.CNYrateVND }"></c:set>

                    <div class="col-md-6 col-xl-3">
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;boder-radius:10px;border-style:solid;border-width: thin;border-color:white">
                            <div style="display:flex;flex-direction:row">
                                <div style="width:30%;">
                                    <div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                                </div>
                                <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:10px">
                                    <div style="width:100%"><a href="${i.link}"> Click Link :</a>  <input type="text" style="width:100px" name="link"  value="${i.link}"  path="link" /></div>
                                    <div style="width:100%"> ${i.describle}</div>
                                    <div style="width:100%"> Giá : ${i.price} ¥</div>
                                    <div style="width:100%"> Số lượng : ${i.quantity}</div>
                                    <div style="width:100%"> Tỉ giá : ${i.CNYrateVND} đ/¥</div>
                                    <div style="width:100%"> Thành tiền : </div>
                                    <div style="width:100%"><fmt:formatNumber type="number" maxFractionDigits="2" value="${i.quantity*i.price*i.CNYrateVND}" />đ(<fmt:formatNumber type="number" maxFractionDigits="2" value="${i.price*i.quantity}" /> ¥)</div>
                                </div>
                            </div>
                        </article>
                    </div>
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
                                        <a class="page-link" href="/user/order/pending?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                                    </li></div>
                                <c:forEach begin="1" end="${total}" step="1" var="num">
                                    <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                        <a class="page-link" href="/user/order/pending?page=${num}&perpage=${perpage}">${num}</a>
                                    </li></div>
                                </c:forEach>
                                <div>
                                    <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                        <a class="page-link" href="/user/order/pending?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                                    </li></div>
                            </div>
                        </ul>
                    </nav>
                </div>
                <ul class="footer-end">
                    <li><p>Tổng tiền hàng chờ xử lý ： <fmt:formatNumber value = "${totalCN}" type="number" maxFractionDigits="2"/>¥</p> </li>
                    <li><p><fmt:formatNumber value = "${totalVN}" type="number" maxFractionDigits="0"/>đ</p></li>
                </ul>
            </div>
        </footer>
    </div>
</div>


<!-- Chart library -->
<script src="/plugins/chart.min.js"></script>
<!-- Icons library -->
<script src="/plugins/feather.min.js"></script>
<!-- Custom scripts -->
<script src="/js/script.js"></script>

</body>

</html>


