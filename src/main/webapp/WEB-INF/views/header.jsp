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
        #user-info {
            position: relative;
        }
        #user-info .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            border: 1px solid #ccc;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 10px;
            border-radius: 4px;
        }
        #user-info:hover .dropdown-menu {
            display: block;
        }
        #user-info .dropdown-menu li {
            list-style: none;
            padding: 5px 0;
        }
        #user-info .dropdown-menu li a {
            color: #333;
            text-decoration: none;
            padding: 5px 10px;
            display: block;
        }
        #user-info .dropdown-menu li a:hover {
            background-color: #f5f5f5;
            border-radius: 4px;
        }
        #notification-icon {
            position: relative;
            margin-right: 10px;
        }
        #notification-icon .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            border: 1px solid #ccc;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 10px;
            border-radius: 4px;
            width: 300px;
            max-height: 400px;
            overflow-y: auto;
        }
        #notification-icon:hover .dropdown-menu {
            display: block;
        }
        #notification-icon .dropdown-menu li {
            list-style: none;
            padding: 5px 0;
        }
        #notification-icon .dropdown-menu li a {
            color: #333;
            text-decoration: none;
            padding: 5px 10px;
            display: block;
        }
        #notification-icon .dropdown-menu li a:hover {
            background-color: #f5f5f5;
            border-radius: 4px;
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
        .notification-popup {
            position: fixed;
            top: 5px;
            right: 20px;
            background-color: #00cfbe;
            border: 1px solid #43897b;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
            display: none;
            z-index: 444444;
        }
        .notification-icon {
            position: relative;
        }
        .notification-count {
            position: absolute;
            top: 0px;
            right: 0px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 0px 5px;
            font-size: 12px;
        }
        .user-info-container {
            display: flex;
            align-items: center;
        }
        .user-info-container img {
            margin-right: 8px;
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
                            <li id="user-info" class="dropdown" style="display: none;">
                                <a href="#" class="dropdown-toggle user-info-container" data-toggle="dropdown">
                                    <img id="avatar" alt="Avatar" style="width:32px; height:30px; border-radius:50%;">
                                    <span id="fullName"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="#" onclick="viewProfile()">Profile</a></li>
                                    <li><a href="#" onclick="logout()">Logout</a></li>
                                </ul>
                            </li>
                            <li id="signup"><a class="brand-logo" href="/signup">Đăng ký</a></li>
                            <li id="login"><a class="a-decorate" href="/doLogin">Đăng nhập</a></li>
                            <li id="notification-icon" class="dropdown" style="display: none;">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-bell"></i>
                                    <span id="notification-count" class="notification-count" style="display: none;">0</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li id="no-notifications" style="text-align: center; color: #999;">Không có thông báo</li>
                                </ul>
                            </li>
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
                    window.location.href = "/doLogin";
                    return;
                }
                let data = await response.json();
                // Populate user details in profile section
                document.getElementById('fullName').textContent = data.fullName || 'N/A';
                if(data.avatar == null){
                    document.getElementById('avatar').style.display = 'none'; 
                }else{
                    document.getElementById('avatar').src = data.avatar;   
                }
                // Show user info and hide signup/login
                document.getElementById('user-info').style.display = 'flex';
                document.getElementById('signup').style.display = 'none';
                document.getElementById('login').style.display = 'none';
                document.getElementById('notification-icon').style.display = 'block';

                console.log(data);
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
                getNotifications(userItem, 0, 5);
                connect(userItem);
            } catch (error) {
                console.error('Error fetching user details:', error);
                localStorage.removeItem('token');
                window.location.href = "/doLogin";
            }
        }

        var listNotification = [];
        //Lấy thông báo người dùng
        async function getNotifications(recipient, page, size) {
            console.log("recipient: " + recipient + " page: " + page + " size: " + size);
            try {
                const url = "http://localhost:8080/notifications?recipient=" + recipient + "&page=" + page + "&size=" + size;
                console.log(url);
                const response = await fetch(url);
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                const notificationsPage = await response.json();
                console.log(notificationsPage);
                listNotification = notificationsPage.content;
                displayNotifications(listNotification);
            } catch (error) {
                console.error('Có lỗi xảy ra:', error);
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
                        window.location.href = "/doLogin";
                    } else {
                        console.error('Logout failed');
                    }
                });
            } else {
                localStorage.removeItem('token');
                window.location.href = "/doLogin";
            }
        }

        // WebSocket Client Setup
        var stompClient = null;

        function connect(userItem) {
            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            console.log("1");
            stompClient.connect({}, function (frame) {
                console.log('Connected: ' + frame);
                
                // Đăng ký để nhận thông báo từ kênh topic (thông báo chung)
                stompClient.subscribe('/all/notifications', function (messageOutput) {
                    listNotification.push(JSON.parse(messageOutput.body));
                    displayNotifications(listNotification);
                    showNotificationPopup(JSON.parse(messageOutput.body));
                });
                
                // Đăng ký để nhận thông báo từ kênh specific cho người dùng cụ thể (thông báo cá nhân)
                stompClient.subscribe('/user/' + userItem + '/notifications', function (messageOutput) {
                    listNotification.push(JSON.parse(messageOutput.body));
                    showNotificationPopup(JSON.parse(messageOutput.body));
                    displayNotifications(listNotification);
                    console.log("2");
                });
            });
        };

        function disconnect() {
            if (stompClient !== null) {
                stompClient.disconnect();
            }
            console.log("Disconnected");
        };

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
            fetch('http://localhost:8080/sendPersonalNotification?userId=' + selectedUser, {
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

        function viewProfile() {
            window.location.href = "/profile";
        }

        // Hàm để hiển thị thông báo lên bảng
        function displayNotifications(notifications) {
            const dropdownMenu = document.querySelector('#notification-icon .dropdown-menu');
            const noNotificationsElement = document.getElementById('no-notifications');
            const notificationCountElement = document.getElementById('notification-count');

            // Xóa các thông báo cũ nếu có
            dropdownMenu.innerHTML = '';
            dropdownMenu.appendChild(noNotificationsElement);

            if (notifications.length === 0) {
                noNotificationsElement.style.display = 'block';
                notificationCountElement.style.display = 'none';
            } else {
                noNotificationsElement.style.display = 'none';
                notificationCountElement.style.display = 'block';
                notificationCountElement.textContent = notifications.length;

                notifications.forEach(notification => {
                    const li = document.createElement('li');
                    li.innerHTML = `
                        <div>
                            <strong>Từ: </strong>`+ notification.fromName +`<br>
                            <strong>Nội dung:</strong> `+ notification.message +`<br>
                            <strong>Thời Gian:</strong>`+ notification.createdAt +`
                        </div>
                    `;
                    dropdownMenu.appendChild(li);
                });
            }
        }

        function showNotificationPopup(notification) {
            const popup = document.getElementById('notification-new');
            popup.innerHTML = `
                <strong>Từ: </strong>`+ notification.fromName +`<br>
                <strong>Nội dung:</strong>`+ notification.message + `<br>
            `;
            popup.style.display = 'block';
            setTimeout(() => {
                popup.style.display = 'none';
            }, 5000);
        }

        // jQuery event handlers
        $(function () {
            $("#sendToAll").click(() => sendNotificationToAll());
            $("#sendToUser").click(() => sendNotificationToUser());
        });
    </script>
</body>
</html>
