package com.mrChill.Relax.Dao;



import java.util.Date;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.beans.BeanUtils;

import com.mrChill.Relax.entities.WayBills;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WayBillsDAO {
    public Integer wayBillId;
	public Integer orderId;
	public Integer rateCubic = 3200000;
	public Integer rateKg = 30000;

	public Double freight;
	public Double kg;
	public Double cubic;

	@NotBlank(message = "Mã vận đơn bắt buộc phải nhập ")
	public String wayBillCode;
	public String wbUserName;
	public String type;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public Date arriveredDate ;


	 public WayBills convertToEntity(){
		 WayBills wayBillsEntity = new WayBills();
	        BeanUtils.copyProperties(this,wayBillsEntity);
	        return wayBillsEntity;
	    }
	
}
