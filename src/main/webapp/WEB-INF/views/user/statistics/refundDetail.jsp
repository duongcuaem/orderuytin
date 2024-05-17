<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
    <jsp:include page="/WEB-INF/views/commonUsers/mainnav.jsp"></jsp:include>
        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <div style="display:flex;flex-direction:column">
                    <div style="font-size:25px;text-align:center"><p>CHI TIÊT HOÀN TIỀN</p></div>
                </div>
                <form  action="/user/statistics/refundDetailBetween2Days" method="post">
                    <div style="display:flex;flex-direction:column;margin:10px">
                        <div style="justify-content: space-evenly;display:flex;flex-direction:row;margin:10px">
                            <div style="display:flex;flex-direction:column;width:60%">
                                <div > Quý khách chọn ngày muốn truy vấn từ </div>
                                <div> <input type="date" name="startDate" style="width:150px"></div>
                            </div>
                            <div style="display:flex;flex-direction:column;width:40%">
                                <div style="margin: 10px"> đến </div>
                                <div> <input type="date" name="endDate"  value="<%=java.time.LocalDate.now()%>" style="width:150px"></div>
                            </div>
                        </div>
                        <button type="submit"  style="border-radius:5px;background-color:blue;width:100px;height:40px;margin-left:30%;color:red">Truy vấn</button>
                    </div>
                </form>
                <div style="font-size:20px;text-align:center;margin:10px">
                    Từ ngày : <fmt:formatDate value = "${from}" type = "date"/> đến ngày : <fmt:formatDate value = "${to}" type = "date"/>
                </div>

                <div class="row stat-cards">
                    <c:forEach items="${showRefundItemDetailUser}" var="i" >
                        <c:set var="totalRefundItem" value="${totalRefundItem + i.price*i.CNYrateVND*i.quantityRefund}"></c:set>
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">

                        <div style="display:flex;flex-direction:column;">
                            <div style="display:flex;flex-direction:row;">
                                <div style="margin-right:10px">Ngày đặt : <fmt:formatDate type = "date" value = "${i.orders.receivedDate}" /></div>
                                <div >Mã ĐH :<a href="/user/order/detail/${i.orders.orderNo}" target="_blank">${i.orders.orderNo}</a> </div>
                            </div>
                            <div style="display:flex;flex-direction:column">
                                <div style="width:100%;display:flex;flex-direction:row ">
                                    <div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white;display:flex" >
                                    <div style="display:flex;flex-direction:column;height:50%">
                                            <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin:5px">
                                        </div>
                                        <div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:10px">
                                            <div style="width:100%"> <input value="${i.link}" style="width:100px"/></div>
                                            <div style="width:100%">  ${i.describle}</div>
                                            <div style="width:100%"> Giá : ${i.price}</div>
                                            <div style="width:100%"> Số lương : ${i.quantity}</div>
                                            <div style="width:100%"> Tỉ giá : ${i.CNYrateVND}</div>
                                            <div style="width:100%"> <fmt:formatNumber value = " ${i.price*i.quantity}" type = "number"/> ¥ = <fmt:formatNumber value = "${i.price*i.quantity*i.CNYrateVND}" type = "number"/> đ</div>
                                        </div>
                                    </div>
                                </div>
                                <div style="display:flex;flex-direction:column;justify-content: space-between;width:100%;margin-left:10px">
                                    <div style="display:flex;flex-direction:row;width:100%"> Ghi chú   :  ${i.adminNote} </div>
                                    <div style="display:flex;flex-direction:row;width:100%"> Tiền hoàn   :  ${i.price} x <div style="color:#5eff00"> ${i.quantityRefund} </div> x ${i.CNYrateVND} = <fmt:formatNumber value = "${i.price*i.CNYrateVND*i.quantityRefund}" type = "number"/> đ</div>
                                    <div style="width:100%"> Ngày hoàn : <fmt:formatDate value = "${i.refundDate}" type = "date"/></div>
                                </div>
                            </div>
                          </div>
                        </article>
                    </c:forEach>

                    <c:forEach items="${showRefundOrderDetailUser}" var="srodu" >
                        <c:set var="totalRefundOrder" value="${totalRefundOrder + srodu.totalVN}"></c:set>
                        <article class="stat-cards-item" style="margin: 5px">
                            <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                <div style="width:50%;color:red;margin-right:10px">Ngày đặt :<fmt:formatDate type = "date" value = "${srodu.receivedDate}" /></div>
                                <div style="width:50%;color:red">Mã ĐH :${srodu.orderNo} </div>
                            </div>
                        <c:forEach items="${srodu.items}" var="item" >
                            <c:set var="totalItem" value="${totalItem + item.price * item.quantity }"></c:set>
                            <div style="border-radius:10px; background-color:#DADBE4;margin:5px;display:flex;flex-direction:row">
                                <div style="width:30%;">
                                    <img alt="image" src="<c:url value="/image/item/${item.image}" />" style="width:90px;height:150px;margin:5px" >
                                </div>
                                <div style="display:flex;flex-direction:column;justify-content: space-evenly;width:70%">
                                    <div style="margin-left:10px"><input value="${item.link}" style="width:100px"/></div>
                                    <div style="margin-left:10px">${item.describle}</div>
                                    <div style="margin-left:10px">Giá trị   : ${item.price} ¥</div>
                                    <div style="margin-left:10px">Số lượng  : ${item.quantity}</div>
                                    <div style="margin-left:10px">Tỉ giá  : ${item.CNYrateVND}</div>
                                </div>
                            </div>
                        </c:forEach >
                            <div style="display:flex;flex-direction:column">
                                <div style="display:flex;flex-direction:row;margin:2px"><p>Ship nội địa : <fmt:formatNumber value = "${srodu.shipFeeCNY}" type = "number"/> ¥  ~~ <fmt:formatNumber value = "${srodu.shipFeeVND}" type = "number"/> đ</div>
                                <div style="display:flex;flex-direction:row;margin:2px"><p>Tiền hoàn : <fmt:formatNumber value = "${srodu.totalVN}" type = "number"/> đ</div>
                                <div style="display:flex;flex-direction:row;margin:2px"><p>Ngày hoàn :<fmt:formatDate value = "${srodu.cancelDate}" type = "date"/></div>
                            </div>
                        </article>

                    </c:forEach>
                </div>
            </div>
            <div style="color:red"><p>Tổng tiền ：  <fmt:formatNumber value = "${totalRefundItem+totalRefundOrder}" type="number"/> đ</p></div>

        </main>

        <jsp:include page="/WEB-INF/views/commonUsers/footer.jsp"></jsp:include>
    </div>


    <!-- Chart library -->
    <script src="/plugins/chart.min.js"></script>
    <!-- Icons library -->
    <script src="/plugins/feather.min.js"></script>
    <!-- Custom scripts -->
    <script src="/js/script.js"></script>

</body>

</html>
