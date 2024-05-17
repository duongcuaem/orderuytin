<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
        <jsp:include page="/WEB-INF/views/common/mainnavSearchOrder.jsp"></jsp:include>
        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="height: 80vh; overflow: scroll">
            <div class="container">
                <div class="row stat-cards">
                    <c:forEach items="${showWholeOrderList}" var="swol" >
                        <c:set var="totalCN" value="${totalCN + swol.totalCN }"></c:set>
                        <c:set var="totalVN" value="${totalVN + swol.totalVN }"></c:set>
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

                        <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                <div > <fmt:formatDate value = "${swol.receivedDate}" type = "date"/> </br> ${swol.orderNo} </div>
                                <div style="margin-left:10%"> ${swol.orderStatus}</br>${swol.orderUserName} </div>
                            </div>
                            <div class="row">
                                <c:forEach items="${swol.items}" var="i" >
                                  <div style="border-radius:10px;display:flex;flex-direction:column; background-color:#DADBE4;margin:5px">
                                    <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                                    <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                    <div style="margin:5px;display:flex;flex-direction:row">
                                        <div >
                                            <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin:5px">
                                        </div>
                                        <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                            <div style="width:100%;color:black"> <a href="${i.link}"> Link :</a> <input type="text" style="width:80px" value="${i.link}" /></div>
                                            <div style="width:100%;color:black"> ${i.describle}</div>
                                            <div style="width:100%;color:black">  <fmt:formatNumber value = "${i.price}" type="number"/> ¥ x ${i.quantity}</div>
                                            <div style="width:100%;color:black"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                            <div style="width:100%;color:black"> x ${i.CNYrateVND}  ¥/đ</div>
                                            <div style="width:100%;color:black"> = <fmt:formatNumber value = "${i.quantity*i.price*i.CNYrateVND}" maxFractionDigits="0"  type="number"/> đ</div>
                                        </div>
                                    </div>
                                    <div style="display:flex;flex-direction:column;justify-content: space-between;width:100%;margin:5px">
                                        <div style="display:flex;flex-direction:row;width:100%;color:red"> Khiếu nại :  ${i.userNote} </div>
                                        <div style="display:flex;flex-direction:row;width:100%;color:red"> Phản hồi  :  ${i.adminNote} </div>
                                        <div style="display:flex;flex-direction:row;width:100%;color:red"> Tiền hoàn : <fmt:formatNumber value = "${i.price*i.CNYrateVND*i.quantityRefund}" type ="number"/> đ</div>
                                        <div style="width:100%;color:red"> Ngày hoàn : <fmt:formatDate   value = "${i.refundDate}"  type ="date"/></div>
                                    </div>
                                  </div>
                                </c:forEach >
                                    <div style="margin:3px;width:100%">
                                        <table>
                                            <tr>
                                                <th>运单号</th>
                                                <th>收到日</th>
                                                <th>Kg</th>
                                                <th>m3</th>
                                                <th>Kg汇率</th>
                                                <th>M3汇率</th>
                                                <th>小计</th>
                                            </tr>
                                            <c:forEach var="wb" items="${swol.waybills}">
                                                <c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
                                                <c:set var="totalFreightVN" value="${totalFreightVN + wb.freight}"></c:set>
                                            <tr >
                                                <td>${wb.wayBillCode}</td>
                                                <td><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
                                                <td>${wb.kg}</td>
                                                <td>${wb.cubic}</td>
                                                <td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/> </td>
                                                <td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
                                                <td><fmt:formatNumber value = "${wb.freight}" type = "number"/></td>
                                            </tr>
                                            </c:forEach>
                                            <tr style="color:red">
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>运费合计</td>
                                                <td><fmt:formatNumber value = "${totalFreight}" type = "number"/></td>
                                            </tr>
                                        </table>
                                    </div>
                                <div style="display:flex;flex-direction:column;width:100%;color:red">
                                    <div style="display:flex;flex-direction:row;margin:2px">
                                        <div style="width:40%">	<p>商品总价</p></div>
                                        <div><p>  <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥(<fmt:formatNumber value = "${totalItemVN}" maxFractionDigits="0"  type = "number"/> đ)</p></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin:2px">
                                        <div style="width:40%">	<p>运费 </p></div>
                                        <div style="text-align:center"><p>  <fmt:formatNumber value = "${swol.shipFeeCNY}" type = "number"/> ¥(<fmt:formatNumber value = "${swol.shipFeeVND}" type = "number"/> đ)</p></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin:2px">
                                        <div style="width:40%">	<p>合计 </p></div>
                                        <div><p>  <fmt:formatNumber value = "${swol.totalCN}" type = "number"/> ¥(<fmt:formatNumber value = "${swol.totalVN}" type = "number"/> đ)</p></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin:2px">
                                        <div style="width:40%">	<p>总共 </p></div>
                                        <div><fmt:formatNumber value = "${swol.totalVN+totalFreight}" type = "number"/></div>
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
                    <nav aria-label="..." style="width:100%">
                        <ul class="pagination">
                            <div style="display:flex;flex-direction:row;width:100%">
                                <div>
                                    <li class="page-item <c:if test="${page == 1}">disabled</c:if>">
                                        <a class="page-link" href="/backend/order/whole?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                                    </li></div>
                                <c:forEach begin="1" end="${total}" step="1" var="num">
                                    <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                        <a class="page-link" href="/backend/order/whole?page=${num}&perpage=${perpage}">${num}</a>
                                    </li></div>
                                </c:forEach>
                                <div>
                                    <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                        <a class="page-link" href="/backend/order/whole?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                                    </li></div>
                            </div>
                        </ul>
                    </nav>
                </div>
                <ul class="footer-end">
                    <li><div style="color:red"><p>全部订单总额 ：<fmt:formatNumber value = "${totalCN}" type="number"/>¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalVN}" type="number"/>đ)</p></div></li>
                    <li>合计： <fmt:formatNumber maxFractionDigits="2" value = "${totalCN}" type="number"/>¥ </li>
                    <li> <div style="color:red"><p>运费总额 ：   <fmt:formatNumber value = "${totalFreightVN}" type="number"/>đ</p></div>
                    </li>
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


