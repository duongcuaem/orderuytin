package com.mrChill.Relax.Dao;

import com.mrChill.Relax.entities.ChargMoney;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChargMoneyDAO {
    public Integer chargId;

    public Integer userId;

    public Double amount ;
    public String note;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public Date chargDate;


    public ChargMoney convertToEntity(){
        ChargMoney chargMoneyEntity = new ChargMoney();
        BeanUtils.copyProperties(this,chargMoneyEntity);
        return chargMoneyEntity;
    }
}
