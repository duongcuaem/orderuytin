package com.mrChill.Relax.Controller.Manager;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;



import com.mrChill.Relax.entity.Notification;
import com.mrChill.Relax.entity.NotificationRequestDTO;
import com.mrChill.Relax.serviceBase.NotificationService;

@RestController
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // Lấy danh sách thông báo của một người nhận cụ thể với phân trang
    @GetMapping("/notifications")
    public Page<Notification> getNotifications(
            @RequestParam String recipient,
            @RequestParam int page,
            @RequestParam int size) {
        Pageable pageable = PageRequest.of(page, size);
        return notificationService.getNotifications(recipient, pageable);
    }

    // Lấy danh sách thông báo chưa đọc của một người nhận cụ thể với phân trang
    @GetMapping("/notifications/unread")
    public Page<Notification> getUnreadNotifications(
            @RequestParam String recipient,
            @RequestParam int page,
            @RequestParam int size) {
        Pageable pageable = PageRequest.of(page, size);
        return notificationService.getUnreadNotifications(recipient, pageable);
    }

    // Lấy danh sách thông báo của một người nhận cụ thể trong khoảng thời gian nhất định với phân trang
    @GetMapping("/notifications/by-date")
    public Page<Notification> getNotificationsByDateRange(
            @RequestParam String recipient,
            @RequestParam Date startDate,
            @RequestParam Date endDate,
            @RequestParam int page,
            @RequestParam int size) {
        Pageable pageable = PageRequest.of(page, size);
        return notificationService.getNotificationsByDateRange(recipient, startDate, endDate, pageable);
    }

    // Thông báo cho tất cả mọi người
    @PostMapping("/notifyAll")
    public void notifyAllUsers(@RequestBody Notification notification) {
        notification.setType("general"); // Thiết lập loại thông báo là chung
        notification.setStatus("unread"); // Thiết lập trạng thái thông báo là chưa đọc
        notification.setCreatedAt(new Date());
        notification.setFromName("Admin: ");
        // Lưu thông báo vào cơ sở dữ liệu
        notificationService.saveNotification(notification);
        // Gửi thông báo đến tất cả người dùng
        messagingTemplate.convertAndSend("/all/notifications", notification);
    }

    // Thông báo cho người dùng cụ thể
    @PostMapping("/notify")
    public void notifyUsers(@RequestBody Notification notification, @RequestParam List<String> users) {
        // Lưu thông báo vào cơ sở dữ liệu
        notificationService.saveNotification(notification);
        // Gửi thông báo đến từng người dùng
        for (String user : users) {
            messagingTemplate.convertAndSendToUser(user, "/queue/notifications", notification);
        }
    }

    /**
     * Endpoint để gửi thông báo cá nhân
     * @param notification Đối tượng thông báo cần gửi
     * @param userId ID của người nhận thông báo
     * @return 
     */
    @PostMapping("backend/sendPersonalNotification")
    public ResponseEntity<String> sendPersonalNotification(@RequestBody NotificationRequestDTO notificationRequestDTO) {
        if (notificationRequestDTO == null || 
            notificationRequestDTO.getMessage() == null || notificationRequestDTO.getMessage().isEmpty() || 
            notificationRequestDTO.getRecipients() == null || notificationRequestDTO.getRecipients().isEmpty()) {
            return ResponseEntity.badRequest().body("Invalid notification data.");
        }
        for (String recipient : notificationRequestDTO.getRecipients()) {
            try {
                // Validate recipient (implement your own validation logic here)
                if (recipient == null || recipient.isEmpty()) {
                    continue;
                }
                Notification notification = new Notification();
                notification.setMessage(notificationRequestDTO.getMessage());
                notification.setRecipient(recipient);
                notification.setFromName(notificationRequestDTO.getFromName());
                notification.setType(notificationRequestDTO.getType());
                notification.setStatus(notificationRequestDTO.getStatus());
                notificationService.saveNotification(notification);
                // Gửi thông báo đến người dùng qua WebSocket
                messagingTemplate.convertAndSendToUser(notification.getRecipient().toString(), "/specific/notifications", notification);
            } catch (Exception e) {
                // Log the error
                System.err.println("Error sending notification to recipient: " + recipient);
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error sending notification.");

            }
        }
        return ResponseEntity.ok("Notifications sent successfully.");
    }
}
