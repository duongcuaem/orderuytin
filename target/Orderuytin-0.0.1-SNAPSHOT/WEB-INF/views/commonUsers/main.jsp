<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <div style="display:flex;flex-direction:column">
                    <div style="font-size:40px;text-align:center"><p>THỐNG KÊ</p></div>
                </div>
                <form  action="/user/statistics/searchStatistics" method="post">
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
                    <button type="submit"  style="border-radius:5px;background-color:black;width:100px;height:40px;margin-left:30%;color:yellow;border-radius:10px;border-style:solid;border-width: thin;border-color:white">Truy vấn</button>
                    </div>
                </form>
                <div style="font-size:20px;text-align:center;margin:10px">
                    Từ ngày : <fmt:formatDate value = "${from}" type = "date"/> đến ngày : <fmt:formatDate value = "${to}" type = "date"/>
                </div>
                <div style="padding:20px">
                <table style="margin: 5px;color:yellow">
                    <tr>
                        <th style="text-align:center">Tiền hàng</br><a href="/user/statistics/totalVNDetail" target="_blank" style="color:red">Chi tiết </a></th>
                        <th style="text-align:center">Tiền cước</br><a href="/user/statistics/freightDetail" target="_blank" style="color:red">Chi tiết </a> </th>
                        <th style="text-align:center">Tổng phí</th>
                    </tr>

                    <tr >
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalVNUser}" type = "number"/></td>
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalFreightUser}" type ="number"/></td>
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumTotalVNUser +  sumTotalFreightUser}" type ="number"/></td>

                    </tr>
                </table>
                    <div style="padding:20px">
                <table style="margin: 5px;color:yellow;padding:20px">
                    <tr>
                        <th style="text-align:center">Tiền đã nạp</br><a href="/user/statistics/chargDetail" target="_blank" style="color:red">Chi tiết </a> </th>
                        <th style="text-align:center">Tiền hoàn</br><a href="/user/statistics/refundDetail" target="_blank" style="color:red">Chi tiết </a> </th>
                        <th style="text-align:center">Tổng có</th>
                    </tr>
                    <tr >
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmountUser}" type = "number"/></td>
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumReFundVNUser + sumTotalCancelVNUser}" type = "number"/> </td>
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmountUser + sumReFundVNUser+sumTotalCancelVNUser}" type = "number"/></td>
                    </tr>
                </table>
                    </div>
                    <div style="padding:20px">
                <table style="margin: 5px;color:yellow;padding:20px">
                    <tr>
                        <th style="text-align:center">Còn lại</th>
                    </tr>
                    <tr >
                        <td style="text-align:center"><fmt:formatNumber maxFractionDigits="0" value = "${sumAmountUser + sumReFundVNUser+sumTotalCancelVNUser - sumTotalVNUser -sumTotalFreightUser}" type = "number"/></td>
                    </tr>
                </table>
                    </div>
            </div>

        </main>





