package com.mrChill.Relax.serviceBase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.entity.Notification;
import com.mrChill.Relax.repoBase.NotificationRepository;
import com.mrChill.Relax.security.UserPrincipal;

import java.util.Date;
import java.util.Map;

@Service
public class NotificationService {

    // Tự động liên kết với NotificationRepository
    @Autowired
    private NotificationRepository notificationRepository;
    /**
     * Phương thức lưu thông báo vào cơ sở dữ liệu
     * @param notification Đối tượng Notification cần lưu
     */
    public void saveNotification(Notification notification, String type) {
        // Lấy thông tin người dùng hiện tại
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUser = "";
        Long currentUserId = 0L;
        if (authentication != null) {
            Object principal = authentication.getPrincipal();
            
            if (principal instanceof UserPrincipal) {
                // lấy thông tin tài khoản theo UserId 
                UserPrincipal userPrincipal = (UserPrincipal) principal;
                currentUserId = userPrincipal.getUserId();
                currentUser = userPrincipal.getUsername();
            }else if (principal instanceof OAuth2User) {
                OAuth2User oauth2User = (OAuth2User) principal;
                Map<String, Object> attributes = oauth2User.getAttributes();
                currentUser = ((String) attributes.getOrDefault("name", null));
                currentUserId = Long.parseLong((String) attributes.getOrDefault("sub", null));
            }
        }

        notification.setType(type); // Thiết lập loại thông báo là cá nhân
        notification.setStatus("unread"); // Thiết lập trạng thái thông báo là chưa đọc
        notification.setCreatedAt(new Date());
        notification.setFromName(currentUser);
        notification.setCreatedBy(currentUserId);
        notificationRepository.save(notification);
    }

    /**
     * Phương thức lấy danh sách thông báo của người dùng bao gồm cả thông báo chung và thông báo riêng với phân trang
     * @param recipient Tên người nhận thông báo
     * @param pageable Thông tin phân trang
     * @return Trang của các thông báo
     */
    public Page<Notification> getNotifications(String recipient, Pageable pageable) {
        return notificationRepository.findAllByRecipientOrGeneral(recipient, pageable);
    }

    /**
     * Phương thức lấy danh sách thông báo chưa đọc của người dùng bao gồm cả thông báo chung và thông báo riêng với phân trang
     * @param recipient Tên người nhận thông báo
     * @param pageable Thông tin phân trang
     * @return Trang của các thông báo chưa đọc
     */
    public Page<Notification> getUnreadNotifications(String recipient, Pageable pageable) {
        return notificationRepository.findAllByRecipientOrGeneralAndStatus(recipient, "unread", pageable);
    }

    /**
     * Phương thức lấy danh sách thông báo của người dùng trong khoảng thời gian xác định bao gồm cả thông báo chung và thông báo riêng với phân trang
     * @param recipient Tên người nhận thông báo
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @param pageable Thông tin phân trang
     * @return Trang của các thông báo trong khoảng thời gian xác định
     */
    public Page<Notification> getNotificationsByDateRange(String recipient, Date startDate, Date endDate, Pageable pageable) {
        return notificationRepository.findAllByRecipientOrGeneralAndDateRange(recipient, startDate, endDate, pageable);
    }

    /**
     * Phương thức gửi thông báo cá nhân đến người dùng cụ thể
     * @param notification Đối tượng thông báo cần gửi
     * @param userId ID của người nhận thông báo
     */
    public void sendPersonalNotification(Notification notification) {
        saveNotification(notification, "personal");
    }
}
