<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/commonUsers/head.jsp"></jsp:include>
    <link rel="shortcut icon" type="image/x-icon" href="/orderuytin/orderuytin.jpg">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/commonUsers/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <nav class="main-nav--bg" style="background-color: black">
            <div class="container main-nav">
                <div class="main-nav-start">
                    <form  action="/user/search/searchOrder" method="post">
                        <div class="search-wrapper" style="display:flex;flex-direction:row">
                            <i data-feather="search" aria-hidden="true"></i>
                            <input type="text" name="search" placeholder="Hãy tìm kiếm đơn hàng qua miêu tả sản phẩm !!! ..." required>
                            <button type="submit" style="border-radius:5px;padding:2px;color:white;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white"> Tìm kiếm </button>
                        </div>
                    </form>
                </div>
                <div class="main-nav-end">
                    <button class="sidebar-toggle transparent-btn" class="mainnavIcon" title="Menu" type="button">
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
                    <div style="color:white;font-size:35px;position:relative;">
						<p style="color:red;font-size:15px;float:right" id="notificationCount">0</p>
						<i id="notificationIcon" class="fa-solid fa-bell"></i>
						<ul id="notificationList" class="notification-popup" style="display:none;position:absolute;top:40px;right:0;background-color:white;color:black;border:1px solid #ccc;padding:100px;list-style:none;z-index:1000;">
							<!-- Notification items will be appended here -->
						</ul>
					</div>
                    <div >
                        <!-- Add a logout button -->
                        <form:form action="/logout"   method="POST">
                            <button type="submit"  style="color:white;background-color:black;font-size:35px"><i class="fa-solid fa-right-from-bracket"></i></button>
                        </form:form>
                    </div>
                </div>
            </div>
            <!-- Notification Popup -->
			<div id="notification-new" class="notification-popup"></div>
			<!-- Special Notification Popup -->
			<div id="specialNotificationPopup" class="special-notification-popup" style="display:none;position:fixed;top:50%;left:50%;transform:translate(-50%, -50%);background:white;color:black;border:1px solid #ccc;padding:20px;z-index:1000;">
				<p id="specialNotificationText"></p>
				<button onclick="closeSpecialNotification()">Close</button>
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
                    <p style="font-size:15px;float:right">${countCancelOrder+countCancelItem}</p></br> <a style="color:yellow;font-size:25px;font-weight:bold"  href="/user/order/cancel"> Đơn huỷ  </a>
                </div>
            </div>
        </nav>

        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="height: 70vh; overflow: scroll">
            <div class="container">
                <div class="row stat-cards">
                    <c:forEach items="${showCancelItemListofClient}" var="i" >
                        <article class="stat-cards-item" style="margin: 5px;color:yellow;background-color:black;border-radius:10px;border-style:solid;border-width: thin;border-color:white">

                        <div style="display:flex;flex-direction:column;width:100%">

                                    <div style="display:none;">
                                        <input type="text"   name="itemId"  value="${i.itemId}"  path="itemId"  />
                                        <input type="text"   name="image"  value="${i.image}"  path="image" />
                                        <input type="text"   name="itemUserName"  value="${i.itemUserName}"  path="itemUserName"  />
                                        <input type="text"   name="itemStatus"  value="${i.itemStatus}"  path="itemStatus" id="itemStatus${i.itemId}"/>
                                        <input type="text"   name="CNYrateVND"  value="${i.CNYrateVND}"  path="CNYrateVND"  />
                                        <input type="text"   name="describle"  value="${i.describle}"  path="describle" />
                                        <input type="text"   name="price"  value="${i.price}"  path="price"  />
                                        <input type="text"   name="quantity"  value="${i.quantity}"  path="quantity" />
                                    </div>
                                    <div style="border-radius:10px; margin:5px">
                                        <div style="display:flex;flex-direction:column;width:100%;margin:10px">
                                            <div style="display:flex;flex-direction:row;width:100%;margin:10px">
                                                <div> <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" ></div>
                                                <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:20px">
                                                    <div style="width:100%"><a href="${i.link}">Click Link </a> <input type="text" style="width:80px" name="link" path="link" value="${i.link}" /></div>
                                                    <div style="width:100%"> ${i.describle}</div>
                                                    <div style="width:100%"> <fmt:formatNumber value = "${i.price}" type = "number"/> ¥ x ${i.quantity}</div>
                                                    <div style="width:100%"> = <fmt:formatNumber value = "${i.quantity*i.price}" type = "number"/> ¥ </div>
                                                    <div style="width:100%"> x ${i.CNYrateVND}  ¥/đ</div>
                                                    <div style="width:100%"> = <fmt:formatNumber maxFractionDigits="0" value = "${i.quantity*i.price*i.CNYrateVND}" type = "number"/> đ</div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                            </div>
                        </article>
                    </c:forEach>
                    <c:forEach items="${showCancelOrderListofClient}" var="sbol" >
                        <article class="stat-cards-item" style="margin: 5px">
                            <div style="display:flex;flex-direction:row;justify-content:space-between;width:95%">
                                <div >Ngày đặt :</br> <fmt:formatDate type = "date" value = "${sbol.receivedDate}" /></div>
                                <div >Mã đơn hàng : </br> ${sbol.orderNo} </div>
                            </div>
                            <div class="row">
                                <c:forEach items="${sbol.items}" var="i" >
                                    <c:set var="totalItemCN" value="${totalItemCN + i.price * i.quantity }"></c:set>
                                    <c:set var="totalItemVN" value="${totalItemVN + i.price * i.quantity*i.CNYrateVND }"></c:set>
                                    <div style="border-radius:10px; background-color:#DADBE4;margin:5px;display:flex">
                                        <div style="width:30%;">
                                            <img alt="image" src="<c:url value="/image/item/${i.image}" />" style="width:90px;height:150px;margin:5px" >
                                        </div>
                                        <div style="display:flex;flex-direction:column;justify-content: space-between;width:70%;margin-left:10px">
                                            <div style="width:100%;color:blue"> <a href="${i.link}"> Click Link :</a>  <input type="text" style="width:100px" name="link"  value="${i.link}"  path="link" /></div>
                                            <div style="width:100%;color:blue"> ${i.describle}</div>
                                            <div style="width:100%;color:blue"> Giá : <fmt:formatNumber maxFractionDigits="2" value = "${i.price}" type = "number"/> ¥</div>
                                            <div style="width:100%;color:blue"> Số lượng : ${i.quantity}</div>
                                            <div style="width:100%;color:blue"> Tỉ giá : ${i.CNYrateVND} ¥/đ</div>
                                            <div style="width:100%;color:blue"> Thành tiền : <fmt:formatNumber maxFractionDigits="2" value = "${i.price*i.quantity}" type = "number"/> ¥</div>
                                            <div style="width:100%;color:blue">  <fmt:formatNumber maxFractionDigits="2" value = "${i.price*i.quantity*i.CNYrateVND}" type = "number"/> đ</div>
                                        </div>
                                    </div>
                                </c:forEach >
                            </div>

                            <div style="display:flex;flex-direction:column;font-style: oblique;font-size: larger;margin:10px">
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%"><p>Tiền hàng (ko ship nđ) : </div>
                                    <div><fmt:formatNumber maxFractionDigits="2" value = "${totalItemVN}" type = "number"/> đ ( <fmt:formatNumber maxFractionDigits="2" value = "${totalItemCN}" type = "number"/> ¥ )</div>
                                </div>
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">Ship nội địa :  </div>
                                    <div> <fmt:formatNumber value = "${sbol.shipFeeVND}" type = "number"/> đ ( <fmt:formatNumber maxFractionDigits="2" value = "${sbol.shipFeeCNY}" type = "number"/> ¥ )</div>
                                </div>
                                <div style="display:flex;flex-direction:row;margin:5px">
                                    <div style="width:30%">Tiền hàng (có ship nđ) :</div>
                                    <div><fmt:formatNumber maxFractionDigits="2" value = "${sbol.totalVN}" type = "number"/> đ ( <fmt:formatNumber maxFractionDigits="2" value = "${sbol.totalCN}" type = "number"/> ¥ )</div>
                                </div>
                            </div>

                        </article>
                        <c:set var="totalItemCN" value="0"></c:set>
                        <c:set var="totalItemVN" value="0"></c:set>
                    </c:forEach>
                </div>
            </div>

        </main>

        <jsp:include page="/WEB-INF/views/commonUsers/footer.jsp"></jsp:include>
    </div>


    <!-- Chart library -->
    <script src="/plugins/chart.min.js"></script>
    <!-- Icons library -->
    <script src="/plugins/feather.min.js"></script>
    <!-- Custom scripts -->
    <script src="/js/script.js"></script>

