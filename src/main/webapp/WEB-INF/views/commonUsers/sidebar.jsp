<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="sidebar">
    <div class="sidebar-start">
        <div class="sidebar-head">
            <a href="/" class="logo-wrapper" title="Home">
                <span class="logo-title" style="color:white" id="userName"></span>
                <span class="logo-title" style="color:white" id="rate"></span>
                <span class="logo-title" style="color:white" id="rateKg"></span>
                <span class="logo-title" style="color:white" id="rateM3"></span>
            </a>
            <button class="sidebar-toggle transparent-btn" title="Menu" type="button">
                <span class="sr-only">Toggle menu</span>
                <span class="icon menu-toggle" aria-hidden="true"></span>
            </button>
        </div>
        <div class="sidebar-body">
            <ul class="sidebar-body-menu">
                <li>
                    <a class="show-cat-btn active">
                        Quản lý
                        <span class="category__btn transparent-btn" title="Open list">
                          <span class="sr-only">Open list</span>
                          <span class="icon arrow-down" aria-hidden="true"></span>
                        </span>
                    </a>
                    <ul class="cat-sub-menu">
                        <li>
                            <a class="a-decorate" href="/">
                                Trang chủ
                            </a>
                        </li>
                        <li>
                            <a href="/user/statistics/chargDetail">Nạp tiền</a>
                        </li>
                        <li>
                            <a class="a-decorate" href="/baogia">
                                Biểu phí
                            </a>
                        </li>
                        <li>
                            <a class="a-decorate" href="/policies">
                                Quy định và Chính sách
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</aside>
