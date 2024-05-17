package com.mrChill.Relax.Response;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class ChargMoneyResponse {
    public Integer chargId;
    public Integer userId;
    public Double amount;
    public String note;
    public Date chargDate;
}
