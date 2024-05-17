<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			$(".quantityReFund").change( function(){
				let id = $(this).attr('id') ;
				let itemID = id.substring(14);
				let quantityReFundID = 'quantityReFund' + itemID;
				let refundVNID = 'refundVN' + itemID;
				let priceID = 'price' + itemID;
				let CNYrateVNDID = 'CNYrateVND' + itemID;
				$("#"+refundVNID).val((Number($("#"+quantityReFundID).val())
						* Number($("#"+priceID).val())
						*Number($("#"+CNYrateVNDID).val()))
						.toFixed(0));
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
		<nav class="main-nav--bg" style="background-color: black">
			<div class="container main-nav">

				<div class="main-nav-end">
					<button class="sidebar-toggle transparent-btn" class="mainnavIcon" title="Menu" type="button">
						<span class="sr-only">Toggle menu</span>
						<span class="icon menu-toggle--gray" aria-hidden="true"></span>
					</button>

					<div style="color:white;font-size:35px" >
						<a href="/backend/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
					</div>
					<div style="color:white;font-size:35px" >
						<a href="/backend/user/userList"><i class="fa-solid fa-users" aria-hidden="true" "></i></a>
					</div >
					<div style="color:white;font-size:35px" >
						<a href="/backend/chargMoney/chargForm"><i class="fa-solid fa-money-check-dollar"></i></a>
					</div>
					<div style="color:white;font-size:35px" ><a href="/backend/home"><i class="fa-solid fa-house-user"></i> </a> </div>
					<div style="color:white;">
						<a href="/backend/item/cart">
							<p style="color:red;font-size:15px;float:right">${countCartItemAdmin}</p> <i style="font-size:35px" class="fa-solid fa-cart-shopping"></i>
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
					<p style="font-size:15px;float:right">${countFixOrderAdmin}</p></br> <a style="font-size:15px" href="/backend/order/fix">改单</a>
				</div>
				<div>
					</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countPendingOrderAdmin}</p>  </br><a style="font-size:15px"  href="/backend/order/pending"> 等买 </a>
				</div>
				<div>
					</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countBoughtOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/bought"> 已买</a>
				</div>
				<div>
					</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countDeliveredOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/deliveried"> 已发</a>
				</div>
				<div>
					</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countArriveredOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/arrivered">已到 </a>
				</div>
				<div>
					</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countComplainOrderAdmin}</p> </br><a style="color:yellow;font-size:25px;font-weight:bold"  href="/backend/order/complain"> 投诉 </a>
				</div>
				<div>
					</br>|
				</div>
				<div >
					<p style="font-size:15px;float:right">${countFinishedOrderAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/finished">成功</a>
				</div>
				<div>
					</br>|
				</div>
				<div>
					<p style="font-size:15px;float:right">${countCancelOrderAdmin+countCancelItemAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/cancel">取消 </a>
				</div>
			</div>
		</nav>
		<!-- ! Main -->
		<main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
			<div class="container">
				<div class="row stat-cards">
					<c:forEach items="${showComplainOrderList}" var="scol" >
						<div style="margin:10px">
							<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

							<div style="display:flex;flex-direction:row;width:100%">
									<div style="width:30%;margin-right:10%"><fmt:formatDate value = "${scol.receivedDate}" type = "date"/></div>
									<div style="margin-right:10%">${scol.orderNo}</div>
									<div > ${scol.orderUserName}</div>
								</div>

								<div class="row">
									<c:forEach items="${scol.items}" var="i" >
										<c:set var="totalQuantity" value="${totalQuantity + i.quantity }"></c:set>
										<c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
										<c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
										<form:form method="post" id="form${i.itemId}" action="/backend/item/saveItemFix" modelAttribute="itemDAO">
											<div style="display: none">
										<input type="text" name="orderId"      value="${i.orderId}"       path="orderId"       />
										<input type="text" name="itemId"       value="${i.itemId}"        path="itemId"        />
										<input type="text" name="itemUserName" value="${i.itemUserName}"  path="itemUserName"  />
										<input type="text" name="image"        value="${i.image}"         path="image"         />
										<input type="text" name="itemStatus"   value="Da mua hang"        path="itemStatus"    />
										<input type="text" name="userNote"     value="${i.userNote}"      path="userNote"      />
										<input type="text" name="price"        value="${i.price}"         path="price"         id="price${i.itemId}" />
										<input type="text" name="quantity"     value="${i.quantity}"      path="quantity"      />
										<input type="text" name="describle"    value="${i.describle}"     path="describle"     />
										<input type="text" name="link"         value="${i.link}"          path="link"          />
										<input type="text" name="CNYrateVND"   value="${i.CNYrateVND}"    path="CNYrateVND"    id="CNYrateVND${i.itemId}" />
										<input type="text" name="refundDate"   value="<%=java.time.LocalDate.now()%>"    path="refundDate"  />
								            </div>
											<div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:column;margin:2px">
											<div style="display:flex;flex-direction:column">
												<div style="width:100%">
													<div style="display:flex" >
														<div style="display:flex;flex-direction:column">
															<img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" >
														</div>
														<div style="display:flex;flex-direction:column;justify-content: space-between;margin-left:10px">
															<div style="width:100%;"><a href="${i.link}"> 链接 </a> <input type="text" style="width:80px" value="${i.link}" /></div>
															<div style="width:100%;"> ${i.describle}</div>
															<div style="width:100%;"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity} = <fmt:formatNumber value = "${i.price * i.quantity}" type = "number"/> ¥</div>
															<div style="width:100%;"> x ${i.CNYrateVND}đ/¥ = <fmt:formatNumber maxFractionDigits="0" value = "${i.price * i.quantity*i.CNYrateVND}" type = "number"/> đ</div>
															<div style="width:100%;display:flex;flex-direction:row;color:red">投诉 <p >${i.userNote}</p></div>
															<div style="width:100%;display:flex;flex-direction:row">反馈 <p >${i.adminNote}</p></div>
															<div style="width:100%;display:flex;flex-direction:row">退款 <p ><fmt:formatNumber maxFractionDigits="0" value = "${i.quantityRefund*i.price*i.CNYrateVND}" type = "number"/> đ </p></div>
															<div style="width:100%;display:flex;flex-direction:row">退款时间 <p ><fmt:formatDate value = "${i.refundDate}" type = "date"/></p></div>

															<div style="width:100%;color:black;display:flex;flex-direction:row;justify-content: space-between;margin:2px">
																<input type="text"  class="adminNote" name="adminNote" placeholder="反馈" style="margin:2px" value=""  path="adminNote" />
																<button  type="submit" style="border-radius:5px;padding:5px;background-color:#0022ff;color:red;margin:2px">反馈</button></div>
														</div>
													</div>
													<div style="display:flex;flex-direction:row;justify-content: space-evenly;">
														<input type="text"  id="quantityReFund${i.itemId}" class="quantityReFund" style="width:80px;margin:2px" name="quantityRefund"  value=""  path="quantityRefund" placeholder="数量"/>
														<input type="text"  id="refundVN${i.itemId}"       class="refundVN"       style="width:120px;margin:2px" name="refundVN"        value=""  path="refundVN"       placeholder="退款"/>
													</div>
												</div>
											</div>
										</div>
										</form:form>
									</c:forEach >

								</div>

								<div style="margin:3px;width:100%">
									<table>
										<tr >
											<th>运单号</th>
											<th>小计</th>
											<th>收到日</th>
											<th>Kg</th>
											<th>m3</th>
											<th>Kg汇率</th>
											<th>M3 汇率</th>
										</tr>
										<c:forEach var="wb" items="${scol.waybills}">
											<c:set var="totalFreight" value="${totalFreight + wb.freight}"></c:set>
										<tr >
											<td>${wb.wayBillCode}</td>
											<td>${wb.freight}</td>
											<td><fmt:formatDate type = "date" value = "${wb.arriveredDate}" /></td>
											<td>${wb.kg}</td>
											<td>${wb.cubic}</td>
											<td><fmt:formatNumber value = "${wb.rateKg}" type = "number"/> </td>
											<td><fmt:formatNumber value = "${wb.rateCubic}" type = "number"/></td>
										</tr>
										</c:forEach>
										<tr >
											<td>运费合计</td>
											<td><fmt:formatNumber maxFractionDigits="0" value = "${totalFreight}" type = "number"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>
								<div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px;width:100%">
								<form:form method="post"  action="/backend/order/saveFix" modelAttribute="ordersDAO">
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:30%">数量总计 </div>
										<div ><p>${totalQuantity}</p></div>
									</div>
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:30%">商品总价</div>
										<div ><p><fmt:formatNumber value = "${totalItemCN}" type = "number"/> ¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN}" type = "number"/> đ)</p></div>
									</div>
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:30%">运费 </div>
										<div ><p>  <fmt:formatNumber value = "${scol.shipFeeCNY}" type = "number"/> ¥(<fmt:formatNumber maxFractionDigits="0" value = "${scol.shipFeeVND}" type = "number"/> đ)</p></div>
									</div>
									<div style="display:flex;flex-direction:row;margin:5px">
										<div style="width:30%">合计 </div>
										<div ><p>  <fmt:formatNumber value = "${scol.totalCN}" type = "number"/> ¥(<fmt:formatNumber maxFractionDigits="0" value = "${scol.totalVN}" type = "number"/> đ)</p></div>
									</div>
									<div style="display:flex;flex-direction:row;justify-content:space-between;margin:2px">
										<div >总共</div>
										<fmt:formatNumber maxFractionDigits="0" value = "${scol.totalVN+totalFreight}" type = "number"/>đ
										<div style="margin:5px">
											<select name="orderStatus" path="orderStatus">
												<option value="Da phat hang">Đã phát hàng</option>
												<option value="Da ve kho">Về kho</option>
												<option value="Thanh cong">Thành công</option>
												<option value="Sua don">Chỉnh sửa đơn</option>
												<option value="Huy">Hủy</option>
											</select>
										</div>
										<button  type="submit" style="border-radius:5px;padding:5px;background-color:#0022ff;color:red">Cập nhật</button>
									</div>
									<div style="display:none">
											<input type="text"  name="shipFeeCNY"     value="${scol.shipFeeCNY}"      path="shipFeeCNY"    />
											<input type="text"  name="totalCN"        value="${scol.totalCN}"         path="totalCN"       />
											<input type="text"  name="shipFeeVND"     value="${scol.shipFeeVND}"      path="shipFeeVND"    />
											<input type="text"  name="totalVN"        value="${scol.totalVN}"         path="totalVN"       />
											<input type="text"  name="orderUserName"  value="${scol.orderUserName}"   path="orderUserName" />
											<input type="text"  name="receivedDate"   value="${scol.receivedDate}"    path="receivedDate"  />
											<input type="text"  name="orderId"        value="${scol.orderId}"         path="orderId"       />
											<input type="text"  name="orderNo"        value="${scol.orderNo}"         path="orderNo"       />
										</div>
									</form:form>
								</div>

							</article>
						</div>
						<c:set var="totalQuantity" value="0"></c:set>
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
										<a class="page-link" href="/backend/order/complain?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
									</li></div>
								<c:forEach begin="1" end="${total}" step="1" var="num">
									<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
										<a class="page-link" href="/backend/order/complain?page=${num}&perpage=${perpage}">${num}</a>
									</li></div>
								</c:forEach>
								<div>
									<li class="page-item <c:if test="${page == total}">disabled</c:if>">
										<a class="page-link" href="/backend/order/complain?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
									</li></div>
							</div>
						</ul>
					</nav>
				</div>

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
