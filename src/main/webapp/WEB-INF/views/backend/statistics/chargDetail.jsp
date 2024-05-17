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
        <jsp:include page="/WEB-INF/views/common/mainnav.jsp"></jsp:include>
        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <div style="color: #5eff00;font-size:40px;text-align:center">SAO KÊ NẠP TIỀN</div>
                <div class="main-nav-start" style=" margin:10px">
                    <form  action="/backend/statistics/chargDetailBetween2Days" method="post">
                        <div  style="justify-content: space-between;display:flex;flex-direction:row">
                            <div> <input type="date" name="startDate"value="" style="width:200px"></div>
                            <div> <input type="date" name="endDate"  value="<%=java.time.LocalDate.now()%>" style="width:200px"></div>
                            <button type="submit" class="primary-default-btn" style="width:80px">搜索</button>
                        </div>
                    </form>
                </div>
                <div style="color: #5eff00;font-size:20px;text-align:center"> Từ ngày : <fmt:formatDate value = "${from}" type = "date"/> đến ngày : <fmt:formatDate value = "${to}" type = "date"/></div>
                <div class="row stat-cards">
                    <div style="margin:3px;width:100%;color:darkred">
                        <table>
                            <tr >
                                <th style="text-align:center;color:#00ff15">客户</th>
                                <th style="text-align:center;color:#00ff15">钱款</th>
                                <th style="text-align:center;color:#00ff15">备注</th>
                                <th style="text-align:center;color:#00ff15">充钱日</th>
                            </tr>
                            <c:forEach var="cl" items="${chargList}">
                                <c:set var="totalCharg" value="${totalCharg + cl.amount}"></c:set>
                                <tr style="color:red">
                                    <td>${cl.users.userName}</td>
                                    <td><fmt:formatNumber value = "${cl.amount}" type = "number"/></td>
                                    <td>${cl.note}</td>
                                    <td><fmt:formatDate value = "${cl.chargDate}" type = "date"/></td>
                                </tr>
                            </c:forEach>
                            <tr >
                                <th style="text-align:center;color:#00ff15">合计</th>
                                <th style="text-align:center;color:#00ff15"><fmt:formatNumber value = "${totalCharg}" type = "number"/></th>
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
                                <a class="page-link" href="/backend/statistics/chargDetail?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                            </li></div>
                        <c:forEach begin="1" end="${total}" step="1" var="num">
                            <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                <a class="page-link" href="/backend/statistics/chargDetail?page=${num}&perpage=${perpage}">${num}</a>
                            </li></div>
                        </c:forEach>
                        <div>
                            <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                <a class="page-link" href="/backend/statistics/chargDetail?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                            </li></div>
                    </div>
                </ul>
            </nav>
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
