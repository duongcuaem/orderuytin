<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
                let shipFeeVNDId = "shipFeeVND" + itemID;
                let totalItemCNId = "totalItemCN" + itemID;
                let totalItemVNId = "totalItemVN" + itemID;
                let totalCNId = "totalCN" + itemID;
                let totalVNId = "totalVN" + itemID;
                $("#"+shipFeeVNDId).val(Number($(this).val()) * Number($(".CNYrateVND").val()));
                $("#"+totalCNId).val(Number($(this).val())+ Number($("#"+totalItemCNId).val()));
                $("#"+totalItemVNId).val(Number($("#"+totalItemCNId).val())*Number($(".CNYrateVND").val()));
                $("#"+totalVNId).val(Number($("#"+totalCNId).val())* Number($(".CNYrateVND").val()));
            });
            $(".price").change(function() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(5);
                let quantityId = "quantity" + itemID;
                let shipFeeCNYId = "shipFeeCNY" + itemID;
                let totalItemCNId = "totalItemCN" + itemID;
                let totalItemVNId = "totalItemVN" + itemID;
                let totalCNId = "totalCN" + itemID;
                let totalVNId = "totalVN" + itemID;
                $("#"+totalItemCNId).val(Number($(this).val())*Number($("#"+quantityId).val()));
                $("#"+totalCNId).val(Number($("#"+shipFeeCNYId).val())+ Number($("#"+totalItemCNId).val()));
                $("#"+totalItemVNId).val(Number($("#"+totalItemCNId).val())*Number($(".CNYrateVND").val()));
                $("#"+totalVNId).val(Number($("#"+totalCNId).val())* Number($(".CNYrateVND").val()));
            });
            $(".quantity").change(function() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(8);
                let priceId = "price" + itemID;
                let shipFeeCNYId = "shipFeeCNY" + itemID;
                let totalItemCNId = "totalItemCN" + itemID;
                let totalItemVNId = "totalItemVN" + itemID;
                let totalCNId = "totalCN" + itemID;
                let totalVNId = "totalVN" + itemID;
                $("#"+totalItemCNId).val(Number($("#"+priceId).val())*Number($(this).val()));
                $("#"+totalCNId).val(Number($("#"+shipFeeCNYId).val())+ Number($("#"+totalItemCNId).val()));
                $("#"+totalItemVNId).val(Number($("#"+totalItemCNId).val())*Number($(".CNYrateVND").val()));
                $("#"+totalVNId).val(Number($("#"+totalCNId).val())* Number($(".CNYrateVND").val()));
            });

        });
    </script>
