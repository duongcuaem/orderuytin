<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			$("#shipFeeCNY").change(function() {
				$("#shipFeeVND").val(Number($("#shipFeeCNY").val()) * Number($(".CNYrateVND").val()));
				$("#totalCN").val(Number($("#totalItemCN").val())+ Number($("#shipFeeCNY").val()));
				$("#totalVN").val(Number($("#totalItemVN").val())+ Number($("#shipFeeVND").val()));
			});
		});
	</script>
	<script>
		$(document).ready(function(){
			$("#fix").click( function handling(){
				let x= $("#orderNo").val();
				if(x==""){alert("Hãy nhập mã đơn hàng trước khi xử lý đơn.")}
				if(x!=""){
				document.getElementById('orderStatus').value = 'Sua don';
				document.getElementById('form').submit();}
			});
			$("#buyit").click( function handling(){
				let x = $("#orderNo").val();
				if(x == ""){alert("Hãy nhập mã đơn hàng trước khi xử lý đơn.")}
				if(x != ""){
				document.getElementById('orderStatus').value = 'Da mua hang';
				document.getElementById('form').submit();}
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
			<main class="main users chart-page" id="skip-target">
				<div class="container">
					<div class="row stat-cards">

					<form:form method="post" id = "form" action="/backend/order/insertMultiOrder" modelAttribute="ordersDAO">
						<article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
							<div class="row">
			<c:forEach items="${mergedList}" var="ml" >
				<c:set var="total"  value="${total + ml.price * ml.quantity }"></c:set>
				<c:set var="itemUserName"  value="${ml.itemUserName}"></c:set>
				<c:set var="CNYrateVND"  value="${ml.CNYrateVND}"></c:set>
				<c:set var="quantity"  value="${quantity+ml.quantity}"></c:set>
            <div style="margin: 5px;border-style:solid;border-width: thin;border-color:white">
				<div style="display:flex;flex-direction:column">
					<div style="display:flex;flex-direction:row;justify-content:space-between">
						<div style="margin:5px"> ${ml.itemUserName}</div>
						<div style="margin:5px"><a style="border-radius:5px;padding:2px;background-color:#ff0015;color:#ffffff"  href="/backend/item/remove/${ml.itemId}">Xóa</a></div>
					</div>
					<input type="text"name="itemId"  value=" ${ml.itemId}"  path="itemId"  hidden />
					<input type="text" name="itemUserName" value="${ml.itemUserName}"  path="itemUserName"  hidden/>
					<div style="width:100%">
						<div style="display:flex" >
							<div style="display:flex;flex-direction:column;width:30%;height:50%">
								<div > <img alt="image"  id="outputImage"  src="<c:url value="/image/item/${ml.image}" />" style="width:80px;height:150px;margin: 5px"></div>
								<input type="text" name="image"  value="${ml.image}"  path="image" hidden/>

							</div>
							<div style="display:flex;flex-direction:column;justify-content: space-between;width:70%">
								<div style="margin-left:10%">
									<a href="${ml.link}"> 链接 </a> <input type="text"  id="link" style="width:100px" name="link"  value="${ml.link}"  path="link" />
								</div>
								<div style="width:95%;text-align:center">
								${ml.describle} <input type="text"  id="describle" name="describle"  value="${ml.describle}"  path="describle" hidden />
								</div>
								<div style="display:flex;flex-direction:row;width:95%">
									<div style="text-align:center;width:50%"> 汇率 </div>
									<div style="width:50%;margin:5px"><input type="text"  class="CNYrateVND" style="width:80px" name="CNYrateVND"  value="${ml.CNYrateVND}"  path="CNYrateVND" />  <br></div>
								</div>
								<input type="text"  name="itemStatus"     value="Da mua hang"  path="itemStatus" hidden />
							</div>
						</div>
						<div style="display:flex;flex-direction:row;width:95%">
							<div style="display:flex;flex-direction:row">
								<div >价格 </div>
								<div style="margin:5px"><input type="text"  id="price" style="width:80px" name="price"  value="${ml.price}"  path="price" />  <br></div>
							</div>
							<div style="display:flex;flex-direction:row;margin-left: 2%" >
								<div >数量</div>
								<div style="margin:5px" ><input type="text"  id="quantity" style="width:50px" name="quantity"   value="${ml.quantity}"   path="quantity" />  <br></div>
							</div>
						</div>
						<div style="display:flex;flex-direction:row;width:95%">
							<div >   小计</div>
							<div style="margin:5px"><input type="text"  id="totalCNY" style="width:100px" name="totalCNY"  value="${ml.price*ml.quantity}"  path="totalCNY" /> </div>
							<div style="margin:5px"><input type="text"  id="totalVND" style="width:150px" name="totalVND"  value="${ml.price*ml.quantity*ml.CNYrateVND}"  path="totalVND" />  </div>
						</div>
					</div>
           </div>
         </div>
			</c:forEach>
							</div>
				<div style="display:flex;flex-direction:column">
					<div style="text-align:center;width:95%;margin:5px">数量总计 :	${quantity}</div>
					<div style="display:flex;flex-direction:row;width:95%;margin:5px">
						<div style="text-align:center;width:50%">商品总价(CNY-VNĐ) :</div>
						<div style="width:50%;display:flex;flex-direction:row;" >
							<input type="text"  id="totalItemCN"  style="width:80px;margin-right:5px"  value="${total}" />
							<input type="text"  id="totalItemVN"  style="width:150px"  value="${total*CNYrateVND}" />
						</div>
					</div>
					<div style="display:flex;flex-direction:row;width:95%;margin:5px">
						<div style="text-align:center;width:50%">运费(CNY-VNĐ) :</div>
						<div style="width:50%;display:flex;flex-direction:row;" >
							<input type="text"  id="shipFeeCNY"  name="shipFeeCNY"   style="width:80px;margin-right:5px"  value=""  path="shipFeeCNY" />
							<input type="text"  id="shipFeeVND"  name="shipFeeVND"   style="width:150px"  value=""  path="shipFeeVND"  />
						</div>
					</div>
					<div style="display:flex;flex-direction:row;width:95%;margin:5px">
						<div style="text-align:center;width:50%"> 合计(CNY-VNĐ) : </div>
						<div style="width:50%;display:flex;flex-direction:row" >
							<input type="text"  id="totalCN" name="totalCN" style="width:80px;margin-right:5px" value="${total}"  path="totalCN"  />
							<input type="text"  id="totalVN" name="totalVN" style="width:150px" value="${total*CNYrateVND}" path="totalVN"/>
						</div>
					</div>
						<div style="display:flex;flex-direction:row;width:95%;margin:5px" >
							<div style="text-align:center;width:50%">订单号:</div>
							<div style="width:50%"> <input type="text" name="orderNo" id="orderNo" value=""  path="orderNo"/>  <br></div>
						</div>

				</div>
					<div style="display:flex;flex-direction:row;justify-content: space-between;width:95%;margin:10px">
						<button type="button" id="fix"  style="border-radius:5px;padding:2px;background-color:#ff0015;color:#ffffff">修改订单</button>
						<button type="button" id="buyit" style="border-radius:5px;padding:2px;background-color:#ffd500;color:#ffffff">立即处理</button>
					</div>

					<input type="text"  id="orderStatus" name="orderStatus"  value=""  path="orderStatus" hidden/>
					<input type="text"  name="orderUserName"  value="${itemUserName}"  path="orderUserName" hidden/>
					<input type="text"  name="receivedDate" value=<%=java.time.LocalDate.now()%> path="receivedDate" hidden/>
				</article>
					</form:form>

				</div>
           </div>
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


