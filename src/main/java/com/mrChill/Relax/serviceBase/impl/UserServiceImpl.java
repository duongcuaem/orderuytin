package com.mrChill.Relax.serviceBase.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.entity.User;
import com.mrChill.Relax.repoBase.UserRepository;
import com.mrChill.Relax.security.UserPrincipal;
import com.mrChill.Relax.serviceBase.UserBaseService;

import java.util.HashSet;
import java.util.Set;

@Service
public class UserServiceImpl implements UserBaseService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User createUser(User user) {
        return userRepository.saveAndFlush(user);
    }

    @Override
    public UserPrincipal findByUsername(String username) {
        User user = userRepository.findByUsername(username);
        UserPrincipal userPrincipal = null;

        if (null != user) {
            Set<SimpleGrantedAuthority> authorities = new HashSet<>();
            if (null != user.getRoles()) {
                user.getRoles().forEach(r -> {
                    authorities.add(new SimpleGrantedAuthority(r.getRoleKey()));
                    r.getPermissions().forEach(p -> authorities.add(new SimpleGrantedAuthority(p.getPermissionKey())));
                });
            }

            userPrincipal = new UserPrincipal(user.getId(), user.getUsername(), user.getPassword(), authorities);
        }
        return userPrincipal;
    }

    // Check UserName is existed
    @Override
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

}
