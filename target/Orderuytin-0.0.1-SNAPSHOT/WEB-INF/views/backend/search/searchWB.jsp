<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script>
    $(document).ready(function(){
       let x = Number($("#freight").val());
      $(".kg").change(function() {
        let id = $(this).attr('id') ;
        let itemID = id.substring(2);
        let freightId = "freight" + itemID;
        $("#"+freightId).val(Number($(this).val()) * $(".rateKg").val());
      });
      $(".cubic").change(function() {
        let id = $(this).attr('id') ;
        let itemID = id.substring(5);
        let freightId = "freight" + itemID;
        $("#"+freightId).val(Number($(this).val()) * $(".rateCubic").val());
      });
    });
  </script>
</head>
<body>
<!-- ! Body -->
<div class="page-flex">
  <!-- ! Sidebar -->
  <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
  <div class="main-wrapper">
    <!-- ! Main nav -->
    <jsp:include page="/WEB-INF/views/common/mainnavSearchWB.jsp"></jsp:include>

    <div style="padding:10px">
      <!-- ! Main -->
      <main class="main users chart-page" id="skip-target">
        <div class="container">
          <div class="row stat-cards">
            <p style="color: red">${message}</p>

            <c:forEach items="${showWayBillList}" var="swl" >
              <article class="stat-cards-item" style="margin: 5px">
                <div style="display:flex;flex-direction:column;justify-content:space-between;width:95%">
                <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                  <div ><a href="/backend/order/detail/${swl.orderId}" target="_blank" > <p style="font-weight: bold;color:yellow">CHI TIỂT </p></a> </div>
                  <div > ${swl.wbUserName} </div>
                </div>

                <form:form method="post" action="/backend/wayBill/save" modelAttribute="wayBillDAO">
                 <div style="display:none">
                  <input type="text"  name="wbUserName"      value="${swl.wbUserName}"               path="wbUserName" />
                  <input type="text"  name="orderId"         value="${swl.orderId}"                  path="orderId" />
                  <input type="text"  name="wayBillId"       value="${swl.wayBillId}"                path="wayBillId" />
                  <input type="text"  name="arriveredDate"   value="<%=java.time.LocalDate.now()%>"  path="arriveredDate" />

                 </div>
                  <div style="width:100%;margin:5px">
                    <div style="margin:3px;width:100%">
                      <table>
                        <tr >
                          <th>运单号</th>
                          <th>Kg</th>
                          <th>小计</th>
                          <th>m3</th>
                          <th>Kg 汇率</th>
                          <th>M3 汇率</th>
                        </tr>
                        <tr >
                          <td><input type="text"  value="${swl.wayBillCode}"  path="wayBillCode" style="width:150px" name="wayBillCode" /></td>
                          <td><input type="text"  value="${swl.kg}"         id="kg${swl.wayBillId}"         name="kg"        path="kg"        style="width:60px" class="kg"/></td>
                          <td><input type="text"  value="${swl.freight}"    id="freight${swl.wayBillId}"    name="freight"   path="freight"   style="width:100px" class="freight"/></td>
                          <td><input type="text"  value="${swl.cubic}"      id="cubic${swl.wayBillId}"      name="cubic"     path="cubic"     style="width:80px" class="cubic"/></td>
                          <td><input type="text"  value="${swl.rateKg}"     name="rateKg"    path="rateKg"    style="width:60px" class="rateKg"/></td>
                          <td><input type="text"  value="${swl.rateCubic}"  name="rateCubic" path="rateCubic" style="width:80px" class="rateCubic"/></td>
                          <td><a href="/backend/wayBill/remove/${swl.wayBillId}" >取消</a></td>
                        </tr>
                        <c:set var="order" value="${swl.orders}">  </c:set>
                        <c:forEach var="wb" items="${order.waybills}">
                          <tr>
                            <td>${wb.wayBillCode}</td>
                            <td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
                            <td><fmt:formatNumber value = "${wb.freight}" type = "number"/></td>
                            <td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
                            <td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/></td>
                            <td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
                            <td><a href="/backend/wayBill/remove/${wb.wayBillId}" >取消</a></td>
                          </tr>
                        </c:forEach>

                      </table>
                      <div ><button type="submit" class="primary-default-btn" style="width:120px">Cập nhật</button></div>

                      <div class="row" style="margin:5px">
                  <c:forEach items="${swl.orders.items}" var="i" >
                    <c:set var="totalItemCN" value="${totalItem + i.price * i.quantity }"></c:set>
                    <c:set var="totalItemVN" value="${totalItem + i.price * i.quantity*i.CNYrateVND }"></c:set>

                    <div style="border-radius:10px; background-color:#DADBE4;margin:5px">
                    <div style="display:flex" >
                      <div style="display:flex;flex-direction:column;width:30%;">
                        <div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                        <input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
                      </div>
                      <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                        <div style="width:100%;color:black"> <input type="text" style="width:80px" value="${i.link}" /></div>
                        <div style="width:100%;color:black"> ${i.describle}</div>
                        <div style="width:100%;color:black"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                        <div style="width:100%;color:black"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥  <a style="color:red;float:right"  href="/backend/item/detail/${i.itemId}">编辑</a></div>
                        <div style="width:100%;color:black"> x ${i.CNYrateVND}  ¥/đ</div>
                        <div style="width:100%;color:black"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                      </div>
                    </div>
                    </div>
                  </c:forEach >
                </div>
                      <div style="display:flex;flex-direction:column;width:100%">
                        <div style="display:flex;flex-direction:row;margin:2px">
                          <div style="width:40%">	<p>商品总价 </p></div>
                          <div><p>  <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥(<fmt:formatNumber value = "${totalItemVN}" type = "number"/> đ)</p></div>
                        </div>
                        <div style="display:flex;flex-direction:row;margin:2px">
                          <div style="width:40%">	<p>运费 </p></div>
                          <div ><p>  <fmt:formatNumber maxFractionDigits="0" value = "${swl.orders.shipFeeCNY}" type = "number"/> ¥ (<fmt:formatNumber value = "${swl.orders.shipFeeVND}" maxFractionDigits="0" type = "number"/> đ)</p></div>
                        </div>
                        <div style="display:flex;flex-direction:row;margin:2px">
                          <div style="width:40%">	<p>合计 </p></div>
                          <div><p>  <fmt:formatNumber value = "${swl.orders.totalCN}" type = "number"/> ¥(<fmt:formatNumber value = "${swl.orders.totalVN}" type = "number"/> đ)</p></div>
                        </div>
                      <div style="display:none">
                        <input type="text"  name="shipFeeCNY"     value="${swl.orders.shipFeeCNY}"      path="shipFeeCNY"    />
                        <input type="text"  name="totalCN"        value="${swl.orders.totalCN}"         path="totalCN"       />
                        <input type="text"  name="shipFeeVND"     value="${swl.orders.shipFeeVND}"      path="shipFeeVND"    />
                        <input type="text"  name="totalVN"        value="${swl.orders.totalVN}"         path="totalVN"        id="totalVN" />
                        <input type="text"  name="orderUserName"  value="${swl.orders.orderUserName}"   path="orderUserName" />
                        <input type="text"  name="receivedDate"   value="${swl.orders.receivedDate}"    path="receivedDate"  />
                        <input type="text"  name="orderId"        value="${swl.orders.orderId}"         path="orderId"       />
                        <input type="text"  name="orderNo"        value="${swl.orders.orderNo}"         path="orderNo"       />
                        <input type="text"  name="orderStatus"    value="Da ve kho"                     path="orderStatus"   />
                      </div>
                      </div>
                    </div>
                  </div>
                </form:form>
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
