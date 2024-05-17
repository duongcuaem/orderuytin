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
		<nav class="main-nav--bg" style="background-color: black">
			<div class="container main-nav">
				<div class="main-nav-start">
					<form  action="/user/search/searchOrder" method="post">
						<div class="search-wrapper" style="display:flex;flex-direction:row">
							<i data-feather="search" aria-hidden="true"></i>
							<input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng qua miêu tả sản phẩm !!! ..." required>
							<button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;boder-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
						</div>
					</form>
				</div>
				<div class="main-nav-end">
					<button class="sidebar-toggle transparent-btn" class="mainnavIcon" title="Menu" type="button">
						<span class="sr-only">Toggle menu</span>
						<span class="icon menu-toggle--gray" aria-hidden="true"></span>
					</button>

					<div style="color:white;font-size:35px" >
						<a href="/user/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
					</div>

					<div style="color:white;font-size:35px" ><a href="/user/home"><i class="fa-solid fa-house-user"></i> </a> </div>
					<div style="color:white;">
						<a href="/user/item/cart">
							<p style="color:red;font-size:15px;float:right">${countCartItem}</p> <i style="font-size:35px" class="fa-solid fa-cart-shopping"></i>
						</a>
					</div>

					<div >
						<!-- Add a logout button -->
						<form:form action="/logout"   method="POST">
							<button type="submit"  style="color:white;background-color:black;font-size:35px"><i class="fa-solid fa-right-from-bracket"></i></button>
						</form:form>
					</div>
				</div>
			</div>
			<div style="display:flex;flex-direction:row;justify-content:space-between;margin:5px;text-align:center;color:white">
				<div>
					<p style="font-size:15px;float:right">${countWholeOrder}</p> </br><a style="font-size:15px;" href="/user/order/whole">Tất cả</a>
				</div>
				<div>
					</br>|</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countPendingOrder}</p>  </br><a style="font-size:15px"  href="/user/order/pending"> Chờ mua </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countBoughtOrder}</p></br> <a style="font-size:15px"  href="/user/order/bought"> Đã mua</a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countDeliveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/deliveried"> Đã phát</a>
				</div>
				<div>
					</br>|</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countArriveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/arrivered">Về kho </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countComplainOrder}</p> </br><a style="color:yellow;font-size:25px;font-weight:bold"  href="/user/order/complain"> Khiếu nại </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div >
					<p style="font-size:15px;float:right">${countFinishedOrder}</p></br> <a style="font-size:15px"  href="/user/order/finished"> Thành công </a>
				</div>
				<div>
					</br> |</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countCancelOrder+countCancelItem}</p></br> <a style="font-size:15px"  href="/user/order/cancel"> Đơn huỷ  </a>
				</div>
			</div>
		</nav>

		<!-- ! Main -->
		<main class="main users chart-page" id="skip-target" style="height: 70vh; overflow: scroll">
			<div class="container">
				<div class="row stat-cards">

					<c:forEach items="${showComplainOrderListfofClient}" var="scol" >
						<c:set var="totalRefundOrder" value="${totalRefundOrder + scol.totalVN}"></c:set>
						<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

						<div style="display:flex;flex-direction:row;justify-content:space-between;width:100%">
								<div style="width:50%;margin-right:10px">Ngày đặt :</br><fmt:formatDate type = "date" value = "${scol.receivedDate}" /></div>
								<div style="width:50%">Mã đơn hàng :</br>${scol.orderNo} </div>
							</div>
							<c:forEach items="${scol.items}" var="i" >
								<c:set var="totalQuantity" value="${totalQuantity + i.quantity }"></c:set>
								<c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
								<c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
								<div style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">>
									<div style="padding:5px;margin:2px;border-radius:10px;border-style:solid;border-width: thin;border-color:white;display:flex" >
										<div >
											<img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" >
										</div>
										<div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:10px">
											<div style="width:100%"> <a href="${i.link}"> Click Link :</a>  <input style="width:100px" value="${i.link}"  /></div>
											<div style="width:100%"> ${i.describle}</div>
											<div style="width:100%"> Giá : <fmt:formatNumber value = "${i.price}" type = "number"/> ¥</div>
											<div style="width:100%"> Số lượng : ${i.quantity}</div>
											<div style="width:100%"> Tỉ giá : ${i.CNYrateVND} ¥/đ</div>
											<div style="width:100%"> Thành tiền : <fmt:formatNumber value = "${i.price*i.quantity}" type = "number"/> ¥</div>
											<div style="width:100%">  =  <fmt:formatNumber value = "${i.price*i.quantity*i.CNYrateVND}" maxFractionDigits="0" type = "number"/> đ</div>
										</div>
									</div>
									<div style="display:flex;flex-direction:column;justify-content: space-between;width:100%;margin-left:10px">
										<div style="display:flex;flex-direction:row;width:100%;color:red"> Khiếu nại   :  ${i.userNote} </div>
										<div style="display:flex;flex-direction:row;width:100%"> Phản hồi   :  ${i.adminNote} </div>
										<div style="display:flex;flex-direction:row;width:100%"> Hoàn tiền   :  <fmt:formatNumber value = "${i.price*i.quantityRefund*i.CNYrateVND}" maxFractionDigits="0" type = "number"/>đ </div>
										<div style="display:flex;flex-direction:row;width:100%"> Ngày hoàn   :  <fmt:formatDate type = "date" value = "${i.refundDate}" /> </div>
									</div>
								</div>
							</c:forEach >

							<div style="margin:3px;width:100%">
								<table>
									<tr>
										<th>Mã vận đơn</th>
										<th>Thành tiền</th>
										<th style="font-size:20px">Ngàyvềkho</th>
										<th>Kg</th>
										<th>M3</th>
										<th>Tỉ giá kg</th>
										<th>Tỉ giá m3</th>
									</tr>
									<c:forEach items="${scol.waybills}" var="wb" >
										<c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
										<tr >
											<td>${wb.wayBillCode}</td>
											<td>${wb.freight}</td>
											<td><fmt:formatDate value = "${wb.arriveredDate}" type = "date"/></td>
											<td><fmt:formatNumber value = "${wb.kg}" type = "number"/></td>
											<td><fmt:formatNumber value = "${wb.cubic}" type = "number"/></td>
											<td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/> </td>
											<td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
										</tr>
									</c:forEach>
									<tr >
										<td>Tổng cước</td>
										<td><fmt:formatNumber value = "${totalFreight}" type = "number"/></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</table>
							</div>
							<div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px;width:80%">
								<div style="display:flex;flex-direction:row;margin:5px">Tổng số lượng sp trong đh : ${totalQuantity}</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:40%">Tiền hàng </br><p style="font-weight: bold">(ko ship nđ) </p></div>
									<div><p>  <fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN}" type = "number"/> đ ( <fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥ )</p></div>
								</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:40%">Ship nội địa  </div>
									<div><p> <fmt:formatNumber maxFractionDigits="0" value = "${scol.shipFeeVND}" type = "number"/> đ ( <fmt:formatNumber value = "${scol.shipFeeCNY}" type = "number"/> ¥ )</p></div>
								</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:40%">Tiền hàng  </br><p style="font-weight: bold">(có ship nđ)</p></div>
									<div><p>  <fmt:formatNumber maxFractionDigits="0" value = "${scol.totalVN}" type = "number"/> đ (<fmt:formatNumber value = "${scol.totalCN}" type = "number"/> ¥ )</p></div>
								</div>
								<div style="display:flex;flex-direction:row;margin:5px">
									<div style="width:40%">Tổng tiền đh </br><p style="font-weight: bold">(gồm cước vc) </p></div>
									<div><p><fmt:formatNumber maxFractionDigits="0" value = "${scol.totalVN+totalFreight}" type = "number"/> đ</p></div>
								</div>
							</div>
						</article>
						<c:set var="totalQuantity" value="0"></c:set>
						<c:set var="totalItemCN" value="0"></c:set>
						<c:set var="totalItemVN" value="0"></c:set>
						<c:set var="totalFreight" value="0"></c:set>
					</c:forEach>
				</div>
			</div>


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
