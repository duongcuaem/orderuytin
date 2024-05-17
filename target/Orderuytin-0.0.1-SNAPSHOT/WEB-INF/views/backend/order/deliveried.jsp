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
		<jsp:include page="/WEB-INF/views/common/mainnavSearchWB.jsp"></jsp:include>

		<!-- ! Main -->
		<main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
			<div class="container">
				<div style="display:flex;flex-direction:column">
					<div><p style="color: red">${message}</p></div>
				</div>
				<div class="row stat-cards">
					<c:forEach items="${showDeliveriedOrderList}" var="sdol" >
						<c:set var="totalCN" value="${totalCN + sdol.totalCN }"></c:set>
						<c:set var="totalVN" value="${totalVN + sdol.totalVN }"></c:set>
						<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
							<div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
								<div >  <fmt:formatDate value = "${sdol.receivedDate}" type = "date"/></div>
								<div style="margin-left:10%">  ${sdol.orderNo}</br>${sdol.orderUserName}</div>
							</div>
							<div class="row">
								<c:forEach items="${sdol.items}" var="i" >
									<c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
									<c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity  * i.CNYrateVND}"></c:set>
									<div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:column;margin:2px">
									<div style="display:flex;flex-direction:row">
										<div style="display:flex;flex-direction:column;">
											<div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
											<input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
										</div>
										<div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:20px">
											<div style="width:100%"> <a href="${i.link}"> 链接 </a><input type="text" style="width:80px" value="${i.link}" /></div>
											<div style="width:100%"> ${i.describle}</div>
											<div style="width:100%"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
											<div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥  <a style="color:red;float:right"  href="/backend/item/detail/${i.itemId}">编辑</a></div>
											<div style="width:100%"> x ${i.CNYrateVND}  ¥/đ</div>
											<div style="width:100%"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
										</div>
									</div>
									</div>
								</c:forEach >
							</div>
							<div style="width:100%;margin:5px">
								<div style="margin:3px;width:100%;text-align:center">
									<table>
										<tr style="text-align:center">
											<th>运单号</th>
											<th>收到日</th>
											<th>小计</th>
											<th>Kg</th>
											<th>M3</th>
											<th>Kg汇率</th>
											<th>M3 汇率</th>
											<th></th>
										</tr>
										<c:forEach var="wb" items="${sdol.waybills}">
											<c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
										<tr >
											<td>${wb.wayBillCode}</td>
											<td><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
											<td>${wb.freight}</td>
											<td>${wb.kg}</td>
											<td> <fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
											<td>${wb.rateKg}</td>
											<td>${wb.rateCubic}</td>
											<td><a href="/backend/wayBill/remove/${wb.wayBillId}" >取消</a></td>
										</tr>
										</c:forEach>
										<tr >
											<td>合计</td>
											<td>${totalFreight}</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>
							</div>
							<div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px;width:100%">
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:30%">商品总价</div>
									<div><p><fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥(<fmt:formatNumber value = "${totalItemVN}" maxFractionDigits="0" type = "number"/> đ)</p></div>
								</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:30%">运费  </div>
									<div><p><fmt:formatNumber value = "${sdol.shipFeeCNY}" type = "number"/> ¥(<fmt:formatNumber value = "${sdol.shipFeeVND}" maxFractionDigits="0" type = "number"/> đ)</p></div>
								</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:30%">合计 </div>
									<div><p> <fmt:formatNumber value = "${totalItemCN+sdol.shipFeeCNY}" type = "number"/> ¥(<fmt:formatNumber value = "${totalItemVN+sdol.shipFeeVND}" maxFractionDigits="0" type = "number"/> đ)</p></div>
								</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:30%">总共 </div>
									<div><p> <fmt:formatNumber value = "${totalFreight+totalItemVN+sdol.shipFeeVND}" maxFractionDigits="0" type = "number"/> đ</p></div>
								</div>
							</div>
						</article>
							<c:set var="totalItemCN" value="0"></c:set>
							<c:set var="totalItemVN" value="0"></c:set>
							<c:set var="totalFreight" value="0"></c:set>
					</c:forEach>
				</div>
			</div>
		</main>

		<footer class="footer">
			<div class="container footer--flex">
				<div class="footer-start">
					<nav aria-label="..." style="width:400px">
						<ul class="pagination">
							<div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
								<div>
									<li class="page-item <c:if test="${page == 1}">disabled</c:if>">
										<a class="page-link" href="/backend/order/deliveried?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
									</li></div>
								<c:forEach begin="1" end="${total}" step="1" var="num">
									<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
										<a class="page-link" href="/backend/order/deliveried?page=${num}&perpage=${perpage}">${num}</a>
									</li></div>
								</c:forEach>
								<div>
									<li class="page-item <c:if test="${page == total}">disabled</c:if>">
										<a class="page-link" href="/backend/order/deliveried?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
									</li>
								</div>
							</div>
						</ul>
					</nav>
				</div>
				<ul class="footer-end">
					<li><p>已发货订单总额 ： <fmt:formatNumber value = "${totalCN}" type="number"/>¥(<fmt:formatNumber value = "${totalVN}" maxFractionDigits="0" type="number"/>đ)</p> </li>
				</ul>
			</div>
		</footer>
	</div>


	<!-- Chart library -->
	<script src="/plugins/chart.min.js"></script>
	<!-- Icons library -->
	<script src="/plugins/feather.min.js"></script>
	<!-- Custom scripts -->
	<script src="/js/script.js"></script>

</body>

</html>


