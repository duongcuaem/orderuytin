<%@ page import="com.mrChill.Relax.Service.UsersService" %>
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
                            <input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng ở đây ..." required>
                            <button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
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
                    <p style="font-size:15px;float:right">${countFinishedOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/finished">成功</a>
                </div>
                <div>
                    </br>|
                </div>
                <div>
                    <p style="font-size:15px;float:right">${countCancelOrderAdmin+countCancelItemAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/cancel">取消 </a>
                </div>
            </div>
        </nav>

        <div style="padding:10px">

            <!-- ! Main -->
            <main class="main users chart-page" id="skip-target">
                <div class="container">
                    <div class="row stat-cards">
                        <p style="color: red">${message}</p>
                        <c:forEach items="${showOrderList}" var="sol" >
                            <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
                                <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                    <div >  <fmt:formatDate value = "${sol.receivedDate}" type = "date"/></div>
                                    <div >  ${sol.orderNo}  </br>${sol.orderUserName}     </div>
                                </div>
      <form:form method="post" action="/backend/wayBill/saveWayBill" modelAttribute="wayBillDAO">

          <div style="display: none">
            <input type="text"  name="orderUserName"  value="${sol.orderUserName}"   path="orderUserName" />
            <input type="text"  name="receivedDate"   value="${sol.receivedDate}"    path="receivedDate" />
            <input type="text"  name="orderId"        value="${sol.orderId}"         path="orderId" />
            <input type="text"  name="totalVN"        value="${sol.totalVN}"         path="totalVN" />
            <input type="text"  name="orderNo"        value="${sol.orderNo}"         path="orderNo" />
            <input type="text"  name="totalCN"        value="${sol.totalCN}"         path="totalCN" />
            <input type="text"  name="shipFeeCNY"     value="${sol.shipFeeCNY}"      path="shipFeeCNY" />
            <input type="text"  name="shipFeeVND"     value="${sol.shipFeeVND}"      path="shipFeeVND" />
            <input type="text"  name="wbUserName"     value="${sol.orderUserName}"   path="wbUserName" />
            <input type="text"  name="type"           value="DH"                     path="type" />
     </div>
        <div style="display:flex;flex-direction:row;justify-content: space-between;mararrivergin:10px">
            <div style="display:flex;flex-direction:column" >
                <div style="margin:5px"> <input type="text" name="wayBillCode"  placeholder="Hãy điền mã vận đơn"  path="wayBillCode"/>
                    <div style="color:#00ff15"><form:errors cssClass="error" path="wayBillCode"></form:errors></div>
                </div>
                <div style="margin:5px">
                <select name="orderStatus" path="orderStatus">
                    <option value="Da phat hang">Đã phát hàng</option>
                    <option value="Da mua hang">Đã mua hàng</option>
                    <option value="Da ve kho">Đã về kho</option>
                    <option value="Khieu nai">Khiếu nại</option>
                    <option value="Sua don">Chỉnh sửa đơn</option>
                    <option value="Thanh cong">Thành công</option>
                    <option value="Huy">Hủy</option>
                </select>
          ${sol.orderStatus}
               </div>
               <div > <input type="submit" class="form-btn primary-default-btn" value="Cập nhật" /> </div>
            </div>
        </div>

      </form:form>
        <div style="width:100%;margin:5px">
            <div style="margin:3px;width:100%">
                <table>
                    <tr>
                        <th>运单号</th>
                        <th>收到日</th>
                        <th>小计</th>
                        <th>Kg</th>
                        <th>m3</th>
                        <th>Kg汇率</th>
                        <th>M3 汇率</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${sol.waybills}" var="wb" >
                        <c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
                    <tr style="color: #5eff00">
                        <td>${wb.wayBillCode}</td>
                        <td><fmt:formatDate type = "date" value = "${wb.arriveredDate}" /></td>
                        <td><fmt:formatNumber value = "${wb.freight}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
                        <td><a href="/backend/wayBill/remove/${wb.wayBillId}" style="color:#ff0015">取消</a></td>
                    </tr>
                    </c:forEach>
                    <tr>
                        <td>运费合计</td>
                        <td><fmt:formatNumber value = "${totalFreight}" type = "number"/></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <th></th>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row">
        <c:forEach items="${sol.items}" var="i" >
            <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
            <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
            <div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:row;margin:2px">
            <div style="display:flex;flex-direction:column;width:30%;">
                    <div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                    <input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
                </div>
                <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                    <div style="width:100%"> <input type="text" style="width:80px" value="${i.link}" />   <a style="color:red;float:right"  href="/backend/item/detail/${i.itemId}">编辑</a></div>
                    <div style="width:100%"> ${i.describle}</div>
                    <div style="width:100%"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                    <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                    <div style="width:100%"> x ${i.CNYrateVND} đ/¥</div>
                    <div style="width:100%"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                    <div style="width:100%;display:flex;flex-direction:row;color:red">投诉 <p >${i.userNote}</p></div>
                    <div style="width:100%;display:flex;flex-direction:row">反馈 <p >${i.adminNote}</p></div>
                    <div style="width:100%;display:flex;flex-direction:row">退款 <p ><fmt:formatNumber maxFractionDigits="0" value = "${i.quantityRefund*i.price*i.CNYrateVND}" type = "number"/> đ </p></div>
                    <div style="width:100%;display:flex;flex-direction:row">退款时间 <p ><fmt:formatDate value = "${i.refundDate}" type = "date"/></p></div>

                </div>
            </div>
        </c:forEach >
        </div>

        <div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px;width:100%">
            <div style="display:flex;flex-direction:row;margin:5px">
                <div style="width:40%">商品总价 </div>
                <div ><p> <fmt:formatNumber value = "${totalItemCN}" type = "number"/>¥ (<fmt:formatNumber value = "${totalItemVN}" type = "number" maxFractionDigits="0"/>đ)</p></div>
            </div>
            <div style="display:flex;flex-direction:row;margin:5px">
                <div style="width:40%">运费 </div>
                <div ><p>  <fmt:formatNumber value = "${sol.shipFeeCNY}" type = "number"/>¥ (<fmt:formatNumber value = "${sol.shipFeeVND}" type = "number"/>đ)</p></div>
            </div>
            <div style="display:flex;flex-direction:row;margin:5px">
                <div style="width:40%">合计 </div>
                <div ><p>  <fmt:formatNumber value = "${sol.totalCN}" type = "number"/>¥ (<fmt:formatNumber maxFractionDigits="0" value = "${sol.totalVN}" type = "number"/>đ)</p></div>
            </div>
            <div style="display:flex;flex-direction:row;margin:5px">
                <div style="width:40%">总共</div>
                <div ><p><fmt:formatNumber maxFractionDigits="0" value = "${sol.totalVN+totalFreight}" type = "number"/> đ</div>
            </div>
        </div>
                                <c:set var="total" value="${total+sol.totalVN+totalFreight}"></c:set>
                                <c:set var="totalFreight" value="0"></c:set>
                                <c:set var="totalItemCN" value="0"></c:set>
                                <c:set var="totalItemVN" value="0"></c:set>
                            </article>
                        </c:forEach>
                    </div>
                </div>
            </main>
            <footer class="footer">
                <div class="container footer--flex">
                    <div class="footer-start">
                        <p>2023 © Mr.Chill </p>
                    </div>
                    <ul class="footer-end">
                        <li>合计 ：<fmt:formatNumber maxFractionDigits="0" value = "${total}" type="number"/>đ)</li>
                    </ul>
                </div>
            </footer>

        </div>
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


