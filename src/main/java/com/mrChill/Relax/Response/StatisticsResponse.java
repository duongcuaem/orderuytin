package com.mrChill.Relax.Response;

import com.mrChill.Relax.Repository.OrdersRepository;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

@Getter
@Setter
public class StatisticsResponse {

    public Integer countWholeOrder;
    public Integer countPendingItem;
    public Integer countCartItem;
    public Integer countCancelItem;
    public Integer countCancelOrder;
    public Integer countBoughtOrder;
    public Integer countDeliveredOrder;
    public Integer countArriveredOrder;
    public Integer countComplainOrder;
    public Integer countFinishedOrder;

    public Double sumTotalVNUser ;
    public Double sumAmountUser;
    public Double sumReFundVNUser;
    public Double sumTotalCancelVNUser;
    public Double sumTotalFreightUser;

}
