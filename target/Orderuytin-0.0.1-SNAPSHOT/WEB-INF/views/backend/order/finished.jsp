<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <nav class="main-nav--bg" style="background-color: black">
            <div class="container main-nav">
                <div class="main-nav-start">
                    <form  action="/backend/search/searchOrder" method="post">
                        <div class="search-wrapper" style="display:flex;flex-direction:row">
                            <i data-feather="search" aria-hidden="true"></i>
                            <input type="text" name="search" placeholder="Bạn muốn tìm kiếm gì? ..." required>
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
                        <a href="/backend/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
                    </div>
                    <div style="color:white;font-size:35px" >
                        <a href="/backend/user/userList"><i class="fa-solid fa-users" aria-hidden="true" "></i></a>
                    </div >
                    <div style="color:white;font-size:35px" >
                        <a href="/backend/chargMoney/chargForm"><i class="fa-solid fa-money-check-dollar"></i></a>
                    </div>
                    <div style="color:white;font-size:35px" ><a href="/backend/home"><i class="fa-solid fa-house-user"></i> </a> </div>
                    <div style="color:white;">
                        <a href="/backend/item/cart">
                            <p style="color:red;font-size:15px;float:right">${countCartItemAdmin}</p> <i style="font-size:35px" class="fa-solid fa-cart-shopping"></i>
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
                    <p style="font-size:15px;float:right">${countFixOrderAdmin}</p></br> <a style="font-size:15px" href="/backend/order/fix">改单</a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countPendingOrderAdmin}</p>  </br><a style="font-size:15px"  href="/backend/order/pending"> 等买 </a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countBoughtOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/bought"> 已买</a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countDeliveredOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/deliveried"> 已发</a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countArriveredOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/arrivered">已到 </a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countComplainOrderAdmin}</p> </br><a style="font-size:15px"  href="/backend/order/complain"> 投诉 </a>
                </div>
                <div>
                    </br>|
                </div>
                <div >
                    <p style="font-size:15px;float:right">${countFinishedOrderAdmin}</p></br> <a style="color:yellow;font-size:25px;font-weight:bold"  href="/backend/order/finished">成功</a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countCancelOrderAdmin+countCancelItemAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/cancel">取消 </a>
                </div>
            </div>
        </nav>

        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
            <div class="container">
                <div style="display:flex;flex-direction:column">
                    <div><p style="color: red">${message}</p></div>
                </div>
                <div class="row stat-cards">
                    <c:forEach items="${showFinishedOrderList}" var="sfol" >
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

                        <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                <div > <fmt:formatDate value = "${sfol.receivedDate}" type = "date"/></div>
                                <div > ${sfol.orderNo}</br>${sfol.orderUserName}  </div>
                            </div>
                            <div class="row">
                                <c:forEach items="${sfol.items}" var="i" >
                                    <c:set var="totalQuantity" value="${totalQuantity + i.quantity }"></c:set>
                                    <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                                    <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                    <c:set var="totalCN" value="${totalCN + i.price * i.quantity }"></c:set>
                                    <c:set var="totalVN" value="${totalVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                <div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:column;margin:2px">
                                   <div style="margin:5px;display:flex;flex-direction:row">
                                        <div >
                                            <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin:5px">
                                        </div>
                                        <div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:20px">
                                            <div style="width:100%"><a href="${i.link}"> 链接 </a> <input type="text" style="width:80px" value="${i.link}" /></div>
                                            <div style="width:100%"> ${i.describle}</div>
                                            <div style="width:100%"> ${i.price} ¥ x ${i.quantity}</div>
                                            <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                            <div style="width:100%"> x ${i.CNYrateVND}  đ/¥</div>
                                            <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                                        </div>
                                   </div>
                                   <div style="display:flex;flex-direction:column;justify-content: space-between;width:100%;margin:5px">
                                        <div style="display:flex;flex-direction:row;width:100%"> 投诉  ${i.userNote} </div>
                                        <div style="display:flex;flex-direction:row;width:100%"> 反馈  ${i.adminNote} </div>
                                        <div style="display:flex;flex-direction:row;width:100%"> 退款  <fmt:formatNumber value = "${i.price*i.CNYrateVND*i.quantityRefund}" type = "number"/> đ</div>
                                        <div style="width:100%"> 退款时间 <fmt:formatDate value = "${i.refundDate}" type = "date"/></div>
                                   </div>
                                </div>
                                </c:forEach >

                            </div>
                                <div style="margin:3px;width:100%">
                                    <table>
                                        <tr>
                                            <th>运单号</th>
                                            <th>小计</th>
                                            <th>收到日</th>
                                            <th>Kg</th>
                                            <th>M3</th>
                                            <th>Kg 汇率</th>
                                            <th>M3 汇率</th>
                                        </tr>
                                        <c:forEach var="wb" items="${sfol.waybills}">
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
                                        <tr >
                                            <td>运费合计</td>
                                            <td><fmt:formatNumber value = "${totalFreight}" type = "number"/></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>

                            <div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px;width:100%">
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">数量总计 </div>
                                    <div ><p>${totalQuantity}</p></div>
                                </div>
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">商品总价</div>
                                    <div ><p> <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN}" type = "number"/> đ)</p></div></div>
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">运费 </div>
                                    <div ><p> <fmt:formatNumber value = "${sfol.shipFeeCNY}" type = "number"/> ¥(<fmt:formatNumber maxFractionDigits="0" value = "${sfol.shipFeeVND}" type = "number"/> đ)</p></div></div>
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">合计 </div>
                                    <div ><p> <fmt:formatNumber value = "${sfol.totalCN}" type = "number"/> ¥(<fmt:formatNumber maxFractionDigits="0" value = "${sfol.totalVN}" type = "number"/> đ)</p></div></div>
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">总共 </div>
                                    <div ><p><fmt:formatNumber value = "${sfol.totalVN+totalFreight}" type = "number"/></div></div>
                            </div>
                        </article>
                        <c:set var="totalQuantity" value="0"></c:set>
                        <c:set var="totalFreight" value="0"></c:set>
                        <c:set var="totalItemCN" value="0"></c:set>
                        <c:set var="totalItemVN" value="0"></c:set>
                    </c:forEach>
                    <article class="stat-cards-item" style="margin: 5px">
                        <div style="font-size:30px;text-align:center;margin:3px;width:100%">
                            <p >ĐƠN HÀNG KI GỬI</p>
                        </div>
                        <div style="margin:3px;width:100%">
                            <table>
                                <tr>
                                    <th></th>
                                    <th>运单号</th>
                                    <th>客户</th>
                                    <th>收到日</th>
                                    <th>Kg</th>
                                    <th>m3</th>
                                    <th>KG汇率</th>
                                    <th>M3 汇率</th>
                                    <th>合计</th>
                                </tr>
                                <c:forEach items="${showKGHTwaybillsListofAdMin}" var="wbKG" >
                                    <c:set var="totalFreightKG" value="${totalFreightKG + wbKG.freight}"></c:set>
                                <tr >
                                    <td><a href="/backend/wayBill/remove/${wbKG.wayBillId}" >取消</a></td>
                                    <td>${wbKG.wayBillCode}</td>
                                    <td>${wbKG.wbUserName}</td>
                                    <td><fmt:formatDate value = "${wbKG.arriveredDate}" type = "date"/></td>
                                    <td><fmt:formatNumber value = "${wbKG.kg}" type = "number"/></td>
                                    <td><fmt:formatNumber value = "${wbKG.cubic}" type = "number"/></td>
                                    <td><fmt:formatNumber value = "${wbKG.rateKg}" type = "number"/> </td>
                                    <td><fmt:formatNumber value = "${wbKG.rateCubic}" type = "number"/></td>
                                    <td>${wbKG.freight}</td>
                                </tr>
                                </c:forEach>
                                <tr style="color:red">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>合计</td>
                                    <td><fmt:formatNumber value = "${totalFreightKG}" type = "number"/></td>
                                </tr>
                            </table>
                        </div>
                    </article>
                </div>
            </div>
        </main>

        <footer class="footer">
            <div class="container footer--flex">
                <div class="footer-start">
                    <nav aria-label="..." style="width:400px">
                        <ul class="pagination">
                            <div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
                                <div>
                                    <li class="page-item <c:if test="${page == 1}">disabled</c:if>">
                                        <a class="page-link" href="/backend/order/finished?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                                    </li></div>
                                <c:forEach begin="1" end="${total}" step="1" var="num">
                                    <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                        <a class="page-link" href="/backend/order/finished?page=${num}&perpage=${perpage}">${num}</a>
                                    </li></div>
                                </c:forEach>
                                <div>
                                    <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                        <a class="page-link" href="/backend/order/finished?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                                    </li></div>
                            </div>
                        </ul>
                    </nav>
                </div>
                <ul class="footer-end">
                    <li><p>收到订单总额 ： <fmt:formatNumber maxFractionDigits="0" value = "${totalCN}" type="number"/>¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalVN}" type="number"/>đ)</p> </li>
                    <li><p>运费总额 ：<fmt:formatNumber maxFractionDigits="0" value = "${totalFreightVN+totalFreightKG}" type="number"/>đ</p></li>
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

</body>

</html>
