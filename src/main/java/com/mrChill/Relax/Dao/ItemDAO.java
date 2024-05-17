package com.mrChill.Relax.Dao;


import org.springframework.beans.BeanUtils;

import com.mrChill.Relax.entities.Item;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemDAO {
	  public Integer itemId;

	  @NotNull(message = "Số lượng bắt buộc phải nhập")
	  public Integer quantity;
	  public Integer orderId;
	  public Integer CNYrateVND ;
	  public Integer quantityRefund;

	  @NotBlank(message = "Link sản phẩm bắt buộc phải nhập")
	  public String link;
	  public String itemUserName;
	  public String describle;
	  public String userNote;
	  public String image;
	  public String adminNote;
	  public String itemStatus;

	  @NotNull(message = "Giá sản phẩm bắt buộc phải nhập")
	  public Double price;


	@DateTimeFormat(pattern = "yyyy-MM-dd")
	 public Date refundDate;

	 public Item convertToEntity(){
		 Item ItemEntity = new Item();
	        BeanUtils.copyProperties(this,ItemEntity);
	        return ItemEntity;
	    }
}
