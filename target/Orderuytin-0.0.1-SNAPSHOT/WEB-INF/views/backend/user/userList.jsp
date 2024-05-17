<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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

        <p style="color: red">${message}</p>
        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="color:yellow">
            <div class="container">
                <form:form action="/backend/user/updateRate" method="post">
                    <div style="display:flex;flex-direction:row">
                        <div style="text-align:center;margin:5px">Tỉ giá CNY/VNĐ</div>
                        <div><input type="text" style="width:80px" name="rate" required /> </div>
                        <div style="text-align:center;margin:5px">Tỉ giá kg</div>
                        <div ><input type="text" style="width:80px"  name="rateKg" required /></div>
                        <div style="text-align:center;margin:5px">Tỉ giá khối </div>
                        <div ><input type="text"  style="width:80px" name="rateM3" required /> </div>
                      <button type="submit"  style="padding:10px;color:yellow;background-color:black;font-size:20px;font-weight:bold;border-radius:10px;border-style:solid;border-width: thin;border-color:white"> Cập nhật tỉ giá</button>
                    </div>
                </form:form>
            <div style="font-size:40px;text-align:center;margin:10px;color:yellow"><p>客户名单</p></div>

                      <table style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
                        <tr>
                            <th style="text-align:center;color:#00ff15">客户</th>
                            <th style="text-align:center;color:#00ff15">欠钱</th>
                            <th style="text-align:center;color:#00ff15">有钱</th>
                            <th style="text-align:center;color:#00ff15">合计</th>
                            <td></td>
                        </tr>
                    <c:forEach items="${sumTotal}" var="t" >
                        <tr>
                            <td>${t.userName}</td>
                            <td><fmt:formatNumber maxFractionDigits="0" value = "${t.totalVN+t.totalFreight}" type = "number"/></td>
                            <td><fmt:formatNumber maxFractionDigits="0" value = "${t.totalAmount+t.totalCancelVN+t.totalReFundVN}" type = "number"/></td>
                            <td><fmt:formatNumber maxFractionDigits="0" value = "${t.totalAmount+t.totalReFundVN+t.totalCancelVN-t.totalVN-t.totalFreight}" type = "number"/></td>
                            <td><a href="/backend/user/resetPassword/${t.userId}">改密码</a></td>
                        </tr>
                    </c:forEach>
                     </table>


            </div>
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



