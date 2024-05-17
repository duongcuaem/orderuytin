<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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

        <div style="padding:10px">

            <!-- ! Main -->
            <main class="main users chart-page" id="skip-target">
                <div class="container">
                    <div class="row stat-cards">
                        <p style="color: red">${message}</p>
                        <c:forEach items="${showOrderList}" var="sol" >
                            <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">
                            <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                    <div > Ngày đặt hàng : <fmt:formatDate value = "${sol.receivedDate}" type = "date"/></div>
                                    <div > Mã đơn hàng : ${sol.orderNo}       </div>
                            </div>

                            <div class="row">
                                <c:forEach items="${sol.items}" var="i" >
                                    <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                                    <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                    <div style="display:flex;flex-direction:row;margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">
                                        <div style="display:flex;flex-direction:column;width:30%;">
                                            <div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                                            <input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
                                        </div>
                                        <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                            <div style="width:100%"><a href="${i.link}">Click Link</a><input type="text" style="width:80px" value="${i.link}" /></div>
                                            <div style="width:100%"> ${i.describle}</div>
                                            <div style="width:100%"><fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                                            <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                            <div style="width:100%"> x ${i.CNYrateVND}  ¥/đ</div>
                                            <div style="width:100%"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                                        </div>
                                    </div>
                                </c:forEach >
                            </div>
                                <div style="margin:3px;width:100%">
                                    <table>
                                        <tr>
                                            <th>Mã vận đơn</th>
                                            <th>Thành tiền</th>
                                            <th>Ngàyvềkho</th>
                                            <th>kg</th>
                                            <th>m3</th>
                                            <th>Tỉ giá kg</th>
                                            <th>Tỉ giá m3</th>
                                        </tr>
                                    <c:forEach items="${sol.waybills}" var="wb" >
                                        <c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
                                        <tr >
                                            <td>${wb.wayBillCode}</td>
                                            <td>${wb.freight}</td>
                                            <td><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
                                            <td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
                                            <td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
                                            <td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/> </td>
                                            <td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
                                        </tr>
                                    </c:forEach>
                                        <tr style="color:red">
                                            <td>Tổng cước</td>
                                            <td><fmt:formatNumber value = "${totalFreight}" type = "number"/></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px">
                                    <div style="display:flex;flex-direction:row;margin:5px">Tổng số lượng sp trong đơn hàng : ${totalQuantity}</div>
                                    <div style="display:flex;flex-direction:row;margin:5px">
                                        <div style="width:40%">Tiền hàng </br><p style="font-weight: bold">(ko ship nđ)</p>  </div>
                                        <div><p>  <fmt:formatNumber value = "${totalItemVN}" type = "number"/>đ (<fmt:formatNumber value = "${totalItemCN}" type = "number"/>¥)</p></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin:5px">
                                        <div style="width:40%"><p>Ship nội địa : </p></div>
                                        <div style="text-align:center"><p> <fmt:formatNumber value = "${sol.shipFeeVND}" type = "number"/>đ ( <fmt:formatNumber value = "${sol.shipFeeCNY}" type = "number"/>¥)</p></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin:5px">
                                        <div style="width:40%">Tiền hàng </br><p style="font-weight: bold">(có ship nđ)</p> </div>
                                        <div><p> <fmt:formatNumber value = "${sol.totalVN}" type = "number"/>đ (<fmt:formatNumber value = "${sol.totalCN}" type = "number"/>¥)</p></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin:5px">
                                        <div style="width:40%">Tổng tiền đh </br><p style="font-weight: bold">(gồm cước vc) </p></div>
                                        <div><fmt:formatNumber value = "${sol.totalVN+totalFreight}" type = "number"/> đ</div>
                                    </div>
                                </div>

                            </article>
                            <c:set var="totalItemCN" value="0"></c:set>
                            <c:set var="totalItemVN" value="0"></c:set>
                            <c:set var="totalFreight" value="0"></c:set>
                        </c:forEach>
                    </div>
                </div>

            </main>
            <jsp:include page="/WEB-INF/views/commonUsers/footer.jsp"></jsp:include>
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


