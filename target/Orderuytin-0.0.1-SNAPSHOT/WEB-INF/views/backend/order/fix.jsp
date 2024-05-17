<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#totalCN").val(Number($("#totalItemCN").val())+ Number($("#shipFeeCNY").val()));
            $("#totalVN").val(Number($("#totalItemVN").val())+ Number($("#shipFeeVND").val()));

            $("#shipFeeCNY").change(function() {
                $("#shipFeeVND").val(Number($("#shipFeeCNY").val()) * Number($(".CNYrateVND").val()));
                $("#totalCN").val(Number($("#totalItemCN").val())+ Number($("#shipFeeCNY").val()));
                $("#totalVN").val(Number($("#totalItemVN").val())+ Number($("#shipFeeVND").val()));
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
                    <p style="font-size:15px;float:right">${countFixOrderAdmin}</p></br> <a style="color:yellow;font-size:25px;font-weight:bold" href="/backend/order/fix">改单</a>
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
                    <p style="font-size:15px;float:right">${countCancelOrderAdmin+countCancelItemAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/cancel">取消 </a>
                </div>
            </div>
        </nav>
        <!-- ! Main -->
    <main class="main users chart-page" id="skip-target">
        <div class="container">
            <div class="row stat-cards">
                <p style="color: red">${message}</p>
                <c:forEach items="${showFixOrder}" var="sfo" >
                    <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-style:solid;border-width: thin;border-color:white">

                    <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                            <div style="color:red" >  ${sfo.orderNo}       </div>
                            <div style="color:red" > ${sfo.orderUserName} </div>
                        </div>
                        <div class="row">
                            <c:forEach items="${sfo.items}" var="i" >
                                <c:set var="total"  value="${total + i.price * i.quantity }"></c:set>
                                <c:set var="itemUserName"  value="${i.itemUserName}"></c:set>
                                <c:set var="CNYrateVND"  value="${i.CNYrateVND}"></c:set>
                <form:form method="post" action="/backend/item/saveItemFix" id="form${i.itemId}" modelAttribute="itemDAO">
                    <div style="border-radius:10px; background-color:#DADBE4;margin:5px;color:black">
                        <div style="display:flex;flex-direction:column">
                          <div style="display:flex;flex-direction:column">
                            <div style="display:flex;flex-direction:row;justify-content:space-between">
                                <div style="margin:5px"><a style="color:#7272c4;width:20%" href="/backend/item/remove/${i.itemId}">Xóa</a></div>
                                <div>  <a  href="/backend/item/detail/${i.itemId}">编辑</a></div>
                            </div>
                                     <div style="display:none">
                            <input type="text" name="orderId"      value="${i.orderId}"       path="orderId"        />
                            <input type="text" name="adminNote"    value="${i.adminNote}"     path="adminNote"        />
                            <input type="text" name="itemId"       value="${i.itemId}"        path="itemId"         />
                            <input type="text" name="itemUserName" value="${i.itemUserName}"  path="itemUserName"  />
                            <input type="text" name="itemStatus"   value="Da mua hang"        path="itemStatus"     />
                                    </div>
                            <div style="width:100%">
                                <div style="display:flex" >
                                  <div style="display:flex;flex-direction:column;width:30%;height:50%">
                                      <img id="outputImage${i.itemId}" src="<c:url value="/image/item/${i.image}" />" style="width:80px;height:150px;margin: 5px"/>

                                  </div>
                                    <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%">
                                        <div style="display:flex;flex-direction:row;width:95%">
                                            <div style="text-align:center;width:50%">描述</div>
                                            <div style="width:50%;margin:5px"><input type="text" id="describle"  name="describle"  value="${i.describle}" style="width:80px" path="describle"  /></div>
                                        </div>
                                        <div style="display:flex;flex-direction:row;width:95%">
                                            <div style="text-align:center;width:50%"><a href="${i.link}"> 链接 </a></div>
                                            <div style="width:50%;margin:5px"><input type="text" style="width:80px" name="link"  value="${i.link}"  path="link" />  <br></div>
                                        </div>

                                        <div style="display:flex;flex-direction:row;width:95%">
                                            <div style="text-align:center;width:50%"> 汇率 </div>
                                            <div style="width:50%;margin:5px"><input type="text"  class="CNYrateVND" style="width:80px" name="CNYrateVND" onblur="this.form.submit()"  value="${i.CNYrateVND}"  path="CNYrateVND" />  <br></div>
                                        </div>

                                    </div>
                                </div>
                                <div style="display:flex;flex-direction:row;width:95%">
                                    <div style="display:flex;flex-direction:row">
                                        <div > 价格  </div>
                                        <div style="margin:5px"><input type="text"  id="price" style="width:80px" name="price" onblur="this.form.submit()"  value="${i.price}"  path="price" />  <br></div>
                                    </div>
                                    <div style="display:flex;flex-direction:row;margin-left: 2%" >
                                        <div > 数量</div>
                                        <div style="margin:5px" ><input type="text"  id="quantity" style="width:50px" name="quantity" onblur="this.form.submit()"   value="${i.quantity}"   path="quantity" />  <br></div>
                                    </div>
                                </div>
                                <div style="display:flex;flex-direction:row;justify-content: space-between;width:95%">
                                    <div  >  小计</div>
                                    <div style="margin:5px"><input type="text"  id="totalCNY" style="width:80px" name="totalCNY"  value="${i.quantity*i.price}"  path="totalCNY" /> </div>
                                    <div style="margin:5px"><input type="text"  id="totalVND" style="width:100px" name="totalVND"  value="${i.quantity*i.price*i.CNYrateVND}"  path="totalVND" />  </div>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                                </form:form>
                            </c:forEach >

                        </div>
                        <form:form method="post" action="/backend/order/saveFix" modelAttribute="itemDAO">

                        <div style="display:flex;flex-direction:column">
                               <div style="display:flex;flex-direction:row;width:95%;margin:5px">
                                   <div style="text-align:center;width:50%"> 商品总价(CNY-VNĐ) : </div>
                                   <div style="width:50%;display:flex;flex-direction:row;" >
                                       <input type="text"  id="totalItemCN"  name="totalItemCN"   style="width:80px;margin-right:5px"  value="${total}"  path="totalItemCN" />
                                       <input type="text"  id="totalItemVN"  name="totalItemVN"   style="width:150px"  value="${total*CNYrateVND}"  path="totalItemVN"  />
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
                                   <div style="text-align:center;width:50%"> <label class="total" class="form-label"> 合计(CNY-VNĐ) : </label>  </div>
                                   <div style="width:50%;display:flex;flex-direction:row;color:red" >
                                       <input type="text"  id="totalCN" name="totalCN" style="width:80px;margin-right:5px" value="${total}"  path="totalCN"  />
                                       <input type="text"  id="totalVN" name="totalVN" style="width:150px" value="${total*CNYrateVND}"  path="totalVN"  />
                                   </div>

                               </div>
                               <div style="display:flex;flex-direction:row;width:95%;margin:5px;" >
                                   <div style="text-align:center;width:50%">订单号:</div>
                                   <div style="width:50%"> <input type="text" name="orderNo"  value="${sfo.orderNo}"  path="orderNo"/>  <br></div>
                               </div>
                            <div style="display:flex;flex-direction:row;width:95%;margin:5px;" >
                            <select name="orderStatus" path="orderStatus">
                                <option value="Da mua hang">Đã mua hàng</option>
                                <option value="Da phat hang">Đã phát hàng</option>
                                <option value="Da ve kho">Về kho</option>
                                <option value="Khieu nai">Khiếu nại</option>
                                <option value="Thanh cong">Thành công</option>
                                <option value="Huy">Hủy</option>
                            </select>
                            </div>
                           </div>
                            <input type="text"  name="orderId"  value="${sfo.orderId}"  path="orderId" hidden/>
                            <input type="text"  name="orderUserName"  value="${sfo.orderUserName}"  path="orderUserName" hidden/>
                            <input type="text"  name="receivedDate" value="${sfo.receivedDate}" path="receivedDate" hidden/>
                           <div style="width:25%;margin-left: 30%">
                               <button  type="submit" class="form-btn primary-default-btn" style="width:120px">立即处理</button>
                           </div>

                        </form:form>
                    </article>

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

