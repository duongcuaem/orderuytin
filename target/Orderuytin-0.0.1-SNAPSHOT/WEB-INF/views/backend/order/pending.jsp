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
            $(".shipFeeCNY").change(function() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(10);
                let totalCNId = "totalCN" + itemID;
                let totalVNId = "totalVN" + itemID;
                let CNYrateVNDId = "CNYrateVND" + itemID;
                let shipFeeVNDId = "shipFeeVND" + itemID;
                let totalItemCNId = "totalItemCN" + itemID;
                let totalItemVNId = "totalItemVN" + itemID;
                $("#"+totalCNId).val((Number($(this).val())+ Number($("#"+totalItemCNId).val())).toFixed(2));
                $("#"+shipFeeVNDId).val((Number($(this).val()) * Number($("#"+CNYrateVNDId).val())).toFixed(0));
                $("#"+totalVNId).val((Number($("#"+totalCNId).val())* Number($("#"+CNYrateVNDId).val())).toFixed(0));
                $("#"+totalItemVNId).val((Number($("#"+totalItemCNId).val())*Number($("#"+CNYrateVNDId).val())).toFixed(0));
            });
            $(".price").change(function() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(5);
                let totalCNId = "totalCN" + itemID;
                let totalVNId = "totalVN" + itemID;
                let quantityId = "quantity" + itemID;
                let CNYrateVNDId = "CNYrateVND" + itemID;
                let shipFeeCNYId = "shipFeeCNY" + itemID;
                let totalItemCNId = "totalItemCN" + itemID;
                let totalItemVNId = "totalItemVN" + itemID;
                $("#"+totalItemCNId).val((Number($(this).val())*Number($("#"+quantityId).val())).toFixed(2));
                $("#"+totalVNId).val((Number($("#"+totalCNId).val())* Number($("#"+CNYrateVNDId).val())).toFixed(0));
                $("#"+totalCNId).val((Number($("#"+shipFeeCNYId).val())+ Number($("#"+totalItemCNId).val())).toFixed(2));
                $("#"+totalItemVNId).val((Number($("#"+totalItemCNId).val())*Number($("#"+CNYrateVNDId).val())).toFixed(0));
            });
            $(".quantity").change(function() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(8);
                let priceId = "price" + itemID;
                let totalCNId = "totalCN" + itemID;
                let totalVNId = "totalVN" + itemID;
                let CNYrateVNDId = "CNYrateVND" + itemID;
                let shipFeeCNYId = "shipFeeCNY" + itemID;
                let totalItemCNId = "totalItemCN" + itemID;
                let totalItemVNId = "totalItemVN" + itemID;
                $("#"+totalItemCNId).val((Number($("#"+priceId).val())*Number($(this).val())).toFixed(0));
                $("#"+totalCNId).val((Number($("#"+shipFeeCNYId).val())+ Number($("#"+totalItemCNId).val())).toFixed(0));
                $("#"+totalItemVNId).val((Number($("#"+totalItemCNId).val())*Number($("#"+CNYrateVNDId).val())).toFixed(0));
                $("#"+totalVNId).val((Number($("#"+totalCNId).val())* Number($("#"+CNYrateVNDId).val())).toFixed(0));
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
        <jsp:include page="/WEB-INF/views/common/mainnavSearchItemOfClient.jsp"></jsp:include>

        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
            <div class="container">
                <div style="display:flex;flex-direction:row;justify-content: space-between">
                    <div style="color:#5eff00 "><p >${message}</p></div>
                    <div ><a href="/backend/item/mergedList">合并列表</a></div>
                </div>
                <div class="row stat-cards" >
 <c:forEach items="${showPendingOrderList}" var="i" >
     <c:set var="itemUserName"  value="${i.itemUserName}"></c:set>
     <c:set var="CNYrateVND"  value="${i.CNYrateVND}"></c:set>
     <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

     <form:form method="post" action="/backend/order/insertSingleOrder" modelAttribute="itemDAO">
        <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
        <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity *i.CNYrateVND }"></c:set>
         <div style="display:flex;flex-direction:column">
            <div style="display:flex;flex-direction:row;justify-content: space-between">
                <div style="color:#5eff00" > <a  href="/backend/item/merg/${i.itemId}">合并</a></div>
                <div> <a style="border-radius:5px;padding:2px;background-color:#ff0015;color:#ffffff" href="/backend/item/updateCancel/${i.itemId}">取消</a></div>
                <div> <p style="text-align:center;"> ${i.itemUserName}</p></div>
            </div>
             <div style="display:none">
                <input type="text"  id="image"          name="image"         value="${i.image}"  path="image" />
                <input type="text"  id="itemId"         name="itemId"        value="${i.itemId}"  path="itemId" />
                <input type="text"  id="itemStatus"     name="itemStatus"    value="Da mua hang"  path="itemStatus"/>
                <input type="text"  id="orderStatus"    name="orderStatus"   value="Da mua hang" path="orderStatus"/>
                <input type="text"  id="orderUserName"  name="orderUserName" value="${i.itemUserName}"   path="orderUserName"/>
                <input type="text"  id="itemUserName"   name="itemUserName"  value="${i.itemUserName}"  path="itemUserName"  />
                <input type="text"  id="receivedDate"   name="receivedDate"  value="<%=java.time.LocalDate.now()%>" path="receivedDate" />
             </div>
             <div style="width:100%;display:flex;flex-direction:row ">
                <div style="width:20%;height:90%;display:flex;flex-direction:column">
                   <img alt="image" id="outputImage" src="<c:url value="/image/item/${i.image}" />" style="width:100%;height:150px;margin:5px">
                    <div style="width:100%">
                     <input type="text" id="CNYrateVND${i.itemId}"  style="width:100%" name="CNYrateVND" value="${i.CNYrateVND}"  path="CNYrateVND" />
                    </div>
                </div>
               <div style="display:flex;flex-direction:column;justify-content: space-between">
            <div style="display:flex;flex-direction:row;width:95%">
                <div style="text-align:center;width:20%">
                    <label >描述</label>
                </div>
                <div style="width:80%;color:#5eff00">
                   ${i.describle}
                       <input type="text" name="describle"  value="${i.describle}"  path="describle" style="display:none"/>
                </div>
            </div>
            <div style="display:flex;flex-direction:row;width:95%">
                <div style="text-align:center;width:20%">
                    <label>  <a href="${i.link}"> 链接 </a> </label>
                </div>
                <div style="width:80%;margin:5px">
                    <input type="text" style="width:100%" name="link"  value="${i.link}"  path="link" />
                </div>
            </div>
            <div style="display:flex;flex-direction:row;width:95%">
                <div style="text-align:center;width:20%">
                    <label>价格</label>
                </div>
                <div style="width:80%;margin:5px">
                    <input type="text"  id="price${i.itemId}" class="price" name="price"  value="${i.price}" style="width:100%" path="price" />
                </div>
            </div>
            <div style="display:flex;flex-direction:row;width:95%" >
                <div style="text-align:center;width:20%">
                    <label>数量</label>
                </div>
                <div style="width:80%;margin:5px" >
                    <input type="text"  id="quantity${i.itemId}" class="quantity" name="quantity"   value="${i.quantity}" style="width:100%"  path="quantity" />
                </div>
            </div>
                </div>
                </div>
                <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                    <div style="text-align:center;width:40%"> 商品总价 (¥-đ) </div>
                    <div style="width:70%;display:flex;flex-direction:row;" >
                        <input type="text"  id="totalItemCN${i.itemId}"  name="totalItemCN"   style="width:80px;margin-right:5px"  value="${i.quantity*i.price}"  />
                        <input type="text"  id="totalItemVN${i.itemId}"  name="totalItemVN"   style="width:120px"  value="${i.quantity*i.price*i.CNYrateVND}"  />
                    </div>

                </div>
                <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                    <div style="text-align:center;width:40%">运费(¥-đ) </div>
                    <div style="width:70%;display:flex;flex-direction:row;" >
                        <input type="text"  id="shipFeeCNY${i.itemId}" class="shipFeeCNY" name="shipFeeCNY"   style="width:80px;margin-right:5px"  value="0"  path="shipFeeCNY" />
                        <input type="text"  id="shipFeeVND${i.itemId}" class="shipFeeVND" name="shipFeeVND"   style="width:120px"  value="0"  path="shipFeeVND"  />
                    </div>

                </div>
                <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                    <div style="text-align:center;width:40%"> <label > 合计(¥-đ)  </label>  </div>
                    <div style="width:70%;display:flex;flex-direction:row;color:#5eff00" >
                        <input type="text"  id="totalCN${i.itemId}" name="totalCN" style="width:80px;margin-right:5px" value="${i.quantity*i.price}"  path="totalCN" />
                        <input type="text"  id="totalVN${i.itemId}" name="totalVN" style="width:120px" value="${i.quantity*i.price*i.CNYrateVND}"  path="totalVN" />
                    </div>
                </div>

                <div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
                    <div style="display:flex;flex-direction:column;width:150px"> <input type="text"  id="orderNo" name="orderNo" placeholder="订单号"  style="width:100%" path="orderNo"/>
                        <div style="color:#00ff15"><form:errors cssClass="error" path="link"></form:errors></div>
                    </div>
                    <div > <input type="submit" class="primary-default-btn" value="购买"/></div>
                    <div>  <a  href="/backend/item/detail/${i.itemId}">编辑</a></div>
                </div>
            </div>
       </form:form>
     </article>
     <c:set var="totalItemCN" value="0"></c:set>
     <c:set var="totalItemVN" value="0"></c:set>
     <c:set var="totalCN" value="${totalCN+i.price * i.quantity}"></c:set>
     <c:set var="totalQuantity" value="${totalQuantity + i.quantity}"></c:set>
     <c:set var="totalVN" value="${totalVN+i.price * i.quantity*i.CNYrateVND}"></c:set>
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
                                        <a class="page-link" href="/backend/order/pending?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                                    </li></div>
                                <c:forEach begin="1" end="${total}" step="1" var="num">
                                    <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                        <a class="page-link" href="/backend/order/pending?page=${num}&perpage=${perpage}">${num}</a>
                                    </li></div>
                                </c:forEach>
                                <div>
                                    <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                        <a class="page-link" href="/backend/order/pending?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                                    </li></div>
                            </div>
                        </ul>
                    </nav>
                </div>
                <ul class="footer-end">
                    <li>数量总计 ：  <fmt:formatNumber  value = "${totalQuantity}" type="number"/> </li>
                    <li>合计    ： <fmt:formatNumber maxFractionDigits="2" value = "${totalCN}" type="number"/>¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalVN}" type="number"/>đ)</li>
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


