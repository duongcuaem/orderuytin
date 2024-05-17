<%@ page import="java.text.SimpleDateFormat" %>
<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
    <!-- ! Main -->
    <main class="main users chart-page" id="skip-target">
      <div class="container">
        <div style="display:flex;flex-direction:column">
          <div style="font-size:40px;text-align:center"><p>CHI TIÊT TIỀN VẬN CHUYỂN</p></div>
        </div>
        <form  action="/user/statistics/freightDetailBetween2Days" method="post">
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
          <div style="margin:3px;width:100%">
            <table>
              <tr >
                <th style="text-align:center">Ngày về</th>
                <th style="text-align:center">Mã vận đơn</th>
                <th style="text-align:center">kg</th>
                <th style="text-align:center">m3</th>
                <th style="text-align:center">Tỉ giá kg</th>
                <th style="text-align:center">Tỉ giá m3</th>
                <th style="text-align:center">Thành tiền</th>
              </tr>
              <c:forEach items="${freightDetailUser}" var="w" >
                <c:set var="totalFreight" value="${totalFreight + w.freight}"></c:set>
                <tr >
                  <td><fmt:formatDate value = "${w.arriveredDate}" type ="date"/></td>
                  <td>${w.wayBillCode}</td>
                  <td><fmt:formatNumber value = "${w.kg}" type = "number"/></td>
                  <td><fmt:formatNumber value = "${w.cubic}" type = "number"/></td>
                  <td><fmt:formatNumber value = "${w.rateKg}" type = "number"/></td>
                  <td><fmt:formatNumber value = "${w.rateCubic}" type = "number"/></td>
                  <td><fmt:formatNumber value = "${w.freight}" type = "number"/></td>
                </tr>
              </c:forEach>
              <tr >
                <th style="text-align:center;color:#00ff15"></th>
                <th style="text-align:center;color:#00ff15"></th>
                <th style="text-align:center;color:#00ff15"></th>
                <th style="text-align:center;color:#00ff15"></th>
                <th style="text-align:center;color:#00ff15"></th>
                <th style="text-align:center">Tổng tiền</th>
                <th style="text-align:center"><fmt:formatNumber value = "${totalFreight}" type = "number"/></th>
              </tr>
            </table>
          </div>
        </div>
      </div>

      <nav aria-label="..." style="margin:10px">
        <ul class="pagination">
          <div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
            <div>
              <li class="page-item <c:if test="${page == 1}">disabled</c:if>">
                <a class="page-link" href="/user/statistics/freightDetail?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
              </li></div>
            <c:forEach begin="1" end="${total}" step="1" var="num">
              <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                <a class="page-link" href="/user/statistics/freightDetail?page=${num}&perpage=${perpage}">${num}</a>
              </li></div>
            </c:forEach>
            <div>
              <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                <a class="page-link" href="/user/statistics/freightDetail?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
              </li></div>
          </div>
        </ul>
      </nav>
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

