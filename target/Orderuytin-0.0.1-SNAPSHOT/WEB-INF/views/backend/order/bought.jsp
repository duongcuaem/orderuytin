<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<script>
		$(document).ready(function(){
			$(".Submit").click( function removeItem() {
				let id = $(this).attr('id') ;
				let orderId = id.substring(6);
				let formOrderId = 'formOrder' + orderId;
				document.getElementById(formOrderId).submit();
			});

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
		<jsp:include page="/WEB-INF/views/common/mainnavSearchOrder.jsp"></jsp:include>

		<!-- ! Main -->
		<main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
			<div class="container">
				<div style="display:flex;flex-direction:row;justify-content: space-between;">
					<div><p >${message}</p></div>
				</div>
				<div class="row stat-cards">
		<c:forEach items="${showBoughtOrderList}" var="sbol" >
			<c:set var="totalCN" value="${totalCN + sbol.totalCN }"></c:set>
			<c:set var="totalVN" value="${totalVN + sbol.totalVN }"></c:set>
		<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
			<div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
				<div >  <fmt:formatDate value = "${sbol.receivedDate}" type = "date"/></div>
				<div > ${sbol.orderNo} </br>${sbol.orderUserName}</div>
			</div>
			<form:form method="post" id="formOrder${sbol.orderId}" action="/backend/wayBill/saveWayBill" modelAttribute="wayBillDAO">
				<div style="display: none">
					<input type="text"  name="orderId"       value="${sbol.orderId}"         path="orderId" />
					<input type="text"  name="totalVN"       value="${sbol.totalVN}"         path="totalVN" />
					<input type="text"  name="orderNo"       value="${sbol.orderNo}"         path="orderNo" />
					<input type="text"  name="totalCN"       value="${sbol.totalCN}"         path="totalCN" />
					<input type="text"  name="shipFeeCNY"    value="${sbol.shipFeeCNY}"      path="shipFeeCNY" />
					<input type="text"  name="shipFeeVND"    value="${sbol.shipFeeVND}"      path="shipFeeVND" />
					<input type="text"  name="wbUserName"    value="${sbol.orderUserName}"   path="wbUserName" />
					<input type="text"  name="receivedDate"  value="${sbol.receivedDate}"    path="receivedDate" />
					<input type="text"  name="orderUserName" value="${sbol.orderUserName}"   path="orderUserName" />
				</div>
				<div style="display:flex;flex-direction:row;justify-content: space-between;mararrivergin:10px">
					<div style="display:flex;flex-direction:column" >
						<div style="margin:5px">
							<input type="text" name="wayBillCode" style="width:170px" placeholder="Hãy điền mã vận đơn"  path="wayBillCode"/>
							<input type="button" class="Submit" id="Submit${sbol.orderId}" value="Cập nhật" style="border-radius:5px;padding:10px;background-color:#0022ff"/>
						</div>
						<div >
							<select name="orderStatus" path="orderStatus">
								<option value="Da phat hang">Đã phát hàng</option>
								<option value="Da mua hang">Đã mua hàng</option>
								<option value="Khieu nai">Khiếu nại</option>
								<option value="Sua don">Chỉnh sửa đơn</option>
								<option value="Huy">Hủy</option>
						    </select>
						</div>
					</div>
				</div>

			</form:form>
			<div style="display:flex";>
				<c:forEach items="${sbol.items}" var="i" >
					<c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
					<c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
					<div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:row;margin:2px">
						<div style="display:flex;flex-direction:column;">
							<div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
							<div ><a style="color:red" href="/backend/item/detail/${i.itemId}">编辑</a></div>
							<input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
						</div>
						<div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:5px">
							<div style="width:100%"><a href="${i.link}"> 链接 </a> <input type="text" style="width:80px" value="${i.link}" /></div>
							<div style="width:100%"> ${i.describle}</div>
							<div style="width:100%"><fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity} </div>
							<div style="width:100%"> =<fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/>¥</div>
							<div style="width:100%"> x ${i.CNYrateVND}đ/¥</div>
							<div style="width:100%"> =<fmt:formatNumber value = "${i.quantity*i.price*i.CNYrateVND}" maxFractionDigits="0" type = "number"/>đ</div>
						</div>
					</div>
				</c:forEach >
				<div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px">
					<div style="margin:5px;text-align:center">
						<div style="width:100%" >商品总价 : </div>
						<div style="width:100%"><p> <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥ (<fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN}" type = "number"/>đ)</p></div>
					</div>
					<div style="margin:5px;text-align:center">
						<div >运费 :</div>
						<div ><p> <fmt:formatNumber value = "${sbol.shipFeeCNY}" type = "number"/> ¥ (<fmt:formatNumber value = "${sbol.shipFeeVND}" type = "number"/>đ)</p></div>
					</div>
					<div style="margin:5px;text-align:center">
						<div >合计 :</div>
						<div ><p> <fmt:formatNumber value = "${totalItemCN+sbol.shipFeeCNY}" type = "number"/> ¥ (<fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN+sbol.shipFeeVND}" type = "number"/>đ)</p></div>
					</div>
				</div>
			</div>
		</article>
			<c:set var="totalItemCN" value="0"></c:set>
			<c:set var="totalItemVN" value="0"></c:set>
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
										<a class="page-link" href="/backend/order/bought?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
									</li></div>
								<c:forEach begin="1" end="${total}" step="1" var="num">
									<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
										<a class="page-link" href="/backend/order/bought?page=${num}&perpage=${perpage}">${num}</a>
									</li></div>
								</c:forEach>
								<div>
									<li class="page-item <c:if test="${page == total}">disabled</c:if>">
										<a class="page-link" href="/backend/order/bought?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
									</li></div>
							</div>
						</ul>
					</nav>
				</div>
				<ul class="footer-end">
					<li> <p>购买订单总额 ： <fmt:formatNumber value = "${totalCN}" type="number"/>¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalVN}" type="number"/>đ)</p></li>
				</ul>
			</div>
		</footer>
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


