package com.mrChill.Relax.serviceBase;

import com.mrChill.Relax.entities.Users;
import com.mrChill.Relax.security.UserPrincipal;

public interface UserService {
    Users createUser(Users user);

    UserPrincipal findByUserName(String username);

    UserPrincipal findByPhone(String phone);

    UserPrincipal findByEmail(String email);
}
