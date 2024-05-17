<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
</head>
<body>
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <jsp:include page="/WEB-INF/views/common/mainnavSearchArriveredOrder.jsp"></jsp:include>
        <div style="padding:10px">
            <!-- ! Main -->
            <main class="main users chart-page" id="skip-target">
                <div class="container">
                    <div class="row stat-cards">
                        <p style="color: red">${message}</p>
                        <c:forEach items="${showOrderList}" var="sol" >
                            <article class="stat-cards-item" style="margin: 5px">
                                <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                    <div >  <fmt:formatDate value = "${sol.receivedDate}" type = "date"/></div>
                                    <div >  ${sol.orderNo}  </br>${sol.orderUserName}     </div>
                                </div>
      <form:form method="post" action="/backend/wayBill/saveWayBill" modelAttribute="wayBillDAO">
     <div style="display: none">
            <input type="text"  name="orderUserName"  value="${sol.orderUserName}"   path="orderUserName" />
            <input type="text"  name="receivedDate"  value="${sol.receivedDate}" path="receivedDate" />
            <input type="text"  name="orderId" value="${sol.orderId}" path="orderId" />
            <input type="text"  name="totalVN"  value="${sol.totalVN}"  path="totalVN" />
            <input type="text"  name="orderNo"  value="${sol.orderNo}"  path="orderNo" />
            <input type="text"  name="totalCN"  value="${sol.totalCN}"  path="totalCN" />
            <input type="text"  name="shipFeeCNY"  value="${sol.shipFeeCNY}"  path="shipFeeCNY" />
            <input type="text"  name="shipFeeVND"  value="${sol.shipFeeVND}"  path="shipFeeVND" />
            <input type="text"  name="wbUserName"  value="${sol.orderUserName}" path="wbUserName" />
            <input type="text"  name="type"  value="DH" path="type" />
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
                    <option value="Khieu nai">Khiếu nại</option>
                    <option value="Sua don">Chỉnh sửa đơn</option>
                    <option value="Huy">Hủy</option>
                </select>
               </div>
               <div > <input type="submit" class="form-btn primary-default-btn" value="Cập nhật" /> </div>
            </div>
        </div>

      </form:form>
        <div style="width:100%;margin:5px">
            <div style="margin:3px;width:100%">
                <table>
                    <tr>
                        <th></th>
                        <th>运单号</th>
                        <th>Kg</th>
                        <th>m3</th>
                        <th>Kg 汇率</th>
                        <th>M3 汇率</th>
                        <th>小计</th>
                    </tr>
                    <c:forEach items="${sol.waybills}" var="wb" >
                        <c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
                    <tr style="color: #5eff00">
                        <td><a href="/backend/wayBill/remove/${wb.wayBillId}" >取消</a></td>
                        <td>${wb.wayBillCode}</td>
                        <td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${wb.freight}" type = "number"/></td>
                    </tr>
                    </c:forEach>
                    <tr>
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
        </div>
        <div class="row">
        <c:forEach items="${sol.items}" var="i" >
            <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
            <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
            <div style="border-radius:10px; background-color:#DADBE4;margin:5px;display:flex;flex-direction:row">
                <div style="display:flex;flex-direction:column;width:30%;">
                    <div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                    <input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
                </div>
                <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                    <div style="width:100%;color:black"> <input type="text" style="width:80px" value="${i.link}" /></div>
                    <div style="width:100%;color:black"> ${i.describle}</div>
                    <div style="width:100%;color:black"><fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                    <div style="width:100%;color:black"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                    <div style="width:100%;color:black"> x ${i.CNYrateVND}  ¥/đ</div>
                    <div style="width:100%;color:black"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                </div>
            </div>
        </c:forEach >
        </div>

        <div style="display:flex;flex-direction:column;width:100%">
            <div style="display:flex;flex-direction:row;margin:2px"><div style="width:50%">	<p>商品总价(CNY-VNĐ) :</p></div><div><p>  <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥ ~~ <fmt:formatNumber value = "${totalItemVN}" type = "number" maxFractionDigits="0"/> đ</p></div></div>
            <div style="display:flex;flex-direction:row;margin:2px"><div style="width:50%">	<p>运费 (CNY-VNĐ) :</p></div><div style="text-align:center"><p>  <fmt:formatNumber value = "${sol.shipFeeCNY}" type = "number"/> ¥  ~~ <fmt:formatNumber value = "${sol.shipFeeVND}" type = "number"/> đ</p></div></div>
            <div style="display:flex;flex-direction:row;margin:2px"><div style="width:50%">	<p>合计 (CNY-VNĐ) :</p></div><div><p>  <fmt:formatNumber value = "${sol.totalCN}" type = "number"/> ¥  ~~ <fmt:formatNumber value = "${sol.totalVN}" type = "number"/> đ</p></div></div>
            <div style="display:flex;flex-direction:row;margin:2px"><div style="width:50%">	<p>总共(包含越南运费) (VNĐ) :</p></div><div><fmt:formatNumber value = "${sol.totalVN+totalFreight}" type = "number"/></div></div>
        </div>
                            </article>
                        </c:forEach>
                    </div>
                </div>
            </main>
            <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
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


