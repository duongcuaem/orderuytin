package com.mrChill.Relax.entity;

public class UserRegistrationDto {
    private User user;
    private UserProfile userProfile;
    private String rePassword;

    // Getters and Setters for user
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    // Getters and Setters for userProfile
    public UserProfile getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(UserProfile userProfile) {
        this.userProfile = userProfile;
    }

    // Getters and Setters for rePassword
    public String getRePassword() {
        return rePassword;
    }

    public void setRePassword(String rePassword) {
        this.rePassword = rePassword;
    }
}
