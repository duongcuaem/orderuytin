<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="shortcut icon" href="/img/svg/logo.svg" type="image/x-icon">
    <script src="/asset/gdqc/assets/js/core/jquery.min.js"></script>
    <script src="/asset/gdqc/assets/js/core/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/7fef329ee5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/asset/frontend/css/index_01.css">
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">

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
    </style>
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
                            <img src="/orderuytin/orderuytin.jpg" alt="image" style="margin-top: -15px;height: 85px;width:200px">
                        </a>
                    </div>

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse navbar-ex1-collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a class="a-decorate" href="/">Trang chủ</a></li>
                            <li><a class="a-decorate" href="/baogia">Biểu phí</a></li>
                            <li><a class="a-decorate" href="/policies">Quy định và Chính sách</a></li>
                            <li><a class="brand-logo" href="/signup">Đăng ký</a></li>
                            <li><a class="a-decorate" href="/doLogin">Đăng nhập</a></li>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div>
            </nav>
        </div>
    </div>

    <div style="background-image: url('/orderuytin/banner.jpg');min-height: 100px; background-attachment: fixed; background-position: center; background-repeat: no-repeat; background-size: cover;">
        <div style="padding:10%;text-align:center;font-size:30px;font-weight:bold;background: rgba(0, 0, 0, 0.5);color: #f1f1f1;">
            <h1>CHUYÊN ĐẶT HÀNG TỪ TẤT CẢ CÁC NỀN TẢNG THƯƠNG MẠI ĐIỆN TỬ HÀNG ĐẦU TRUNG QUỐC</h1>
            <p>Tư vấn, tìm kiếm nguồn hàng và nhập hàng trực tuyến từ rất nhiều nguồn hàng đa dạng phong phú từ khắp Trung Quốc.</p>
            <p>Chúng tôi cam kết một dịch vụ vượt trội và cải tiến liên tục</p>
            <p>Bạn cần nhập hàng! Hãy đến với ORDERUYTIN.COM!</p>
        </div>
    </div>

    <div class="order-source">
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-md-offset-1 col-lg-offset-1">
                <div class="source-title">
                    <div class="head-text">Website đặt hàng</div>
                    <div class="content-text">
                        Orderuytin.com là đơn vị cung cấp dịch vụ trung gian nhập hàng từ các website thương mại điện tử hàng đầu Trung Quốc như: wholesaler.alibaba.com, 1688.com, taobao.com, tmall.com...
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <a href="https://1688.com/" target="_blank" class="no-decorate">
                    <div class="div-box">
                        <div class="thumbnail">
                            <img src="https://ordertietkiem.com//ordertietkiem/logo1688.png" alt="...">
                            <div class="caption">
                                <h3></h3>
                                <p>Giá cả cạnh tranh, đảm bảo rẻ nhất trên thị trường order ....</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <a href="https://tmall.com/" target="_blank" class="no-decorate">
                    <div class="div-box">
                        <div class="thumbnail">
                            <img src="https://ordertietkiem.com//ordertietkiem/logotmall.png" alt="...">
                            <div class="caption">
                                <p>Chất lượng và dịch vụ tốt nhất, đảm bảo uy tín cao....</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <a href="https://taobao.com/" target="_blank" class="no-decorate">
                    <div class="div-box">
                        <div class="thumbnail">
                            <img src="https://ordertietkiem.com//ordertietkiem/logotaobao.png" alt="...">
                            <div class="caption">
                                <p>Hàng về đều, liên tục...</p>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <div style="background-image: url('/orderuytin/banner1.jpg');min-height: 500px; background-attachment: fixed; background-position: center; background-repeat: no-repeat; background-size: cover;">
        <div style="padding:10%;text-align:center;font-size:50px;font-weight:bold;background: rgba(0, 0, 0, 0.5);color: #f1f1f1;">
            Orderuytin.com tự hào với đội ngũ nhân viên chuyên nghiệp, nhiệt tình, hỗ trợ đắc lực cho khách hàng, đáp ứng kì vọng trong một thị trường đầy biến động.
        </div>
    </div>

    <div class="content">
        <div class="container">
            <div class="head-text">Dịch vụ Orderuytin.com cung cấp</div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="content-size">
                    <div class="img-service">
                        <img src="https://ordertietkiem.com//ordertietkiem/a1.jpg">
                    </div>
                    <div class="img-content">
                        <div class="head-img">
                            <b>Order hàng</b>
                        </div>
                        <div class="content-text">
                            Dịch vụ đặt hàng trực tiếp trên các trang taobao.com, 1688.com, tmall.com với phí dịch vụ rẻ nhất cho khách hàng ...
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="content-size">
                    <div class="img-service">
                        <img src="https://ordertietkiem.com//ordertietkiem/a3.png">
                    </div>
                    <div class="img-content">
                        <div class="head-img">
                            <b>Tìm nguồn hàng</b>
                        </div>
                        <div class="content-text">
                            Dịch vụ tìm nguồn hàng, đàm phán, ký kết hợp đồng với Nhà Cung Cấp uy tín tại Trung Quốc ...
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="content-size">
                    <div class="img-service">
                        <img src="https://ordertietkiem.com//ordertietkiem/a2.jpg">
                    </div>
                    <div class="img-content">
                        <div class="head-img">
                            <b>Ship hộ hàng</b>
                        </div>
                        <div class="content-text">
                            Dịch vụ chuyển hàng từ TQ về Việt Nam với giá thành thấp nhất, đảm bảo uy tín, thời gian, vận chuyển trên toàn quốc ...
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="background-image: url('/orderuytin/banner2.jpg');min-height: 500px; background-attachment: fixed; background-position: center; background-repeat: no-repeat; background-size: cover;">
        <div style="padding:10%;background: rgba(0, 0, 0, 0.5);color: #f1f1f1;">
            <div class="rate-img">
                <div class="container">
                    <div class="div-padding">
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                            <div class="rate-out">
                                <i class="fa-solid fa-hourglass" style="font-size:60px"></i>
                                <div class="rate-detail">
                                    <span class="increment">9</span>h23'
                                </div>
                                TB từ khi khách đặt hàng tới khi mua thành công (gồm Thứ Bẩy và Chủ Nhật).
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                            <div class="rate-out">
                                <i class="fa-solid fa-check" style="font-size:60px"></i>
                                <div class="rate-detail">
                                    <span class="increment">98</span>%
                                </div>
                                Tỉ lệ đơn nhập thành công (ngoài ra là các đơn hết hàng do người bán).
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                            <div class="rate-out">
                                <i class="fa-solid fa-clock" style="font-size:60px"></i>
                                <div class="rate-detail">
                                    <span class="increment">155</span>H8'
                                </div>
                                TB từ khi Quý khách đặt hàng tới khi hàng về HP.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="info">
        <div class="container">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="info-content">
                    <div class="head-text">
                        <b>Dịch vụ nhập hàng chuyên nghiệp từ</b>
                    </div>
                    <div class="info-detail">
                        <p>- Đặt đơn hàng thuận tiện nhanh chóng với nhiều tiện ích hỗ trợ.</p>
                        <p>- Quản lý đơn hàng, Vận chuyển, Tài chính chuyên nghiệp, dễ dàng theo dõi.</p>
                        <p>- Có chính sách bảo hiểm rủi ro hàng hóa.</p>
                        <p>- Đội ngũ nhân viên hỗ trợ chăm sóc chu đáo nhiệt tình 24/7.</p>
                        <p>- Mục tiêu chính là thúc đẩy hợp tác thành công và cùng có lợi nhuận.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var dem = [0, 0, 0];
        $(window).scroll(function() {
            var top = $(window).scrollTop();
            $(".increment").each(function(index) {
                if (dem[index] == 0) {
                    var vi_tri = $(this).parent().parent().parent().position().top;
                    var so = $(this).text();
                    var obj = $(this);
                    if ((top >= vi_tri - 300) && (top <= vi_tri - 200)) {
                        dem[index]++;
                        var k = 0;
                        var id = setInterval(frame, 20);
                        function frame() {
                            if (k >= so) {
                                clearInterval(id);
                            } else {
                                if (so <= 10) {
                                    k = k + 0.1;
                                    var h = Math.floor(k);
                                    obj.text(h);
                                } else {
                                    k++;
                                    obj.text(k);
                                }
                            }
                        }
                    }
                }
            });
        });
    </script>

    <footer>
        <div class="container">
            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                <div class="div-h3"><h4><b>Menu</b></h4></div>
                <ul class="list-info">
                    <li class="item-list"><a href="/baogia">Biểu phí</a></li>
                    <li class="item-list"><a href="/policies">Quy định chính sách</a></li>
                </ul>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="list-div">
                    <div><h4><b>Văn phòng Hải Phòng</b></h4></div>
                    <div class="right-div">0865150693</div>
                    <div class="right-div">đường Trần Nguyên Hãn, quận Lê Chân, Thành phố Hải Phòng</div>
                </div>
            </div>
        </div>
    </footer>

    <script type="text/javascript" src="asset/thqc/LTE/plugins/ordertietkiemjs/frontend.js"></script>
    <script src="asset/ordertietkiem/parallax.js"></script>
    <style>
        @media (min-width: 992px) {
            .modal-lg {
                width: 1100px;
            }
        }
    </style>

    <script type="text/javascript">
        $('.parallax-img').parallax({
            speed: 0.2
        });
    </script>

    <!-- Thêm đoạn script mới -->
    <script>
        let stompClient;

        // User Authentication
        const token = localStorage.getItem('token');
        console.log(token);
        if (token) {
            var url = "http://localhost:8080/api/me";
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
                   // window.location.href = "/dologin";
                    return;
                }
                let data = await response.json();
                // Populate user details in profile section
                // document.getElementById('fullName').textContent = data.fullName || 'N/A';
                // document.getElementById('avatar').src = data.avatar || 'N/A';
                // document.getElementById('userId').textContent = data.userId || 'N/A';
                // document.getElementById('socialcode').textContent = data.socialcode || 'N/A';
                // document.getElementById('username').textContent = data.username || 'N/A';
                // document.getElementById('email').textContent = data.email || 'N/A';
                // document.getElementById('phone').textContent = data.phone || 'N/A';
                // document.getElementById('address').textContent = data.address || 'N/A';
                // document.getElementById('description').textContent = data.description || 'N/A';
                console.log(data)
                var userItem = 0;
                // Lưu Id vào storage
                if (data.userId != null) {
                    localStorage.setItem('userId', data.userId);
                    userItem = data.userId;
                } else {
                    if (data.socialcode != null) {
                        localStorage.setItem('userId', data.socialcode);
                        userItem = data.socialcode;
                    }
                }
                console.log(userItem);
               // connect(userItem);
            } catch (error) {
                console.error('Error fetching user details:', error);
                localStorage.removeItem('token');
                window.location.href = "/dologin";
            }
        }

        // Logout function
        function logout() {
            callLogout();
        }

        function callLogout() {
            const token = localStorage.getItem('token');
            if (token) {
                fetch('http://localhost:8080/api/logout', {
                    method: 'POST',
                    headers: {
                        'Authorization': 'Bearer ' + token,
                        'Content-Type': 'application/json'
                    }
                }).then(response => {
                    if (response.ok) {
                        localStorage.removeItem('token');
                        window.location.href = "/dologin";
                    } else {
                        console.error('Logout failed');
                    }
                });
            } else {
                localStorage.removeItem('token');
                window.location.href = "/dologin";
            }
        }


        // WebSocket Client Setup
        function connect(userId) {
            stompClient = new StompJs.Client({
                brokerURL: 'ws://localhost:8080/ws'
            });

            stompClient.onConnect = (frame) => {
                console.log('Connected: ' + frame);
                console.log('UserId: ' + userId);
                console.log('/user/' + userId + '/specific/notifications');
                // Đăng ký để nhận thông báo từ kênh queue cho người dùng cụ thể (thông báo cá nhân)
                stompClient.subscribe('/user/specific/notifications', function (notification) {
                    showNotification(JSON.parse(notification.body));
                });
                // Đăng ký để nhận thông báo từ kênh topic (thông báo chung)
                stompClient.subscribe('/all/notifications', function (notification) {
                    showNotification(JSON.parse(notification.body));
                });
            };

            stompClient.onWebSocketError = (error) => {
                console.error('Error with websocket', error);
            };

            stompClient.onStompError = (frame) => {
                console.error('Broker reported error: ' + frame.headers['message']);
                console.error('Additional details: ' + frame.body);
            };

            stompClient.activate();
        }

        // Display notification
        function showNotification(notification) {
            const notificationElement = document.getElementById('notification');
            document.getElementById('notification-content').textContent = notification.message;
            notificationElement.style.display = 'block';
            setTimeout(() => {
                notificationElement.style.display = 'none';
            }, 10000);
        }

        // Send notification to all
        function sendNotificationToAll() {
            const messageContent = $('#messageToAll').val();
            const notification = {
                message: messageContent,
                category: "general",
                type: "general",
                status: "unread"
            };
            fetch('http://localhost:8080/notifyAll', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(notification)
            }).then(response => {
                if (response.ok) {
                    console.log("Notification sent to all");
                } else {
                    console.error("Failed to send notification");
                }
            });
        }

        // Send notification to specific user
        function sendNotificationToUser() {
            const selectedUser = $("#users").val();
            const messageContent = $('#messageToUser').val();
            const notification = {
                message: messageContent,
                recipient: selectedUser,
                category: "personal",
                type: "personal",
                status: "unread"
            };
            fetch('http://localhost:8080/sendPersonalNotification?userId=' + 0, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(notification)
            }).then(response => {
                console.log(response);
                if (response.ok) {
                    console.log("Notification sent to user " + selectedUser);
                } else {
                    console.error("Failed to send notification");
                }
            });
        }

        // jQuery event handlers
        // $(function () {
        //     $("#sendToAll").click(() => sendNotificationToAll());
        //     $("#sendToUser").click(() => sendNotificationToUser());
        // });
    </script>
</body>
</html>
