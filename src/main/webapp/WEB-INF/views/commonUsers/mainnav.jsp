<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<style>
    .notification-popup li {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }

    .notification-popup li:last-child {
        border-bottom: none;
    }

    .notification-popup .notification-item {
        display: flex;
        flex-direction: column;
    }

    .notification-popup .notification-item .notification-header {
        display: flex;
        justify-content: space-between;
        font-size: 14px;
        color: #666;
    }

    .notification-popup .notification-item .notification-body {
        margin-top: 5px;
        font-size: 16px;
        color: #333;
    }

    .notification-toast {
        position: fixed;
        bottom: 10px;
        right: 10px;
        background-color: #333;
        color: white;
        padding: 10px;
        border-radius: 5px;
        z-index: 1000;
        display: none;
    }

    /* Style cho popup thông báo đặc biệt */
    .special-notification-popup {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        color: black;
        border: 1px solid #ccc;
        padding: 20px;
        z-index: 1000;
        display: none;
        border: solid 4px #4d26b2;
        border-radius: 20px;
        width: 400px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    /* Style cho header của thông báo đặc biệt */
    .special-notification-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* Style cho nút đóng */
    .close-btn {
        background: none;
        border: none;
        font-size: 20px;
        cursor: pointer;
        color: #333;
    }

    /* Style cho phần nội dung thông báo */
    .special-notification-content {
        margin-top: 10px;
    }
</style>

<nav class="main-nav--bg" style="background-color: black">
    <div class="container main-nav">
        <div class="main-nav-start">
            <form action="/user/search/searchOrder" method="post">
                <div class="search-wrapper" style="display:flex;flex-direction:row">
                    <i data-feather="search" aria-hidden="true"></i>
                    <input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng qua miêu tả sản phẩm !!! ..." required>
                    <button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
                </div>
            </form>
        </div>
        <div class="main-nav-end">
            <button class="sidebar-toggle transparent-btn" title="Menu" type="button">
                <span class="sr-only">Toggle menu</span>
                <span class="icon menu-toggle--gray" aria-hidden="true"></span>
            </button>

            <div style="color:white;font-size:35px">
                <a href="/user/item/createItem"><i class="fa-solid fa-pen-to-square"></i></a>
            </div>

            <div style="color:white;font-size:35px"><a href="/user/home"><i class="fa-solid fa-house-user"></i></a></div>
            <div style="color:white;">
                <a href="/user/item/cart">
                    <p style="color:red;font-size:15px;float:right" id="countCartItem"></p>
                    <i class="fa-solid fa-cart-shopping" style="font-size:35px"></i>
                </a>
            </div>
            <div style="color:white;">
                <a href="/user/item/cart">
                    <p style="color:red;font-size:15px;float:right" id="countCartItem"></p>
                    <i class="fa-solid fa-cart-shopping" style="font-size:35px"></i>
                </a>
            </div>
            <div style="color:white;font-size:35px;position:relative;">
                <p style="color:red;font-size:15px;float:right" id="notificationCount">0</p>
                <i id="notificationIcon" class="fa-solid fa-bell"></i>
                <ul id="notificationList" class="notification-popup" style="display:none;position:absolute;top:40px;right:0;background-color:white;color:black;border:1px solid #ccc;padding:10px;list-style:none;z-index:1000;width:300px;">
                    <li id="noNotification" style="display:none;">Không có thông báo</li>
                </ul>
            </div>
            <div>
                <!-- Add a logout button -->
                <button onclick="logout()" style="color:white;background-color:black;font-size:35px"><i class="fa-solid fa-right-from-bracket"></i></button>
            </div>
        </div>
    </div>
    <!-- Notification Popup -->
    <div id="notification-new" class="notification-popup"></div>
    <!-- Special Notification Popup -->
    <div id="specialNotificationPopup" class="special-notification-popup">
        <!-- Header của thông báo đặc biệt -->
        <div class="special-notification-header">
            <!-- Thông tin người gửi -->
            <span id="specialNotificationSender"></span>
            <!-- Nút đóng thông báo -->
            <button class="close-btn" onclick="closeSpecialNotification()">✖</button>
        </div>
        <!-- Thời gian thông báo -->
        <span id="specialNotificationTime"></span>
        <br>
        <!-- Nội dung thông báo -->
        <p id="specialNotificationText" class="special-notification-content"></p>
    </div>

    <div style="display:flex;flex-direction:row;justify-content:space-between;margin:5px;text-align:center;color:white">
        <div>
            <p style="font-size:15px;float:right" id="countWholeOrder"></p>
            </br><a style="font-size:15px;" href="/user/order/whole">Tất cả</a>
        </div>
        <div>
            </br>|</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countPendingOrder"></p>
            </br><a style="font-size:15px" href="/user/order/pending"> Chờ mua </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countBoughtOrder"></p>
            </br> <a style="font-size:15px" href="/user/order/bought"> Đã mua</a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countDeliveredOrder"></p>
            </br> <a style="font-size:15px" href="/user/order/deliveried"> Đã phát</a>
        </div>
        <div>
            </br>|</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countArriveredOrder"></p>
            </br> <a style="font-size:15px" href="/user/order/arrivered">Về kho </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countComplainOrder"></p>
            </br><a style="font-size:15px" href="/user/order/complain"> Khiếu nại </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countFinishedOrder"></p>
            </br> <a style="font-size:15px" href="/user/order/finished"> Thành công </a>
        </div>
        <div>
            </br> |</br>|
        </div>
        <div>
            <p style="font-size:15px;float:right" id="countCancelOrder"></p>
            </br> <a style="font-size:15px" href="/user/order/cancel"> Đơn huỷ </a>
        </div>
    </div>
</nav>

<div id="notificationToast" class="notification-toast"></div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const token = localStorage.getItem('token');
        if (!token) {
            window.location.href = '/doLogin';
        } else {
            fetch('/api/me', {
                method: 'GET',
                headers: {
                    'Authorization': `Token ` + token
                }
            }).then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            }).then(data => {
                console.log(data);
                var userItem = 0;
                // Lưu Id vào storage
                if (data.socialcode != null) {
                    localStorage.setItem('userId', data.socialcode);
                    userItem = data.socialcode;
                } else {
                    if (data.userId != null) {
                        localStorage.setItem('userId', data.userName);
                        userItem = data.userName;
                    }
                }
                // Lấy thông báo từ DB
                getNotifications(userItem, 0, 10);
                // Kết nối tới WebSocket
                connect(userItem);
            }).catch(error => {
                console.error('Có lỗi xảy ra:', error);
                window.location.href = '/doLogin';
            });
        }
        const notificationIcon = document.getElementById('notificationIcon');
        const notificationList = document.getElementById('notificationList');

        notificationIcon.addEventListener('mouseover', function() {
            notificationList.style.display = 'block';
        });

        notificationIcon.addEventListener('mouseout', function() {
            notificationList.style.display = 'none';
        });
    });

    // WebSocket Client Setup
    var stompClient = null;

    function connect(userItem) {
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            console.log('Connected: ' + frame);
            
            // Đăng ký để nhận thông báo từ kênh topic (thông báo chung)
            stompClient.subscribe('/all/notifications', function (messageOutput) {
                showNotification(JSON.parse(messageOutput.body));
            });

            // Đăng ký để nhận thông báo từ kênh specific cho người dùng cụ thể (thông báo cá nhân)
            stompClient.subscribe('/user/specific/notifications' , function (messageOutput) {
                showNotification(JSON.parse(messageOutput.body));
            });
        });
    };

    var listNotification = [];
    //Lấy thông báo người dùng
    async function getNotifications(recipient, page, size) {
        console.log("recipient: " + recipient + " page: " + page + " size: " + size);
        try {
            const url = "/notifications?recipient=" + recipient + "&page=" + page + "&size=" + size;
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

    function displayNotifications(notifications) {
        const notificationList = document.getElementById('notificationList');
        const noNotification = document.getElementById('noNotification');

        notificationList.innerHTML = '';
        if (notifications.length === 0) {
            noNotification.style.display = 'block';
        } else {
            noNotification.style.display = 'none';
            notifications.forEach(notification => {
                const notificationItem = document.createElement('li');
                notificationItem.classList.add('notification-item');
                
                const notificationHeader = document.createElement('div');
                notificationHeader.classList.add('notification-header');
                const sender = document.createElement('span');
                sender.innerText = notification.sender; // Assuming the notification object has a sender field
                const time = document.createElement('span');
                time.innerText = new Date(notification.createdAt).toLocaleString(); // Assuming the notification object has a timestamp field
                notificationHeader.appendChild(sender);
                notificationHeader.appendChild(time);
                
                const notificationBody = document.createElement('div');
                notificationBody.classList.add('notification-body');
                notificationBody.innerText = notification.message;
                
                notificationItem.appendChild(notificationHeader);
                notificationItem.appendChild(notificationBody);
                notificationList.appendChild(notificationItem);
            });
        }
        document.getElementById('notificationCount').innerText = notifications.length;
    }

    function showNotification(notification) {
        console.log(notification);
        
        if (notification.type == "1") {
            // Hiển thị thông báo đặc biệt ở giữa màn hình
            document.getElementById('specialNotificationSender').innerText = notification.fromName; // Thông tin người gửi
            document.getElementById('specialNotificationTime').innerText = new Date(notification.createdAt).toLocaleString(); // Thời gian thông báo
            document.getElementById('specialNotificationText').innerText = notification.message; // Nội dung thông báo
            document.getElementById('specialNotificationPopup').style.display = 'block';
        } else {
            // Hiển thị thông báo ở góc dưới phải màn hình
            const notificationToast = document.getElementById('notificationToast');
            notificationToast.innerText = notification.message;
            notificationToast.style.display = 'block';
            setTimeout(() => {
                notificationToast.style.display = 'none';
            }, 5000);
        }
        
        const notificationList = document.getElementById('notificationList');
        const noNotification = document.getElementById('noNotification');
        
        if (noNotification) {
            noNotification.style.display = 'none';
        }

        const notificationItem = document.createElement('li');
        notificationItem.classList.add('notification-item');

        const notificationHeader = document.createElement('div');
        notificationHeader.classList.add('notification-header');
        const sender = document.createElement('span');
        sender.innerText = notification.fromName; // Thông tin người gửi
        const time = document.createElement('span');
        time.innerText = new Date(notification.createdAt).toLocaleString(); // Thời gian thông báo
        notificationHeader.appendChild(sender);
        notificationHeader.appendChild(time);

        const notificationBody = document.createElement('div');
        notificationBody.classList.add('notification-body');
        notificationBody.innerText = notification.message;

        notificationItem.appendChild(notificationHeader);
        notificationItem.appendChild(notificationBody);
        notificationList.appendChild(notificationItem);

        let count = parseInt(document.getElementById('notificationCount').innerText);
        document.getElementById('notificationCount').innerText = count + 1;
    }

    function closeSpecialNotification() {
        document.getElementById('specialNotificationPopup').style.display = 'none';
    }

    // Logout function
    function logout() {
        callLogout();
    }

    function callLogout() {
        const token = localStorage.getItem('token');
        if (token) {
            fetch('/api/logout', {
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
</script>
