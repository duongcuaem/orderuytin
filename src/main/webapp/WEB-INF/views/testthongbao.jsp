<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Notification Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div id="main-content" class="card">
    <h3 class="card-title">Send Notifications</h3>
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="messageToAll">Message to All:</label>
                    <input type="text" id="messageToAll" class="form-control ml-2" placeholder="Your message here...">
                </div>
                <button id="sendToAll" onclick="sendNotificationToAll()" class="btn btn-primary ml-2" type="button">Send to All</button>
            </form>
        </div>
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="messageToUser">Message to User:</label>
                    <input type="text" id="messageToUser" class="form-control ml-2" placeholder="Your message here...">
                </div>
                <div class="form-group ml-2">
                    <label for="users">Select User:</label>
                    <select id="users" class="form-control ml-2">
                        <option value="duong2306">duong</option>
                        <option value="DuongDx123">DuongDx</option>
                        <option value="108077826711910032318">dương đào</option>
                        <option value="6389162541208170">dương đào f</option>
                    </select>
                </div>
                <button id="sendToUser" onclick="sendNotificationToUser()" class="btn btn-primary ml-2" type="button">Send to User</button>
            </form>
        </div>
    </div>
</div>

<script>
    // Send notification to all
    function sendNotificationToAll() {
        const messageContent = $('#messageToAll').val();
        const notification = {
            message: messageContent,
            category: "general",
            type: "general",
            status: "unread"
        };
        fetch('/notifyAll', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(notification),
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
            type: "1",
            status: "unread"
        };
        fetch('/sendPersonalNotification', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(notification),
            mode: 'cors'
        }).then(response => {
            if (response.ok) {
                console.log("Notification sent to user " + selectedUser);
            } else {
                console.error("Failed to send notification");
            }
        });
    }
    //jQuery event handlers
        // $(function () {
        //     $("#sendToAll").click(() => sendNotificationToAll());
        //     $("#sendToUser").click(() => sendNotificationToUser());
        // });
</script>
</body>
</html>
