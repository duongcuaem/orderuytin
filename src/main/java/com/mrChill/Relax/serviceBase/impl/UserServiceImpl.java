package com.mrChill.Relax.serviceBase.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.entities.Users;
import com.mrChill.Relax.security.UserPrincipal;
import com.mrChill.Relax.serviceBase.UserService;

import java.util.HashSet;
import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UsersRepository userRepository;

    @Override
    public Users createUser(Users user) {
        return userRepository.saveAndFlush(user);
    }

    @Override
    public UserPrincipal findByUserName(String username) {
        Users user = userRepository.findByUserName(username);
        UserPrincipal userPrincipal = null;

        if (null != user) {
            Set<SimpleGrantedAuthority> authorities = new HashSet<>();
            if (null != user.getRole()) {
                authorities.add(new SimpleGrantedAuthority(user.getRole()));
            }

            userPrincipal = new UserPrincipal((long) user.getUserId(), user.getUserName(), user.getPassword(), authorities);
        }
        return userPrincipal;
    }

    @Override
    public UserPrincipal findByPhone(String userPhone) {
        Users user = userRepository.findFirstByPhone(userPhone);
        UserPrincipal userPrincipal = null;

        if (null != user) {
            Set<SimpleGrantedAuthority> authorities = new HashSet<>();
            if (null != user.getRole()) {
                authorities.add(new SimpleGrantedAuthority(user.getRole()));
            }

            userPrincipal = new UserPrincipal((long) user.getUserId(), user.getUserName(), user.getPassword(), authorities);
        }
        return userPrincipal;
    }

    @Override
    public UserPrincipal findByEmail(String userEmail) {
        Users user = userRepository.findByEmail(userEmail);
        UserPrincipal userPrincipal = null;

        if (null != user) {
            Set<SimpleGrantedAuthority> authorities = new HashSet<>();
            if (null != user.getRole()) {
                authorities.add(new SimpleGrantedAuthority(user.getRole()));
            }

            userPrincipal = new UserPrincipal((long) user.getUserId(), user.getUserName(), user.getPassword(), authorities);
        }
        return userPrincipal;
    }
}
