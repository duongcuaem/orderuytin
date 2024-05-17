package com.mrChill.Relax.entities;

import java.util.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "waybill")
public class WayBills extends EntityBase{
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	@Column(name = "wayBillId")
	public Integer wayBillId;
	
	@Basic
	@Column(name = "freight")
	public Double freight;

	
	@Basic
	@Column(name = "rateCubic")
	public Integer rateCubic = 3200000;
	
	@Basic
	@Column(name = "rateKg")
	public Integer rateKg = 3000;

	@Column(name = "orderId")
	public Integer orderId;

	@JsonIgnore
	@Transient
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="orderId",referencedColumnName="orderId",insertable = false, updatable = false)
	public Orders orders;
	
	@Basic
	@Column(name = "wayBillCode")
	public String wayBillCode;
	
	@Basic
	@Column(name = "wbUserName")
	public String wbUserName;

	@Basic
	@Column(name = "type")
	public String type;
	
	@Basic
	@Column(name = "arriveredDate")
	public Date arriveredDate;
	@Basic
	@Column(name = "kg")
	public Double kg;
	
	@Basic
	@Column(name = "cubic")
	public Double cubic;


}
