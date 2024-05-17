package com.mrChill.Relax.Response;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class WayBillsResponse {
    public Integer wayBillId;
    public Integer rateCubic;
    public Integer orderId;
    public Integer rateKg;
    public Double freight;
    public Double cubic;
    public Double kg;
    public String wayBillCode;
    public String wbUserName;
    public String type;
    public Date arriveredDate;
}
