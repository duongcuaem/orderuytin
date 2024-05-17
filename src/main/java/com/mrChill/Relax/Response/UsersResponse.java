package com.mrChill.Relax.Response;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class UsersResponse {
    public Integer userId;
    public Integer rateKg;
    public Integer rateM3;
    public Integer STATUS;
    public Integer rate;
    public String phone;
    public String address;
    public String role;
    public String password;
    public String email;
    public String rePassword;
    public String userName;
}
