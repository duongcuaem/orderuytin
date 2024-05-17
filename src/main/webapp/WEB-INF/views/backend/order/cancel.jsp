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
            $(".DeleteItem").click( function removeItem() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(10);
                let itemStatusID = 'itemStatus' + itemID;
                let formItemID = 'formItem' + itemID;
                document.getElementById(itemStatusID).value = 'Xoa';
                document.getElementById(formItemID).submit();
            });
            $(".RestoreItem").click( function restoreItem() {
                let id = $(this).attr('id') ;
                let itemID = id.substring(11);
                let itemStatusID = 'itemStatus' + itemID;
                let formItemID = 'formItem' + itemID;
                document.getElementById(itemStatusID).value = 'Cho xu ly';
                document.getElementById(formItemID).submit();
            })
            $(".DeleteOrder").click( function removeOrder() {
                let id = $(this).attr('id') ;
                let orderID = id.substring(11);
                let orderStatusID = 'orderStatus' + orderID;
                let formOrderID = 'formOrder' + orderID;
                document.getElementById(orderStatusID).value = 'Xoa';
                document.getElementById(formOrderID).submit();
            });
            $(".RestoreOrder").click( function restoreOrder() {
                let id = $(this).attr('id') ;
                let orderID = id.substring(12);
                let orderStatusID = 'orderStatus' + orderID;
                let formOrderID = 'formOrder' + orderID;
                document.getElementById(orderStatusID).value = 'Da mua hang';
                document.getElementById(formOrderID).submit();
            })
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
                    <p style="font-size:15px;float:right">${countComplainOrderAdmin}</p> </br><a style="font-size:15px"  href="/backend/order/complain"> 投诉 </a>
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
                    <p style="font-size:15px;float:right">${countCancelOrderAdmin+countCancelItemAdmin}</p></br> <a style="color:yellow;font-size:25px;font-weight:bold"  href="/backend/order/cancel">取消 </a>
                </div>
            </div>
        </nav>

        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="height: 75vh; overflow: scroll">
          <div class="container">
            <div style="display:flex;flex-direction:column">
            <div><p style="color: red">${message}</p></div>
        </div>
            <div class="row stat-cards">
                <c:forEach items="${showCancelItemList}" var="i" >
                    <article class="stat-cards-item" style="border-radius:10px;border-style:solid;border-width: thin;border-color:white;color:yellow;background-color:black">
                        <div style="display:flex;flex-direction:column;width:100%">
                            <div style="color:red"> ${i.itemUserName} </div>
                            <form:form method="post"  id ='formItem${i.itemId}' action="/backend/item/saveItemCancel" modelAttribute="itemDAO">
                                <div style="display:none;">
                                    <input type="text"   name="itemId"  value="${i.itemId}"  path="itemId"  />
                                    <input type="text"   name="image"  value="${i.image}"  path="image" />
                                    <input type="text"   name="itemUserName"  value="${i.itemUserName}"  path="itemUserName"  />
                                    <input type="text"   name="itemStatus"  value="${i.itemStatus}"  path="itemStatus" id="itemStatus${i.itemId}"/>
                                    <input type="text"   name="CNYrateVND"  value="${i.CNYrateVND}"  path="CNYrateVND"  />
                                    <input type="text"   name="describle"  value="${i.describle}"  path="describle" />
                                    <input type="text"   name="price"  value="${i.price}"  path="price"  />
                                    <input type="text"   name="quantity"  value="${i.quantity}"  path="quantity" />
                                </div>
                                <div style="border-radius:10px; background-color:#DADBE4;margin:5px">
                                  <div style="display:flex;flex-direction:column;width:100%;margin:10px">
                                    <div style="display:flex;flex-direction:row;width:100%;margin:10px">
                                        <div> <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                                        <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                            <div style="width:100%"><a href="${i.link}"> 链接 </a> <input type="text" style="width:80px" name="link" path="link" value="${i.link}" /></div>
                                            <div style="width:100%"> ${i.describle}</div>
                                            <div style="width:100%"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                                            <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                            <div style="width:100%"> x ${i.CNYrateVND}  ¥/đ</div>
                                            <div style="width:100%"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                                        </div>
                                      </div>
                                    <div style="display:flex;flex-direction:row;justify-content:space-between;width:80%;margin:10px">
                                          <button type="button" id="DeleteItem${i.itemId}"  class="DeleteItem" style="border-radius:5px;padding:2px;background-color:#ff0015">取消</button>
                                          <button type="button" id="RestoreItem${i.itemId}" class="RestoreItem" style="border-radius:5px;padding:2px;background-color:#00ff15">恢复</button>
                                    </div>
                                  </div>
                                </div>
                            </form:form>
                        </div>
                    </article>
                </c:forEach>
                <c:forEach items="${showCancelOrderList}" var="scol" >
                  <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">
                    <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                        <div style="color:red"><fmt:formatDate value = "${scol.receivedDate}" type = "date"/></div>
                        <div style="color:red"> ${scol.orderUserName} </div>
                        <div style="color:red;margin-left:2%"> <input type="text" value="${scol.orderNo}" style="width:50px"/> </div>
                    </div>
                    <c:forEach items="${scol.items}" var="i" >
                        <input type="text"  id="itemId"  name="itemId"  value="${i.itemId}"  path="itemId"  hidden/>
                        <input type="text"  id="orderId" name="orderId" value="${i.orderId}" path="orderId" hidden/>
                        <div class="row">
                            <div style="border-radius:10px;border-style:solid;border-width: thin;border-color:white; display:flex;flex-direction:column;margin:2px">
                                <div style="display:flex" >
                                    <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                                    <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                    <div style="display:flex;flex-direction:column;width:30%;margin-right:5px">
                                        <div > <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                                        <input type="text"  id="image"  name="image"  value="${i.image}"  path="image" hidden/>
                                        <div> <a  style="border-radius:5px;padding:2px;background-color:#ff0015;color:#ffffff"  href="/backend/item/updateRestore/${i.itemId}">恢复</a></div>
                                    </div>
                                    <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                        <div style="width:100%"> <input type="text" style="width:80px" value="${i.link}" /></div>
                                    <div style="width:100%"> ${i.describle}</div>
                                        <div style="width:100%"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                                        <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                        <div style="width:100%"> x ${i.CNYrateVND}  ¥/đ</div>
                                        <div style="width:100%"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach >
                    <form:form method="post" id ='formOrder${scol.orderId}' action="/backend/order/saveOrderCancel" modelAttribute="ordersDAO">
                    <div style="display:flex;flex-direction:column;width:100%;margin:10px">
                        <div style="display:flex;flex-direction:row;margin:5px">
                            <div style="width:40%">商品总价 </div>
                            <div ><fmt:formatNumber value = "${totalItemCN}" type = "number"/>¥(<fmt:formatNumber maxFractionDigits="0" value = "${totalItemVN}" type = "number"/>đ)</div>
                        </div>
                        <div style="display:flex;flex-direction:row;margin:5px">
                           <div style="width:40%">运费   </div>
                           <div > <fmt:formatNumber value = "${scol.shipFeeCNY}" type = "number"/>¥(<fmt:formatNumber value = "${scol.shipFeeVND}" type = "number"/>đ)</div>
                        </div>
                        <div style="display:flex;flex-direction:row;margin:5px">
                           <div style="width:40%">合计   </div>
                           <div > <fmt:formatNumber value = "${scol.totalCN}" type = "number"/>¥(<fmt:formatNumber value = "${scol.totalVN}" type = "number"/>đ)</div>
                        </div>
                    </div>
                      <div style="display:none">
                        <input type="text"  name="orderUserName"  value="${scol.orderUserName}"   path="orderUserName" />
                        <input type="text"  name="receivedDate"   value="${scol.receivedDate}"    path="receivedDate"  />
                        <input type="text"  name="wbUserName"     value="${scol.orderUserName}"   path="wbUserName"    />
                        <input type="text"  name="orderId"        value="${scol.orderId}"         path="orderId"       />
                        <input type="text"  name="totalVN"        value="${scol.totalVN}"         path="totalVN"       />
                        <input type="text"  name="orderNo"        value="${scol.orderNo}"         path="orderNo"       />
                        <input type="text"  name="totalCN"        value="${scol.totalCN}"         path="totalCN"       />
                        <input type="text"  name="shipFeeCNY"     value="${scol.shipFeeCNY}"      path="shipFeeCNY"    />
                        <input type="text"  name="shipFeeVND"     value="${scol.shipFeeVND}"      path="shipFeeVND"    />
                        <input type="text"  name="orderStatus"    value="${scol.orderStatus}"     path="orderStatus"   id="orderStatus${scol.orderId}" />
                      </div>
                      <div style="display:flex;flex-direction:row;justify-content:space-between;width:80%;margin:10px">
                        <button type="button" id="DeleteOrder${scol.orderId}"  class="DeleteOrder" style="border-radius:5px;padding:2px;background-color:#ff0015">取消</button>
                        <button type="button" id="RestoreOrder${scol.orderId}" class="RestoreOrder" style="border-radius:5px;padding:2px;background-color:#00ff15">恢复</button>
                     </div>

                    </form:form>

                  </article>
                    <c:set var="totalItemCN" value="0"></c:set>
                    <c:set var="totalItemVN" value="0"></c:set>
                </c:forEach>
            </div>
          </div>
        </main>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
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