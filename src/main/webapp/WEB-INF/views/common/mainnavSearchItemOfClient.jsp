<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

<nav class="main-nav--bg" style="background-color: black">
    <div class="container main-nav">
        <div class="main-nav-start">
            <form  action="/backend/search/searchOrder" method="post">
                <div class="search-wrapper" style="display:flex;flex-direction:row">
                    <i data-feather="search" aria-hidden="true"></i>
                    <input type="text" name="search" placeholder="Bạn muốn tìm kiếm gì? ..." required>
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
                <a href="/backend/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
            </div>
            <div style="color:white;font-size:35px" >
                <a href="/backend/user/userList"><i class="fa-solid fa-users" aria-hidden="true" style="font-size:32px;margin-right:10px"></i></a>
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
            <p style="font-size:15px;float:right">${countPendingOrderAdmin}</p>  </br><a style="color:yellow;font-size:25px;font-weight:bold"  href="/backend/order/pending"> 等买 </a>
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