package com.mrChill.Relax.Response;

import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.WayBills;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class ItemResponse {
    public Integer itemId;
    public Integer quantity;
    public Integer orderId;
    public Integer CNYrateVND;
    public Integer quantityRefund;
    public Double price;
    public String itemStatus;
    public String link;
    public String image;
    public String userNote;
    public String adminNote;
    public String describle;
    public String itemUserName;
    public Date refundDate;
}
