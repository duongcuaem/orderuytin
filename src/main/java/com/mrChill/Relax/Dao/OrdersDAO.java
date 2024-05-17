package com.mrChill.Relax.Dao;


import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;

import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.Orders;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrdersDAO   {
    public int orderId;
	public Double shipFeeVND;
	public Double shipFeeCNY;
	public Double totalCN;
	public Double totalVN;
	public String orderUserName;
	public String orderStatus;

	@NotBlank(message = "Mã đơn hàng bắt buộc phải nhập")
	public String orderNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public Date receivedDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public Date cancelDate;
	public List<Item> items;
	public List<String> wayBills;

	 public Orders convertToEntity(){
		 Orders ordersEntity = new Orders();
	        BeanUtils.copyProperties(this,ordersEntity);
	        return ordersEntity;
	    }

}
