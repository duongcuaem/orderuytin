<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm hàng trung quốc giá rẻ</title>
    <meta name="description" content="">
    <meta name="keywords" content="dat hang trung quoc, mua hang trung quoc, van chuyen hang">
    <meta charset="utf-8">
    <meta name="author" content="order">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- Load Core CSS -->
    <link rel="stylesheet" href="/asset/gdqc/assets/css/core/bootstrap.min.css">
    <link rel="stylesheet" href="/asset/frontend/css/index_01.css">
    <link rel="shortcut icon" href="/img/svg/logo.svg" type="image/x-icon">
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">

    <!-- Custom CSS -->
    <style type="text/css">
        .bg-green {
            background: #5cb85c;
        }
        body {
            font-family: Arial;
            font-size: 16px;
        }
        .div-decorate a.cart-icon i {
            padding: 2px 3px 0 0;
        }
        
        
        .navbar-nav {
            display: flex;
            align-items: stretch;
        }
        .navbar-nav > li {
            display: flex;
            align-items: center;
            height: 100%;
        }
       
        .brand-logo img {
            height: 50px;
        }
    </style>

    <!-- Load JS -->
    <script src="/asset/gdqc/assets/js/core/jquery.min.js"></script>
    <script src="/asset/gdqc/assets/js/core/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/7fef329ee5.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body class="darkmode">
    <div class="nav-margin">
        <div id='div-fix' class="">
            <nav class="navbar navbar-default navbar-fixed-top nav-head" role="navigation">
                <div class="container-fluid">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="brand-logo" href="http://www.orderuytin.com/">
                            <img src="/orderuytin/orderuytin.jpg" alt="Logo">
                        </a>
                    </div>
                    <div class="collapse navbar-collapse navbar-ex1-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a class="a-decorate" href="/">Trang chủ</a></li>
                            <li><a class="a-decorate" href="/baogia">Biểu phí</a></li>
                            <li><a class="a-decorate" href="/policies">Quy định và Chính sách</a></li>
                            <li id="signup"><a class="brand-logo" href="/signup">Đăng ký</a></li>
                            <li id="login"><a class="a-decorate" href="/doLogin">Đăng nhập</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <!-- Notification Popup -->
    <div id="notification-new" class="notification-popup"></div>

    <!-- Custom JS -->
    <script type="text/javascript">
        // User Authentication
        const token = localStorage.getItem('token');
        console.log(token);
        if (token) {
            var url = "http://localhost:8080/userRedirection";
            fetchDetailWithToken(url, token);
        }

        // Fetch user details with token
        async function fetchDetailWithToken(url, token) {
            try {
                let response = await fetch(url, {
                    headers: {
                        'Authorization': 'Token ' + token
                    }
                });
                if (!response.ok) {
                    localStorage.removeItem('token');
                    window.location.href = "/doLogin";
                    return;
                }
                let data = await response.json();
            } catch (error) {
                console.error('Error fetching user details:', error);
                localStorage.removeItem('token');
                window.location.href = "/doLogin";
            }
        }
    </script>
</body>
</html>
