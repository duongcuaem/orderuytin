<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

        <!-- ! Main -->
<main class="main users chart-page" id="skip-target" style="color:yellow">
<div class="container" style="color:yellow">
    <div style="display:flex;flex-direction:column">
        <div style="font-size:40px;text-align:center"><p>THỐNG KÊ</p></div>
    </div>
    <form  action="/backend/statistics/statisticsAdminBetween2Days" method="post">
        <div  style="justify-content: space-between;display:flex;flex-direction:row;margin:10px">
    <div> <input type="date" name="startDate" style="width:200px"></div>
    <div> <input type="date" name="endDate"  value="<%=java.time.LocalDate.now()%>" style="width:200px"></div>
            <button type="submit" style="border-radius:5px;padding:10px;color:yellow;font-weight:bold;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white"> 搜索 </button>

        </div>
    </form>
    <div style="font-size:20px;text-align:center;margin:20px">
        Từ ngày : <fmt:formatDate value = "${from}" type = "date"/> đến ngày : <fmt:formatDate value = "${to}" type = "date"/>
    </div>

    <div style="padding:20px">
    <table style="margin: 5px;color:yellow">
        <tr>
            <th style="text-align:center">Tiền hàng</br><a href="/backend/statistics/totalVNDetail" target="_blank" style="color:red">(Chi tiết)</a></th>
            <th style="text-align:center">Tiền cước</br><a href="/backend/statistics/freightDetail" target="_blank" style="color:red">(Chi tiết)</a> </th>
            <th style="text-align:center">Tổng phí</th>
        </tr>

        <tr >
            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalVN}" type = "number"/></td>
            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalFreight}" type ="number"/></td>
            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalVN+sumTotalFreight}" type ="number"/></td>
        </tr>
    </table>
    <div style="padding:20px">
        <table style="margin: 5px;color:yellow;padding:20px">
            <tr>
                <th style="text-align:center">Tiền đã nạp</br><a href="/backend/statistics/chargDetail" target="_blank" style="color:red">(Chi tiết)</a> </th>
                <th style="text-align:center">Tiền hoàn</br><a href="/backend/statistics/refundDetail" target="_blank" style="color:red">(Chi tiết)</a> </th>
                <th style="text-align:center">Tổng có</th>
            </tr>
            <tr >
                <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmount}" type = "number"/></td>
                <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumReFundVN + sumTotalCancelVN}" type = "number"/> </td>
                <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmount + sumReFundVN+sumTotalCancelVN}" type = "number"/></td>
            </tr>
        </table>
    </div>

    <div style="padding:20px">
        <table style="margin: 5px;color:yellow;padding:20px">
            <tr>
                <th style="text-align:center">Còn lại</th>
            </tr>
            <tr >
                <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmount+sumReFundVN+sumTotalCancelVN-sumTotalVN-sumTotalFreight}" type = "number"/></td>
            </tr>
        </table>
    </div>

    </div>





<%--    <div class="row stat-cards">--%>
<%--      <table>--%>
<%--        <tr>--%>
<%--            <th style="text-align:center"><a href="/backend/statistics/totalVNDetail" target="_blank" >Tiền hàng </a></th>--%>
<%--            <th style="text-align:center"><a href="/backend/statistics/freightDetail" target="_blank" >Tiền cước </a> </th>--%>
<%--            <th style="text-align:center">Tổng phí</th>--%>
<%--            <th style="text-align:center"><a href="/backend/statistics/chargDetail" target="_blank" >Tiền đã nạp</a></th>--%>
<%--            <th style="text-align:center"><a href="/backend/statistics/refundDetail" target="_blank" >Tiền hoàn </a> </th>--%>
<%--            <th style="text-align:center">Tổng có</th>--%>
<%--            <th style="text-align:center">Còn lại</th>--%>
<%--        </tr>--%>
<%--        <tr >--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalVN}" type = "number"/> </td>--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalFreight}" type ="number"/></td>--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalVN+sumTotalFreight}" type ="number"/></td>--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmount}" type = "number"/></td>--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumReFundVN+sumTotalCancelVN}" type = "number"/> </td>--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmount+sumReFundVN+sumTotalCancelVN}" type = "number"/></td>--%>
<%--            <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmount+sumReFundVN+sumTotalCancelVN-sumTotalVN-sumTotalFreight}" type = "number"/></td>--%>
<%--        </tr>--%>
<%--      </table>--%>
<%--    </div>--%>
</div>

</main>



