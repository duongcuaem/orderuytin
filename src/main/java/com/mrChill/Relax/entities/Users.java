package com.mrChill.Relax.entities;
import java.util.*;
import javax.persistence.*;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "users")
public class Users extends EntityBase {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	@Column(name = "userId")
	public Integer userId;

	@Basic
	@Column(name = "userName")
	public String userName;

	@Basic
	@Column(name = "social_code",  unique = true)
    private String socialcode;

	@Basic
	@Column(name = "rate")
	public Integer rate ;

	@Basic
	@Column(name = "rateKg")
	public Integer rateKg ;

	@Basic
	@Column(name = "rateM3")
	public Integer rateM3 ;

	@Basic
	@Column(name = "address")
	public String address;

	@Basic
	@Column(name = "phone")
	public String phone;

	@Basic
	@Column(name = "role")
	public String role;

	@Basic
	@Column(name = "email")
	public String email;

	@Basic
	@Column(name = "password")
	public String password;
	
    @Basic
    @Column(name = "rePassword")
	public String rePassword;

	@Basic
	@Column(name = "STATUS")
	public Integer STATUS;

	@OneToMany(mappedBy = "userId")
	public List<ChargMoney> chargMoneyList;

}
