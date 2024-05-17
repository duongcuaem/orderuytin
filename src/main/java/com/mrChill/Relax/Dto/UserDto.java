package com.mrChill.Relax.Dto;

import com.mrChill.Relax.entities.Users;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.BeanUtils;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    int userId;
    String userName;
    Double totalVN;
    Double totalCancelVN;
    Double totalFreight;
    Double totalReFundVN;
    Double totalAmount;

    public UserDto(int userId, String userName) {
        this.userId = userId;
        this.userName = userName;
    }


}
