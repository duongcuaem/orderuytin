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
        $("#kg").change(function() {
        $("#freight").val(Number($(this).val()) * $("#rateKg").val());
        $("#totalFreight").val(Number($("#freight").val()) +  Number($("#totalFreight1").val()));
        $("#totalBill").val(Number($("#totalVN").val()) +Number($("#totalFreight").val()));
      });
      $("#cubic").change(function() {
        $("#freight").val(Number($(this).val()) * $("#rateCubic").val());
        $("#totalFreight").val(Number($("#freight").val()) +  Number($("#totalFreight1").val()));
        $("#totalBill").val(Number($("#totalVN").val()) +Number($("#totalFreight").val()));
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
          <p style="color: red">${message}</p>
          <div class="row stat-cards">
              <article class="stat-cards-item" style="margin: 5px">
                <div style="display:flex;flex-direction:column;justify-content:space-between;width:95%">
                  <form:form method="post" action="/backend/wayBill/create" modelAttribute="waybillsDAO">
                      <div style="display:flex;flex-direction:column;justify-content: space-between;margin:10px" >
                        <div style="margin:5px" > Khách hàng :
                          <select name="wbUserName" path="wbUserName">
                            <c:forEach items="${users}" var="u">
                              <option value="${u.userName}">${u.userName}</option>
                            </c:forEach>
                          </select>
                        </div>
                        <input type="text"  name="arriveredDate"   value="<%=java.time.LocalDate.now()%>"  path="arriveredDate" hidden/>
                        <div style="margin:10px">
                          <table>
                          <tr >
                            <th>运单号</th>
                            <th>Kg</th>
                            <th>m3</th>
                            <th>Kg 汇率</th>
                            <th>M3 汇率</th>
                            <th>小计</th>
                          </tr>
                          <tr >
                            <td><input type="text"  value="" name="wayBillCode"  placeholder="Hãy điền mã vận đơn"  path="wayBillCode"/></td>
                            <td><input type="text"  value="0"        id="kg"         name="kg"        path="kg"        style="width:50px" /></td>
                            <td><input type="text"  value="0"        id="cubic"      name="cubic"     path="cubic"     style="width:30px" /></td>
                            <td><input type="text"  value="30000"    id="rateKg"     name="rateKg"    path="rateKg"    style="width:60px" /></td>
                            <td><input type="text"  value="3500000"  id="rateCubic"  name="rateCubic" path="rateCubic" style="width:80px"  /></td>
                            <td><input type="text"  value=""         id="freight"    name="freight"   path="freight"   style="width:80px" /></td>
                            <input type="text"  name="type"  value="KGVK" path="type" hidden/>
                          </tr>
                        </table>
                         </div>
                        <div > <input type="submit" class="form-btn primary-default-btn" style="width:100px;margin-left:70%" value="Cập nhật" /> </div>
                      </div>
                  </form:form>
                </div>
              </article>
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