</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const token = localStorage.getItem('token');
        if (!token) {
            window.location.href = '/doLogin';
        } else {
            fetch('http://localhost:8080/api/me', {
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
                        localStorage.setItem('userId', data.userId);
                        userItem = data.userId;
                    }
                }
                // Lấy thông báo từ DB
                getNotifications(userItem, 0, 5);
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
            stompClient.subscribe('/user/specific/notifications/' + userItem, function (messageOutput) {
                showNotification(JSON.parse(messageOutput.body));
            });
        });
    };

    var listNotification = [];
    //Lấy thông báo người dùng
    async function getNotifications(recipient, page, size) {
        console.log("recipient: " + recipient + " page: " + page + " size: " + size);
        try {
            const url = "http://localhost:8080/notifications?recipient=" + recipient + "&page=" + page + "&size=" + size;
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
        notificationList.innerHTML = '';
        notifications.forEach(notification => {
            const notificationItem = document.createElement('li');
            notificationItem.innerText = notification.message;
            notificationList.appendChild(notificationItem);
        });
        document.getElementById('notificationCount').innerText = notifications.length;
    }

    function showNotification(notification) {
        if (notification.isSpecial) {
            document.getElementById('specialNotificationText').innerText = notification.message;
            document.getElementById('specialNotificationPopup').style.display = 'block';
        } else {
            const notificationList = document.getElementById('notificationList');
            const notificationItem = document.createElement('li');
            notificationItem.innerText = notification.message;
            notificationList.appendChild(notificationItem);

            let count = parseInt(document.getElementById('notificationCount').innerText);
            document.getElementById('notificationCount').innerText = count + 1;
        }
    }

    // document.getElementById('notificationIcon').addEventListener('mouseover', function() {
    //     document.getElementById('notificationPopup').style.display = 'block';
    // });

    // document.getElementById('notificationIcon').addEventListener('mouseout', function() {
    //     document.getElementById('notificationPopup').style.display = 'none';
    // });

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
</script>
</html>