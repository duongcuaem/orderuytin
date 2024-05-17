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
    <jsp:include page="/WEB-INF/views/common/mainnavSearchClient.jsp"></jsp:include>

    <div style="padding:10px">

      <!-- ! Main -->
      <main class="main users chart-page" id="skip-target">
        <div class="container">
          <div class="row stat-cards">
            <p style="color: red">${message}</p>
            <div class="row stat-cards">
                <form:form method="post" action="/backend/user/save" modelAttribute="userDAO">

                <div style="display:flex;flex-direction:column;justify-content:space-between;margin:10px;width:100%">
                  <div>
                      <table style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
                    <tr>
                      <td></td>
                      <th style="text-align:center;color:#00ff15">Khách hàng</th>
                      <th style="text-align:center;color:#00ff15">Địa chỉ </th>
                      <th style="text-align:center;color:#00ff15">Số điện thoại</th>
                      <th style="text-align:center;color:#00ff15">Tỉ giá</th>
                      <th style="text-align:center;color:#00ff15">Tỉ giá Kg </th>
                      <th style="text-align:center;color:#00ff15">Tỉ giá M3</th>
                      <th style="text-align:center;color:#00ff15">Tổng phí</th>
                      <th style="text-align:center;color:#00ff15">Tổng có </th>
                      <th style="text-align:center;color:#00ff15">Còn nợ </th>
                    </tr>
                      <tr >
                        <td><a href="/backend/user/delete/${User.userId}">取消</a></td>
                        <td><input type="text"  name="userName"  path="userName" value="${sumTotalUser.userName}"  path="userName" style="width:150px"/></td>
                        <td>${User.address}</td>
                        <td>${User.phone}</td>
                        <td><input type="text"  name="rate"   path="rate"   value="${User.rate}"    style="width:50px"/></td>
                        <td><input type="text"  name="rateKg" path="rateKg" value="${User.rateKg}"  style="width:60px"/></td>
                        <td><input type="text"  name="rateM3" path="rateM3" value="${User.rateM3}"  style="width:70px"/></td>
                        <td><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalUser.totalVN+sumTotalUser.totalFreight}" type = "number"/></td>
                        <td><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalUser.totalAmount+sumTotalUser.totalReFundVN+sumTotalUser.totalCancelVN}" type = "number"/></td>
                        <td><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalUser.totalAmount+sumTotalUser.totalReFundVN+sumTotalUser.totalCancelVN-sumTotalUser.totalVN-sumTotalUser.totalFreight}" type = "number"/></td>
                      </tr>
                  </table>
                  </div>
                    <div style="display:none">
                        <input type="text"  name="userId"       path="userId"      value="${User.userId}"  />
                        <input type="text"  name="address"      path="address"     value="${User.address}"  />
                        <input type="text"  name="phone"        path="phone"       value="${User.phone}"  />
                        <input type="text"  name="role"         path="role"        value="${User.role}"   />
                        <input type="text"  name="email"        path="email"       value="${User.email}" />
                        <input type="text"  name="password"     path="password"    value="${User.password}"   />
                        <input type="text"  name="rePassword"   path="rePassword"  value="${User.rePassword}" />
                        <input type="text"  name="STATUS"       path="STATUS"      value="${User.STATUS}" />
                    </div>
                    <div><button type="submit" class="form-btn primary-default-btn">Cập nhật </button></div>
                </div>

                </form:form>
            </div>

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
