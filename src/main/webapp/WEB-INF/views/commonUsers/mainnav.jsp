<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<nav class="main-nav--bg" style="background-color: black">
    <div class="container main-nav">
        <div class="main-nav-start">
            <form  action="/user/search/searchOrder" method="post">
                <div class="search-wrapper" style="display:flex;flex-direction:row">
                    <i data-feather="search" aria-hidden="true"></i>
                    <input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng qua miêu tả sản phẩm !!! ..." required>
                    <button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;boder-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
                </div>
            </form>
        </div>
        <div class="main-nav-end">
            <button class="sidebar-toggle transparent-btn" title="Menu" type="button">
                <span class="sr-only">Toggle menu</span>
                <span class="icon menu-toggle--gray" aria-hidden="true"></span>
            </button>

            <div style="color:white;font-size:35px" >
                <a href="/user/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
            </div>

            <div style="color:white;font-size:35px" ><a href="/user/home"><i class="fa-solid fa-house-user"></i> </a> </div>
            <div style="color:white;">
                <a href="/user/item/cart">
                    <p style="color:red;font-size:15px;float:right">${countCartItem}</p> <i style="font-size:35px" class="fa-solid fa-cart-shopping"></i>
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
            <p style="font-size:15px;float:right">${countWholeOrder}</p> </br><a style="font-size:15px;" href="/user/order/whole">Tất cả</a>
        </div>
        <div>
            </br>|</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right">${countPendingOrder}</p>  </br><a style="font-size:15px"  href="/user/order/pending"> Chờ mua </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right">${countBoughtOrder}</p></br> <a style="font-size:15px"  href="/user/order/bought"> Đã mua</a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right">${countDeliveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/deliveried"> Đã phát</a>
        </div>
        <div>
            </br>|</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right">${countArriveredOrder}</p></br> <a style="font-size:15px"  href="/user/order/arrivered">Về kho </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right">${countComplainOrder}</p> </br><a style="font-size:15px"  href="/user/order/complain"> Khiếu nại </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div >
            <p style="font-size:15px;float:right">${countFinishedOrder}</p></br> <a style="font-size:15px"  href="/user/order/finished"> Thành công </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right">${countCancelOrder+countCancelItem}</p></br> <a style="font-size:15px"  href="/user/order/cancel"> Đơn huỷ  </a>
        </div>
    </div>
</nav>