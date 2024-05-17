package com.mrChill.Relax.Response;

import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.WayBills;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class OrdersResponse {
    public Integer orderId;
    public Double totalCN;
    public Double shipFeeVND;
    public Double shipFeeCNY;
    public Double totalVN;
    public String orderUserName;
    public String orderStatus;
    public String orderNo;
    public Date receivedDate;
    public Date cancelDate;
    public List<Item> items;
    public List<WayBills> waybills;
}
