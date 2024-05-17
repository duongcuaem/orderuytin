<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
	<link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			$(".Edit").click( function Edit(){
				let id = $(this).attr('id') ;
				let itemID = id.substring(4);
				let itemStatusId = "itemStatus" + itemID;
				let formId = "form" + itemID;
				document.getElementById(itemStatusId).value = 'Gio hang';
				document.getElementById(formId).submit();
			});
			$(".BuyIt").click( function BuyIt(){
				let id = $(this).attr('id') ;
				let itemID = id.substring(5);
				let itemStatusId = "itemStatus" + itemID;
				let formId = "form" + itemID;
				document.getElementById(itemStatusId).value = 'Cho xu ly';
				document.getElementById(formId).submit();
			});
		});
	</script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
	<!-- ! Sidebar -->
	<jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
	<div class="main-wrapper">
		<!-- ! Main nav -->
	<jsp:include page="/WEB-INF/views/commonUsers/mainnav.jsp"></jsp:include>

		<!-- ! Main -->
	<main class="main users chart-page" id="skip-target">
		<div class="container">
			<p style="color: red">${message}</p>
			<div class="row stat-cards">
				<c:forEach items="${showItemCartList}" var="sicl" >
					<c:set var="totalQuantity" value="${totalQuantity + sicl.quantity }"></c:set>
					<c:set var="totalCN" value="${totalCN + sicl.price *sicl.quantity }"></c:set>
					<c:set var="totalVN" value="${totalVN + sicl.price * sicl.quantity*sicl.CNYrateVND }"></c:set>
				<div class="col-md-6 col-xl-4" style="margin-bottom:10px" >
				<article class="stat-cards-item" style="margin-right:2px">
					<form:form method="post" id="form${sicl.itemId}" action="/user/item/saveItemPending" modelAttribute="itemDAO">
						<div style="display:flex;flex-direction:row;width:100%">
							<div><a class="secondary-default-btn" style="width:20%" href="/user/item/updateCancel/${sicl.itemId}">Xóa</a></div>
							<div style="margin-left:5%"><button id="Edit${sicl.itemId}" class = "Edit"   style="border-radius:3px;padding:2px;background-color:#ff0015">Chỉnh sửa đơn</button ></div>
							<div style="margin-left:5%"><button id="BuyIt${sicl.itemId}" class = "BuyIt"  style="border-radius:3px;padding:2px;background-color:#00ff15" >Mua ngay</button ></div>
						</div>
						<div style="display:flex;flex-direction:row;width:80%" >
							 <div style="margin-right:10px;width:30%">
								<img alt="image" src="<c:url value="/image/item/${sicl.image}" />" style="width:80px;height:150px;margin: 5px">
								<div style="width:100px;color:#5eff00">Tỉ giá ${loginUser.rate}</div>
							 </div>
							 <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%">
								<div style="display:flex;flex-direction:row;width:95%">
									<div style="text-align:center;width:50%"><label for="link" class="form-label"><a href="${sicl.link}"> Click Link :</a> </label> </div>
									<div style="width:50%;margin:5px"> <input type="text"id="link" id="link" name="link" style="width:150px" value="${sicl.link}"  path="link"/></div>
								</div>
								<div style="display:flex;flex-direction:row;width:95%">
									<div style="text-align:center;width:50%"><label for="describle" class="form-label">Miêu tả</label> </div>
									<div style="width:50%;margin:5px"> <input type="text"  id="describle" name="describle" style="width:150px" value="${sicl.describle}"  path="describle"/></div>
								</div>
								<div style="display:flex;flex-direction:row;width:95%">
									<div style="text-align:center;width:50%"><label for="price${sicl.itemId}" class="form-label">Giá </label>  </div>
									<div style="width:50%;margin:5px"><input type="text"  id="price${sicl.itemId}" name="price" style="width:150px" value="${sicl.price}"  path="price" />  <br></div>
								</div>
								<div style="display:flex;flex-direction:row;width:95%" >
									<div style="text-align:center;width:50%"><label for="quantity${sicl.itemId}" class="form-label">Số lượng</label>  </div>
									<div style="width:50%;margin:5px"><input type="text"  id="quantity${sicl.itemId}" name="quantity" style="width:150px"  value="${sicl.quantity}"   path="quantity" />  <br></div>
								</div>
							</div>
							<div style="display:none">
								<input type="text"  name="image"          value="${sicl.image}"          path="image"       />
								<input type="text"  name="itemId"         value="${sicl.itemId}"         path="itemId"      />
								<input type="text"  name="itemUserName"   value="${sicl.itemUserName}"   path="itemUserName"/>
								<input type="text"  name="CNYrateVND"     value="${loginUser.rate}"     path="CNYrateVND"  />
								<input type="text"  name="itemStatus"     value=""    id="itemStatus${sicl.itemId}"          path="itemStatus"   />
							</div>
						</div>
					<div style="text-align:center;color:red;border-radius:10px;background-color:#cde1e7;width:95%" >Thành tiền   : <fmt:formatNumber maxFractionDigits="0" value = "${sicl.quantity*sicl.price*loginUser.rate}" type = "number"/> đ ( <fmt:formatNumber maxFractionDigits="2" value = "${sicl.quantity*sicl.price}" type = "number"/> ¥ )  </div>
					</form:form>
		</article>
				</div>
				</c:forEach>
		</div>
   </div>

	</main>
	<footer class="footer">
		<div class="container footer--flex">
			<div class="footer-start">
				<nav aria-label="..." style="width:300px">
				<ul class="pagination">
					<div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
						<div>
							<li class="page-item <c:if test="${page == 1}">disabled</c:if>">
								<a class="page-link" href="/user/item/cart?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
							</li></div>
						<c:forEach begin="1" end="${total}" step="1" var="num">
							<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
								<a class="page-link" href="/user/item/cart?page=${num}&perpage=${perpage}">${num}</a>
							</li></div>
						</c:forEach>
						<div>
							<li class="page-item <c:if test="${page == total}">disabled</c:if>">
								<a class="page-link" href="/user/item/cart?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
							</li></div>
					</div>
				</ul>
			</nav>
			</div>
			<ul class="footer-end">
				<li><p>Tổng số lượng hàng trong giỏ： ${totalQuantity}</p> </li>
				<li><p>Tổng tiền hàng trong giỏ  ：<fmt:formatNumber value = "${totalVN}" type="number" maxFractionDigits="0"/>đ(<fmt:formatNumber value = "${totalCN}" type="number" maxFractionDigits="2"/>¥)</p></li>
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


