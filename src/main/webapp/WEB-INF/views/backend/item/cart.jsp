<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
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
		<jsp:include page="/WEB-INF/views/common/mainnav.jsp"></jsp:include>

		<!-- ! Main -->
			<main class="main users chart-page" id="skip-target" style="height: 70vh; overflow: scroll">
				<div class="container">
					<div style="display:flex;flex-direction:column;">
						<div style="font-size:30px;text-align:center"><p >采购车</p></div>
					</div>
					<p style="color: red">${message}</p>
					<div class="row stat-cards">
						<c:forEach items="${showItemCartAdminList}" var="i" >
							<c:set var="totalQuantity" value="${totalQuantity + i.quantity }"></c:set>
							<c:set var="totalCN" value="${totalCN + i.price *i.quantity }"></c:set>
							<c:set var="totalVN" value="${totalVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
						<div class="col-md-6 col-xl-4" style="margin-bottom:10px" >
							<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

							<div style="display:flex;flex-direction:row;justify-content: space-between;width:100%">
									<div >${i.itemUserName}</div>
									<div ><a style="color:red;float:right"  href="/backend/item/detail/${i.itemId}">编辑</a></div>
								</div>
								<div style="display:flex;flex-direction:row;width:80%" >
									<div style="display:flex;flex-direction:column;width:30%;height:100%">
										<div><img id="outputImage${i.itemId}" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin: 5px"/> </div>
										<input type="text" class="form-control" id="fileuploadName${i.itemId}" name="image" value="" path="image" hidden />
										<div style="width:100px;color:#5eff00">汇率 ${i.CNYrateVND}</div>
									</div>
									 <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%">
										<div style="display:flex;flex-direction:row;width:95%">
											<div style="text-align:center;width:50%"><label for="link" class="form-label"><a href="${i.link}"> 链接 </a></label> </div>
											<div style="width:50%;margin:5px"> <input type="text" id="link" id="link" name="link" style="width:150px" value="${i.link}"  path="link"/></div>
										</div>
										<div style="display:flex;flex-direction:row;width:95%">
											<div style="text-align:center;width:50%"><label for="describle" class="form-label">描述</label> </div>
											<div style="width:50%;margin:5px"> <input type="text"  id="describle" name="describle" style="width:150px" value="${i.describle}"  path="describle"/></div>
										</div>
										<div style="display:flex;flex-direction:row;width:95%">
											<div style="text-align:center;width:50%"><label for="price${i.itemId}" class="form-label">价格</label>  </div>
											<div style="width:50%;margin:5px"><input type="text"  id="price${i.itemId}" name="price" style="width:150px" value="${i.price}"  path="price" />  <br></div>
										</div>
										<div style="display:flex;flex-direction:row;width:95%" >
											<div style="text-align:center;width:50%"><label for="quantity${i.itemId}" class="form-label">数量</label>  </div>
											<div style="width:50%;margin:5px"><input type="text"  id="quantity${i.itemId}" name="quantity" style="width:150px"  value="${i.quantity}"   path="quantity" />  <br></div>
										</div>
									 </div>
                                     <div style="display:none">
										<input type="text"  name="itemId"         value="${i.itemId}"         path="itemId"      />
										<input type="text"  name="itemUserName"   value="${i.itemUserName}"   path="itemUserName"/>
										<input type="text"  name="CNYrateVND"     value="${i.CNYrateVND}"     path="CNYrateVND"  />
										<input type="text"  name="itemStatus"     value=""    id="itemStatus${i.itemId}"          path="itemStatus"   />
                                     </div>
								</div>
							<div style="text-align:center;color:red;border-radius:10px;background-color:#cde1e7;width:95%" >小计   :  <fmt:formatNumber maxFractionDigits="2" value = "${i.quantity*i.price}" type = "number"/> ¥ ~~   <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ   </div>
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
										<a class="page-link" href="/backend/item/cart?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
									</li></div>
								<c:forEach begin="1" end="${total}" step="1" var="num">
									<div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
										<a class="page-link" href="/backend/order/pending?page=${num}&perpage=${perpage}">${num}</a>
									</li></div>
								</c:forEach>
								<div>
									<li class="page-item <c:if test="${page == total}">disabled</c:if>">
										<a class="page-link" href="/backend/order/cart?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
									</li></div>
							</div>
						</ul>
					</nav>
				</div>
				<ul class="footer-end">
					<li><p>数量总计  ： ${totalQuantity}</p> </li>
					<li><p>合计  ： <fmt:formatNumber value = "${totalCN}" type="number" maxFractionDigits="2"/>¥(<fmt:formatNumber value = "${totalVN}" type="number" maxFractionDigits="0"/>đ)</p></li>
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


