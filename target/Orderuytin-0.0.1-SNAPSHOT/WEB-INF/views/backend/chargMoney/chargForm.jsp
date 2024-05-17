<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
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
                  <p style="font-size:15px;float:right">${countCancelOrderAdmin+countCancelItemAdmin}</p></br> <a style="font-size:15px"  href="/backend/order/cancel">取消 </a>
              </div>
          </div>
      </nav>

    <!-- ! Main -->
    <main class="main users chart-page" id="skip-target">
      <div class="container">
        <div style="display:flex;flex-direction:column;">
          <div style="color: #5eff00;font-size:40px;text-align:center"><p>NẠP TIỀN</p></div>
        </div>
        <div class="row stat-cards">
            <div class="col-md-12 col-xl-6">
                <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">

                <div style="color: #ffc400"><p >${message}</p></div>
              <div style="display:flex;flex-direction:column;width:100%">
                <div style="display:flex" >
<form:form method="post" action="/backend/chargMoney/charg" modelAttribute="itemDAO">
<div style="display:flex;flex-direction:row;justify-content: space-between">
                  <div style="display:flex;flex-direction:column;justify-content: space-evenly;width:40%">
                    <div style="color:#00ff15;font-size:20px">  Khách hàng</div>
                    <div style="color:#00ff15;font-size:20px">   Số tiền</div>
                    <div style="color:#00ff15;font-size:20px">  Ghi chú </div>
                    <div style="color:#00ff15;font-size:20px">  Ngày nạp </div>
                  </div>
                  <div style="display:flex;flex-direction:column;justify-content:space-between;width:60%" >
                      <div style="margin:5px" >
                          <select name="userId" path="userId">
                              <c:forEach items="${listUser}" var="u">
                                  <option value="${u.userId}">${u.userName}</option>
                              </c:forEach>
                          </select>

                      </div>
                    <input type="text"  name="amount"  value=""   path="amount"  style="width:95%;margin-top:10px"/> <br>
                    <input type="text"  name="note"    value=""   path="note"  style="width:95%"   />  <br>
                    <input type="date"  name="chargDate"   value="<%=java.time.LocalDate.now()%>"   path="chargDate" style="width:95%" />  <br>
                  </div>
</div>
  <div style="margin-left:30%"> <input class="form-btn primary-default-btn" type="submit" value="Nạp" style="width:95%;margin:10px" /> </div>
</form:form>
                </div>

              </div>
          </article>
            </div>
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