</head>
<body>
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <jsp:include page="/WEB-INF/views/common/mainnavSearchItemOfClient.jsp"></jsp:include>

        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <div style="display:flex;flex-direction:column">
                    <div><p style="color: red">${message}</p></div>
                </div>
                <div style="display:flex;flex-direction:row;justify-content: space-between;">
                    <div style="width:30%;color:red"><a href="/backend/item/mergedList">合并列表</a></div>
                </div>
                <div class="row stat-cards" >
                    <c:forEach items="${showItemOfClient}" var="i" >
                        <c:set var="itemUserName"  value="${i.itemUserName}"></c:set>
                        <c:set var="CNYrateVND"  value="${i.CNYrateVND}"></c:set>
                        <article class="stat-cards-item" style="margin:5px" >
                            <form:form method="post" action="/backend/order/insertSingleOrder" modelAttribute="itemDAO">
                                <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                                <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                <div style="display:flex;flex-direction:column">
                                    <div style="display:flex;flex-direction:row;justify-content: space-between;color:red">
                                        <div> <a  href="/backend/item/merg/${i.itemId}">合并</a></div>
                                        <div> <a class="secondary-default-btn"  href="/backend/item/updateCancel/${i.itemId}">取消</a></div>
                                        <div> <p style="text-align:center;margin-bottom: 10px"> ${i.itemUserName}</p></div>
                                    </div>
                                    <div style="display:none">
                                        <input type="text"  id="itemId"         name="itemId"        value="${i.itemId}"  path="itemId"   />
                                        <input type="text"  id="itemUserName"   name="itemUserName"  value="${i.itemUserName}"  path="itemUserName"  />
                                        <input type="text"  id="itemStatus"     name="itemStatus"    value="Da mua hang"  path="itemStatus" />
                                        <input type="text"  id="orderStatus"    name="orderStatus"   value="Da mua hang" path="orderStatus"/>
                                        <input type="text"  id="receivedDate"   name="receivedDate"  value="<%=java.time.LocalDate.now()%>" path="receivedDate" />
                                        <input type="text"  id="orderUserName"  name="orderUserName" value="${i.itemUserName}"   path="orderUserName" />
                                    </div>
                                    <div style="width:100%;display:flex;flex-direction:row ">
                                        <div style="display:flex;flex-direction:column;width:30%;height:50%">
                                            <img alt="image" id="outputImage" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin:5px">
                                            <input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
                                            <input type="text"  id="fileuploadName" name="image" hidden />
                                            <input type="file" class="form-control" id="fileUploadId" style="width:80px;height:2px"/>  <%-- thẻ input chon ảnh--%>
                                        </div>

                                        <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%">
                                            <div style="display:flex;flex-direction:row;width:95%">
                                                <div style="text-align:center;width:50%;color:#5eff00"><label >描述</label> </div>
                                                <div style="width:50%;color:#5eff00"> ${i.describle} <input type="text"  id="describle" name="describle"  value="${i.describle}" style="width:100%" path="describle" hidden/></div>
                                            </div>

                                            <div style="display:flex;flex-direction:row;width:95%">
                                                <div style="text-align:center;width:50%;color:#5eff00"> <label> 链接</label> </div>
                                                <div style="width:50%;margin:5px"><input type="text" style="width:100%" name="link"  value="${i.link}"  path="link" />  <br></div>
                                            </div>

                                            <div style="display:flex;flex-direction:row;width:95%">
                                                <div style="text-align:center;width:50%;color:#5eff00"><label>价格</label>  </div>
                                                <div style="width:50%;margin:5px"><input type="text"  id="price${i.itemId}" class="price" name="price"  value="${i.price}" style="width:100%" path="price" />  <br></div>
                                            </div>

                                            <div style="display:flex;flex-direction:row;width:95%" >
                                                <div style="text-align:center;width:50%;color:#5eff00"><label>数量</label>  </div>
                                                <div style="width:50%;margin:5px" ><input type="text"  id="quantity${i.itemId}" class="quantity" name="quantity"   value="${i.quantity}" style="width:100%"  path="quantity" />  <br></div>
                                            </div>

                                            <div style="display:flex;flex-direction:row;width:95%">
                                                <div style="text-align:center;width:50%;color:#5eff00"><label> 汇率</label> </div>
                                                <div style="width:50%;margin:5px"><input type="text"   class="CNYrateVND" style="width:100%" name="CNYrateVND" value="${i.CNYrateVND}"  path="CNYrateVND" />  <br></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                                        <div style="text-align:center;width:30%;color:#5eff00"> 商品总价 (CNY-VNĐ) </div>
                                        <div style="width:70%;display:flex;flex-direction:row;" >
                                            <input type="text"  id="totalItemCN${i.itemId}"  name="totalItemCN"   style="width:80px;margin-right:5px"  value="${i.quantity*i.price}"  />
                                            <input type="text"  id="totalItemVN${i.itemId}"  name="totalItemVN"   style="width:120px"  value="${i.quantity*i.price*i.CNYrateVND}"  />
                                        </div>

                                    </div>
                                    <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                                        <div style="text-align:center;width:30%;color:#5eff00">运费 </br>  (CNY-VNĐ) </div>
                                        <div style="width:70%;display:flex;flex-direction:row;" >
                                            <input type="text"  id="shipFeeCNY${i.itemId}" class="shipFeeCNY" name="shipFeeCNY"   style="width:80px;margin-right:5px"  value="0"  path="shipFeeCNY" />
                                            <input type="text"  id="shipFeeVND${i.itemId}" class="shipFeeVND" name="shipFeeVND"   style="width:120px"  value="0"  path="shipFeeVND"  />
                                        </div>

                                    </div>
                                    <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                                        <div style="text-align:center;width:30%;color:#5eff00"> <label > 合计 </br>  (CNY-VNĐ)  </label>  </div>
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
            <nav aria-label="..." style="margin:10px">
                <ul class="pagination">
                    <div style="display:flex;flex-direction:row;justify-content: space-between;margin:10px">
                        <div>
                            <li class="page-item <c:if test="${page == 1}">disabled</c:if>">
                                <a class="page-link" href="/backend/search/searchItemOfClient?page=${page - 1}&perpage=${perpage}" tabindex="-1" aria-disabled="true">Lùi lại</a>
                            </li></div>
                        <c:forEach begin="1" end="${total}" step="1" var="num">
                            <div>  <li class="page-item <c:if test="${page == num}">active</c:if> ">
                                <a class="page-link" href="/backend/search/searchItemOfClient?page=${num}&perpage=${perpage}">${num}</a>
                            </li></div>
                        </c:forEach>
                        <div>
                            <li class="page-item <c:if test="${page == total}">disabled</c:if>">
                                <a class="page-link" href="/backend/search/searchItemOfClient?page=${page + 1}&perpage=${perpage}">Tiếp theo</a>
                            </li></div>
                    </div>
                </ul>
            </nav>
            <div style="color:red"><p>数量总计 ：  <fmt:formatNumber maxFractionDigits="2" value = "${totalQuantity}" type="number"/> </p></div>
            <div style="color:red"><p>合计 ： <fmt:formatNumber maxFractionDigits="2" value = "${totalCN}" type="number"/>¥ ~~  <fmt:formatNumber maxFractionDigits="2" value = "${totalVN}" type="number"/>đ</p></div>

        </main>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</div>
<script>
    $('#fileUploadId').on("change", function () {
        var file = $(this)[0].files[0];
        var reader = new FileReader();
        reader.onload = function(){
            var output = document.getElementById('outputImage');
            output.src = reader.result;
        };
        reader.readAsDataURL(file);
        var data = new FormData();
        data.append("file", file, file.name);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/backend/item/upload",
            data: data,
            // prevent jQuery from automatically transforming the data into a query string
            processData: false,
            contentType: false,
            cache: false,
            timeout: 1000000,
            success: function(data, textStatus, jqXHR) {
                $("#fileuploadName").val(data);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("tải file thất bại")
            }
        });
    })
</script>


<!-- Chart library -->
<script src="/plugins/chart.min.js"></script>
<!-- Icons library -->
<script src="/plugins/feather.min.js"></script>
<!-- Custom scripts -->
<script src="/js/script.js"></script>

</body>

</html>


