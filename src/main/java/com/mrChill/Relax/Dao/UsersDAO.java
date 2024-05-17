package com.mrChill.Relax.Dao;


import javax.persistence.Basic;
import javax.persistence.Column;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import com.mrChill.Relax.Dao.validation.gmail.GmailIF;
import com.mrChill.Relax.Dao.validation.password.PasswordAnotation;
import org.springframework.beans.BeanUtils;

import com.mrChill.Relax.entities.Users;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@PasswordAnotation(message = "Mật khẩu không trùng khớp")
public class UsersDAO {
	public Integer userId;
	public Integer rate ;

	public Integer rateKg ;
	public Integer rateM3 ;

	@NotBlank(message = "Họ tên bắt buộc phải nhập")
	public String userName;
	@NotBlank(message = "Địa chỉ bắt buộc phải ")
	public String address;
	@NotBlank(message = "Số đt bắt buộc phải ")
	public String phone;
	public String role;
	 @NotBlank(message = "Vui lòng nhập đúng dạng")
	 @GmailIF
	 @Email
	public String email;

	 @NotBlank(message = "Mật khẩu bắt buộc phải nhập")
	public String password;
	
	 @NotBlank(message = "Mật khẩu bắt buộc phải nhập lại")
     String rePassword;
	Integer STATUS;
	public Users convertToEntity(){
		 Users usersEntity = new Users();
	        BeanUtils.copyProperties(this,usersEntity);
	        return usersEntity;
	    }
	
}