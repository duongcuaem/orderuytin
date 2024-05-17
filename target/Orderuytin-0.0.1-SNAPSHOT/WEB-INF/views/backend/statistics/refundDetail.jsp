 <%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <div style="color: #5eff00;font-size:40px;text-align:center">CHI TIẾT HOÀN TIỀN</div>
                <form  action="/user/statistics/refundDetailBetween2Days" method="post">
                    <div  style="justify-content: space-evenly;display:flex;flex-direction:row;margin:10px">
                        <div> <input type="date" name="startDate" style="width:150px"></div>
                        <div> <input type="date" name="endDate"  value="<%=java.time.LocalDate.now()%>" style="width:150px"></div>
                        <button type="submit"  style="border-radius:5px;background-color:blue;width:100px;color:#5eff00;margin-left:10px">Truy vấn</button>
                    </div>
                </form>
                <div style="font-size:20px;text-align:center;margin: 10px">
                    Từ ngày : <fmt:formatDate value = "${from}" type = "date"/> đến ngày : <fmt:formatDate value = "${to}" type = "date"/>
                </div>

                <div class="row stat-cards">
                    <c:forEach items="${showRefundItemDetail}" var="i" >
                        <c:set var="totalRefundItem" value="${totalRefundItem + i.price*i.CNYrateVND*i.quantityRefund}"></c:set>
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">
                            <div style="display:flex;flex-direction:column;">
                                <div style="display:flex;flex-direction:row">
                                    <div style="margin-right:10px"> <fmt:formatDate type = "date" value = "${i.orders.receivedDate}" /></div>
                                    <div style="margin-right:10px">${i.orders.orderNo} </div>
                                    <div > ${i.itemUserName} </div>
                                </div>
                                <div style="display:flex;flex-direction:column">
                                    <div style="width:100%;display:flex;flex-direction:row ">
                                        <div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white;display:flex" >
                                        <div style="display:flex;flex-direction:column;width:30%;height:50%">
                                                <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin:5px">
                                            </div>
                                            <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                                <div style="width:100%"> <input type="text" style="width:80px" value="${i.link}" /></div>
                                                <div style="width:100%">  ${i.describle}</div>
                                                <div style="width:100%">  ${i.price} ¥ x ${i.quantity}</div>
                                                <div style="width:100%">  = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                                <div style="width:100%">  x ${i.CNYrateVND}  ¥/đ</div>
                                                <div style="width:100%">  = <fmt:formatNumber value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="display:flex;flex-direction:column;justify-content: space-between;width:100%;margin:10px">
                                        <div style="display:flex;flex-direction:row;width:100%;color:red"> Ghi chú   :  ${i.adminNote} </div>
                                        <div style="display:flex;flex-direction:row;width:100%;color:red"> Tiền hoàn   :  ${i.price} x <div style="color:#5eff00"> ${i.quantityRefund} </div> x ${i.CNYrateVND} = <fmt:formatNumber value = "${i.price*i.CNYrateVND*i.quantityRefund}" type = "number"/> đ</div>
                                        <div style="width:100%;color:red"> Ngày hoàn : <fmt:formatDate value = "${i.refundDate}" type = "date"/></div>
                                    </div>
                                </div>
                            </div>
                        </article>
                    </c:forEach>

                    <c:forEach items="${showRefundOrderDetail}" var="srod" >
                        <c:set var="totalRefundOrder" value="${totalRefundOrder + srod.totalVN}"></c:set>
                        <article class="stat-cards-item" style="margin: 5px">
                            <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                <div style="width:50%;color:red;margin-right:10px"><fmt:formatDate type = "date" value = "${srod.receivedDate}" /></div>
                                <div style="width:50%;color:red">${srod.orderNo} </div>
                                <div style="width:50%;color:red">${srod.orderUserName} </div>
                            </div>
                            <c:forEach items="${srod.items}" var="item" >
                                <c:set var="totalItem" value="${totalItem + item.price * item.quantity }"></c:set>
                                <div style="border-radius:10px; background-color:#DADBE4;margin:5px;display:flex;flex-direction:row">
                                    <div style="width:30%;">
                                        <img alt="image" src="<c:url value="/image/item/${item.image}" />" style="width:90px;height:150px;margin:5px" >
                                    </div>
                                    <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                        <div style="width:100%;color:black"> <input type="text" style="width:80px" value="${item.link}" /></div>
                                        <div style="width:100%;color:black"> ${item.describle}</div>
                                        <div style="width:100%;color:black">${item.price} ¥ x ${item.quantity}</div>
                                        <div style="width:100%;color:black"> = <fmt:formatNumber value = "${item.quantity*item.price}" type = "number"/> ¥ </div>
                                        <div style="width:100%;color:black"> x ${item.CNYrateVND}  ¥/đ</div>
                                        <div style="width:100%;color:black"> = <fmt:formatNumber value = "${item.quantity*item.price*item.CNYrateVND}" type = "number"/> đ</div>
                                    </div>
                                </div>
                            </c:forEach >
                            <div style="display:flex;flex-direction:column;color:red">
                                <div style="display:flex;flex-direction:row;margin:2px"><p>Ship nội địa : <fmt:formatNumber value = "${srod.shipFeeCNY}" type = "number"/> ¥  ~~ <fmt:formatNumber value = "${srod.shipFeeVND}" type = "number"/> đ</div>
                                <div style="display:flex;flex-direction:row;margin:2px"><p>Tiền hoàn : <fmt:formatNumber value = "${srod.totalVN}" type = "number"/> đ</div>
                                <div style="display:flex;flex-direction:row;margin:2px"><p>Ngày hủy :<fmt:formatDate value = "${srod.cancelDate}" type = "date"/></div>
                            </div>
                        </article>

                    </c:forEach>
                </div>
            </div>
            <div style="color:red"><p>合计 ：  <fmt:formatNumber maxFractionDigits="0" value = "${totalRefundItem+totalRefundOrder}" type="number"/> đ</p></div>

        </main>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>


    <!-- Chart library -->
    <script src="/plugins/chart.min.js"></script>
    <!-- Icons library -->
    <script src="/plugins/feather.min.js"></script>
    <!-- Custom scripts -->
    <script src="/js/script.js"></script>

</body>

</html>
