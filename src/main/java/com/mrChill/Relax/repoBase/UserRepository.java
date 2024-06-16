package com.mrChill.Relax.repoBase;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mrChill.Relax.entity.User;


public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    // exits by email
    boolean existsByUsername(String username);
}
