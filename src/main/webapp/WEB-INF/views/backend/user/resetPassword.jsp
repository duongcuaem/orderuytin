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
<body>
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
                <form:form method="post" action="/backend/user/savePassword" modelAttribute="userDAO">
                <article class="stat-cards-item">
                <div style="display:flex;flex-direction:column;justify-content:space-between;margin:10px;width:100%">
                  <div>
                      <table>
                    <tr>
                      <th style="text-align:center;color:#00ff15">客户</th>
                      <th style="text-align:center;color:#00ff15">地址 </th>
                      <th style="text-align:center;color:#00ff15">电话号码</th>
                      <th style="text-align:center;color:#00ff15">汇率</th>
                      <th style="text-align:center;color:#00ff15">kg 汇率</th>
                      <th style="text-align:center;color:#00ff15">m3 汇率</th>
                      <th style="text-align:center;color:#00ff15">欠钱</th>
                      <th style="text-align:center;color:#00ff15">有钱</th>
                      <th style="text-align:center;color:#00ff15">合计</th>
                      <th style="text-align:center;color:#00ff15">密码</th>
                      <th style="text-align:center;color:#00ff15">再密码</th>
                    </tr>
                      <tr >
                        <td>${User.userName}</td>
                        <td>${User.address}</td>
                        <td>${User.phone}</td>
                        <td>${User.rate}</td>
                        <td>${User.rateKg}</td>
                        <td>${User.rateM3}</td>
                        <td><fmt:formatNumber value = "${sumTotalUser.totalVN+sumTotalUser.totalFreight}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${sumTotalUser.totalAmount+sumTotalUser.totalReFundVN+sumTotalUser.totalCancelVN}" type = "number"/></td>
                        <td><fmt:formatNumber value = "${sumTotalUser.totalAmount+sumTotalUser.totalReFundVN+sumTotalUser.totalCancelVN-sumTotalUser.totalVN-sumTotalUser.totalFreight}" type = "number"/></td>
                        <td><input type="text"  name="password"   path="password"   value=""  style="width:50px"/></td>
                        <td><input type="text"  name="rePassword" path="rePassword" value=""  style="width:50px"/></td>
                      </tr>
                  </table>
                  </div>
                    <div style="display:none">
                        <input type="text"  name="rate"         path="rate"        value="${User.rate}"  />
                        <input type="text"  name="rateKg"       path="rateKg"      value="${User.rateKg}"  />
                        <input type="text"  name="rateM3"       path="rateM3"      value="${User.rateM3}"  />
                        <input type="text"  name="userName"     path="userName"    value="${User.userName}"  />
                        <input type="text"  name="userId"       path="userId"      value="${User.userId}"  />
                        <input type="text"  name="address"      path="address"     value="${User.address}"  />
                        <input type="text"  name="phone"        path="phone"       value="${User.phone}"  />
                        <input type="text"  name="role"         path="role"        value="${User.role}"   />
                        <input type="text"  name="email"        path="email"       value="${User.email}" />
                        <input type="text"  name="STATUS"       path="STATUS"      value="${User.STATUS}" />
                    </div>
                    <div><button type="submit" class="form-btn primary-default-btn">Reset Password</button></div>
                </div>
              </article>
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
