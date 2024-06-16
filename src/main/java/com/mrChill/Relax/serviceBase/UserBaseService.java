package com.mrChill.Relax.serviceBase;

import com.mrChill.Relax.entity.User;
import com.mrChill.Relax.security.UserPrincipal;

public interface UserBaseService {
    User createUser(User user);
    UserPrincipal findByUsername(String username);

    //Check UserName is existed
    boolean existsByUsername(String username);

}
