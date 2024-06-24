package com.mrChill.Relax.entity;

import java.util.List;

import lombok.Getter;

@Getter
public class notificationMs {
    private String message; // Nội dung của thông báo
    private List<String> recipient; // Người nhận thông báo, có thể là tên người dùng hoặc ID
    private String fromName; // tên người gửi
    private String type; // Loại thông báo: 'general' cho thông báo chung, 'personal' cho thông báo cá nhân
    private String status; 
}
