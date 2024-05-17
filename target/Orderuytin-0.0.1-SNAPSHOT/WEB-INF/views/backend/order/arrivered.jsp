<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
<script>
	$(document).ready(function(){
		var freightKGval = $("#freightKG").val();
		if(freightKGval == 0){
			$(".KG").hide();
		}
	});
</script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
	<!-- ! Sidebar -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
	<div class="main-wrapper">
		<!-- ! Main nav -->
		<jsp:include page="/WEB-INF/views/common/mainnavSearchArriveredOrder.jsp"></jsp:include>

		<!-- ! Main -->
		<main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
			<div class="container">
				<div style="display:flex;flex-direction:column">
					<div><p style="color: red">${message}</p></div>
				</div>
				<div class="row stat-cards">
					<c:forEach items="${showArriveredOrderList}" var="saol" >
						<c:set var="totalCN" value="${totalCN + saol.totalCN }"></c:set>
						<c:set var="totalVN" value="${totalVN + saol.totalVN }"></c:set>
						<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

						<div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
								<div >  <fmt:formatDate value = "${saol.receivedDate}" type = "date"/></div>
								<div >  ${saol.orderNo} </div>
								<div >  <a href="/backend/order/editStatus/${saol.orderId}" >成功</a></div>
								<div > ${saol.orderUserName} </div>
							</div>
							<div class="row">
					<c:forEach items="${saol.items}" var="i" >
						<c:set var="totalQuantity" value="${totalQuantity + i.quantity }"></c:set>
						<c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
						<c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
						<div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:column;margin:2px">
							<div style="display:flex;flex-direction:row">
								<div style="display:flex;flex-direction:column;">
									<div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
									<input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
								</div>
								<div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:20px">
									<div style="width:100%"> <a href="${i.link}"> 链接 </a><input type="text" style="width:80px" value="${i.link}" /></div>
									<div style="width:100%"> ${i.describle}</div>
									<div style="width:100%"><fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
									<div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥  <a style="color:red;float:right"  href="/backend/item/detail/${i.itemId}">编辑</a></div>
									<div style="width:100%"> x ${i.CNYrateVND}  đ/¥</div>
									<div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price*i.CNYrateVND}" maxFractionDigits="0" type = "number"/> đ</div>
								</div>
							</div>
							<div style="display:flex;flex-direction:column;justify-content: space-between;width:100%">
								<div > 投诉  :  ${i.userNote} </div>
								<div style="color:red"> 反馈 :  ${i.adminNote} </div>
								<div > 退款   : <fmt:formatNumber value = "${i.price*i.CNYrateVND*i.quantityRefund}" type = "number"/> đ</div>
								<div > 退款日 : <fmt:formatDate value = "${i.refundDate}" type = "date"/></div>
							</div>
						</div>
					</c:forEach >
				            </div>

				<div style="width:100%;margin:5px">
					<div style="margin:3px;width:100%;text-align:center">
						<table>
							<tr style="text-align:center">
								<th>运单号</th>
								<th>小计</th>
								<th>Kg</th>
								<th>收到日</th>
								<th>m3</th>
								<th>Kg汇率</th>
								<th>M3 汇率</th>
								<th></th>
							</tr>
					<c:forEach var="wb" items="${saol.waybills}">
								<c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
								<c:set var="totalFreightVN" value="${totalFreightVN + wb.freight}"></c:set>
							<tr>
								<td>${wb.wayBillCode}</td>
								<td><fmt:formatNumber value = "${wb.freight}" type = "number"/></td>
								<td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
								<td><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
								<td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
								<td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/></td>
								<td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
								<td><a href="/backend/wayBill/remove/${wb.wayBillId}" >取消</a></td>
							</tr>
					</c:forEach>
							<tr >
								<td>合计</td>
								<td><fmt:formatNumber value = "${totalFreight}" type = "number"/></td>
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
							<div style="width:40%">数量总计 </div>
							<div ><p>${totalQuantity}</p></div>
						</div>
						<div style="display:flex;flex-direction:row;margin:5px">
							<div style="width:40%">商品总价 </div>
							<div ><p><fmt:formatNumber value = "${totalItemCN}" maxFractionDigits="2" type = "number"/>¥(<fmt:formatNumber value = "${totalItemVN}" maxFractionDigits="0" type = "number"/>đ)</p></div></div>
						<div style="display:flex;flex-direction:row;margin:5px">
							<div style="width:40%">运费  </div>
							<div ><p><fmt:formatNumber value = "${saol.shipFeeCNY}" maxFractionDigits="2" type = "number"/> ¥(<fmt:formatNumber value = "${saol.shipFeeVND}" maxFractionDigits="0" type = "number"/>đ)</p></div>
						</div>
						<div style="display:flex;flex-direction:row;margin:5px">
							<div style="width:40%">合计  </div>
							<div ><p><fmt:formatNumber value = "${totalItemCN+saol.shipFeeCNY}" maxFractionDigits="2" type = "number"/> ¥(<fmt:formatNumber value = "${totalItemVN+saol.shipFeeVND}" maxFractionDigits="0" type = "number"/>đ)</p></div>
						</div>
						<div style="display:flex;flex-direction:row;margin:5px">
							<div style="width:40%">总共  </div>
							<div ><p><fmt:formatNumber value = "${totalFreight+totalItemVN+saol.shipFeeVND}" maxFractionDigits="0" type = "number"/> đ</p></div>
						</div>
		</div>
				</article>
						<c:set var="totalQuantity" value="0"></c:set>
				        <c:set var="totalItemCN" value="0"></c:set>
				        <c:set var="totalItemVN" value="0"></c:set>
				        <c:set var="totalFreight" value="0"></c:set>

				</c:forEach>
					<div class="KG" style="margin: 5px">
						<article class="stat-cards-item" style="margin: 5px">
							<div style="font-size:30px;text-align:center;margin:3px;width:100%">
								<p >ĐƠN HÀNG KI GỬI</p>
							</div>
							<div style="margin:3px;width:100%">
								<table>
									<tr>
										<th></th>
										<th>运单号</th>
										<th>小计</th>
										<th>客户</th>
										<th>收到日</th>
										<th>Kg</th>
										<th>m3</th>
										<th>KG 汇率</th>
										<th>M3 汇率</th>
										<th></th>
									</tr>
									<c:forEach items="${showKGwaybillsListofAdMin}" var="wbKG" >
										<c:set var="totalFreightKG" value="${totalFreightKG + wbKG.freight}"></c:set>
										<tr >
											<td><a href="/backend/wayBill/confirm/${wbKG.wayBillId}" >成功</a></td>
											<td>${wbKG.wayBillCode}</td>
											<td>${wbKG.freight}</td>
											<td>${wbKG.wbUserName}</td>
											<td><fmt:formatDate value = "${wbKG.arriveredDate}" type = "date"/></td>
											<td><fmt:formatNumber value = "${wbKG.kg}" type = "number"/></td>
											<td><fmt:formatNumber value = "${wbKG.cubic}" type = "number"/></td>
											<td><fmt:formatNumber value = "${wbKG.rateKg}" type = "number"/> </td>
											<td><fmt:formatNumber value = "${wbKG.rateCubic}" type = "number"/></td>
											<td><a href="/backend/wayBill/remove/${wbKG.wayBillId}" >取消</a></td>
										</tr>
									</c:forEach>
									<tr style="color:red">
										<td></td>
										<td>运费合计</td>
										<td><fmt:formatNumber value = "${totalFreightKG}" type = "number"/></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<input type="text"  value = "${totalFreightKG}" id="freightKG"   hidden/>
									</tr>
								</table>
							</div>
						</article>
					</div>
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
										<a class="page-link" href="/backend/order/arrivered?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
									</li></div>
								<c:forEach begin="1" end="${total}" step="1" var="num">
									<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
										<a class="page-link" href="/backend/order/arrivered?page=${num}&perpage=${perpage}">${num}</a>
									</li></div>
								</c:forEach>
								<div>
									<li class="page-item <c:if test="${page == total}">disabled</c:if>">
										<a class="page-link" href="/backend/order/arrivered?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
									</li></div>
							</div>
						</ul>
					</nav>
				</div>
				<ul class="footer-end">
					<li><p>收到订单总额 ： <fmt:formatNumber value = "${totalCN}" type="number"/>¥(<fmt:formatNumber value = "${totalVN}" maxFractionDigits="0" type="number"/>đ)</p></li>
					<li><p>运费总额 ： <fmt:formatNumber value = "${totalFreightVN}" type="number"/>đ</p></li>
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


