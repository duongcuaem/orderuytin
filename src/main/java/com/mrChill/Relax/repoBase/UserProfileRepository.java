package com.mrChill.Relax.repoBase;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mrChill.Relax.entity.UserProfile;

public interface UserProfileRepository extends JpaRepository<UserProfile, Long> {
    UserProfile findByUserId(Long userId);
    UserProfile findByUsername(String username);
    UserProfile findBySocialcode(String code);
    //exits by email
    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);
}
