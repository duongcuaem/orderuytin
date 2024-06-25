<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body style="background-color: black">
<!-- ! Body -->
<div class="page-flex">
    <!-- ! Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <jsp:include page="/WEB-INF/views/common/mainnavSearchClient.jsp"></jsp:include>

        <p style="color: red">${message}</p>
        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target" style="color:yellow">
            <div class="container">
                <div style="font-size:40px;text-align:center;margin:10px;color:yellow"><p>Danh sách khách hàng</p></div>
                <button class="btn btn-success mb-3" onclick="showNotificationModal()">Gửi thông báo</button>
                <table class="table table-bordered" style="color:yellow;background-color:black;">
                    <thead>
                        <tr>
                            <th style="text-align:center;color:#00ff15"><input type="checkbox" id="checkAll" onclick="toggleAllCheckboxes(this)"> Chọn tất cả</th>
                            <th style="text-align:center;color:#00ff15">Tên khách hàng</th>
                            <th style="text-align:center;color:#00ff15">Email</th>
                            <th style="text-align:center;color:#00ff15">Số điện thoại</th>
                            <th style="text-align:center;color:#00ff15">Địa chỉ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allUsers}" var="user">
                            <tr>
                                <td style="text-align:center;">
                                    <c:if test="${empty user.socialcode}">
                                        <input type="checkbox" class="userCheckbox" value="${user.userName}" onchange="updateRecipientList()">
                                    </c:if>
                                    <c:if test="${not empty user.socialcode}">
                                        <input type="checkbox" class="userCheckbox" value="${user.socialcode}" onchange="updateRecipientList()">
                                    </c:if>
                                </td>
                                <td>${user.userName}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.address}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>

    <!-- Notification Modal -->
    <div class="modal" id="notificationModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Gửi thông báo</h5>
                    <button type="button" class="close" onclick="closeNotificationModal()" aria-label="Đóng">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="notificationForm">
                        <input type="hidden" id="notificationRecipient" name="recipient">
                        <div class="form-group">
                            <label for="notificationContent">Nội dung</label>
                            <textarea class="form-control" id="notificationContent" name="content" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="notificationType">Loại</label>
                            <select class="form-control" id="notificationType" name="type" required>
                                <option value="0">Thông thường</option>
                                <option value="1">Đặc biệt</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="notificationRecipientList">Người nhận</label>
                            <textarea class="form-control" id="notificationRecipientList" name="recipientList" readonly></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Gửi thông báo</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showNotificationModal() {
            document.getElementById('notificationModal').style.display = 'block';
            updateRecipientList();
        }

        function closeNotificationModal() {
            document.getElementById('notificationModal').style.display = 'none';
        }

        function toggleAllCheckboxes(source) {
            const checkboxes = document.querySelectorAll('.userCheckbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = source.checked;
            });
            updateRecipientList();
        }

        function updateRecipientList() {
            const checkboxes = document.querySelectorAll('.userCheckbox:checked');
            const recipientList = Array.from(checkboxes).map(cb => cb.value).join(', ');
            document.getElementById('notificationRecipientList').value = recipientList;
        }

        document.getElementById('notificationForm').addEventListener('submit', async function(event) {
            event.preventDefault();

            const recipientList = document.getElementById('notificationRecipientList').value.split(',').map(recipient => recipient.trim());
            const content = document.getElementById('notificationContent').value;
            const type = document.getElementById('notificationType').value;

            const notification = {
                recipients: recipientList,
                message: content,
                type: type,
                status: 'unread'
            };

            try {
                const response = await fetch('http://localhost:8080/backend/sendPersonalNotification', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(notification)
                });
                console.log('Response status:', response.status);
                console.log('Response:', response);
                if (!response.ok) {
                    throw new Error(`HTTP error! status:`);
                }
                alert('Thông báo đã được gửi thành công!');
                resetNotificationForm();
                closeNotificationModal();
            } catch (error) {
                console.error('Có lỗi xảy ra khi gửi thông báo:', error);
                alert('Có lỗi xảy ra khi gửi thông báo. Vui lòng thử lại sau.');
            }
        });

        function resetNotificationForm() {
            document.getElementById('notificationForm').reset();
            document.getElementById('notificationRecipientList').value = '';
        }
    </script>

</body>
</html>
