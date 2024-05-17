<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="sidebar">
    <div class="sidebar-start">
        <div class="sidebar-head">
            <a href="/" class="logo-wrapper" title="Home">
                <span class="logo-title" style="color:white"> ${loginUser.userName}</span>
            </a>
            <button class="sidebar-toggle transparent-btn" title="Menu" type="button">
                <span class="sr-only">Toggle menu</span>
                <span class="icon menu-toggle" aria-hidden="true"></span>
            </button>
        </div>
        <div class="sidebar-body">
            <ul class="sidebar-body-menu">
                <li>
                    <a class="show-cat-btn active" >
                        Quản lý
                        <span class="category__btn transparent-btn" title="Open list">
                          <span class="sr-only">Open list</span>
                          <span class="icon arrow-down" aria-hidden="true"></span>
                      </span>
                    </a>
                    <ul class="cat-sub-menu">
                        <li>
                            <a href="/backend/chargMoney/chargForm"><span class="fa-solid fa-money-check-dollar" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Nạp tiền
                                <span class="category__btn transparent-btn" title="Open list"></span>
                            </a>
                        </li>
                        <li>
                            <a href="/backend/user/userList"><span class="fa-solid fa-users" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Khách  hàng
                                <span class="category__btn transparent-btn" title="Open list"></span>
                            </a>
                        </li>
                        <li>
                            <a href="users-02.html"><span class="icon message" aria-hidden="true"></span>Thông báo
                                <span class="category__btn transparent-btn" title="Open list"></span>
                            </a>
                        </li>
                    </ul>
                    <a class="show-cat-btn active" >
                        <span class="fa-duotone fa-square-list" aria-hidden="true"></span> Trạng thái đơn hàng
                        <span class="category__btn transparent-btn" title="Open list">
                        <span class="sr-only">Open list</span>
                        <span class="icon arrow-down" aria-hidden="true"></span>
                    </span>
                    </a>
                    <ul class="cat-sub-menu">
                        <li>
                            <a href="/backend/order/whole"><span class="icon category" aria-hidden="true"></span>Tất cả đơn hàng
                            </a>
                        </li>
                        <li>
                            <a href="/backend/order/pending"><span class="fa-solid fa-clock" style="font-size:20px;margin-right:10px" aria-hidden="true"></span>Chờ xử lý </a>
                        </li>
                        <li>
                            <a href="/backend/order/bought"><span class="fa-solid fa-check" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Đã đặt hàng</a>
                        </li>
                        <li>
                            <a href="/backend/order/fix"><span class="fa-solid fa-wrench" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Đơn cần sửa
                            </a>
                        </li>
                        <li>
                            <a href="/backend/order/deliveried"><span class="fa-solid fa-truck" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Đã phát hàng</a>
                        </li>
                        <li>
                            <a href="/backend/order/arrivered"><span class="fa-solid fa-warehouse" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Đã về kho </a>
                        </li>
                        <li>
                            <a href="/backend/order/complain"><span class="fa-solid fa-face-angry" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Khiếu nại </a>
                        </li>
                        <li>
                            <a href="/backend/order/finished"><span class="fa-solid fa-face-smile" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Thành công </a>
                        </li>
                        <li>
                            <a href="/backend/order/cancel"><span class="fa-solid fa-ban" aria-hidden="true" style="font-size:20px;margin-right:10px"></span>Đơn huỷ  </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</aside>