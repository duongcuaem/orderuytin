package com.mrChill.Relax.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDto1 {
    Integer userId;
    String userName;

    Double totalReFundVN;
}
