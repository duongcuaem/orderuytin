package com.mrChill.Relax.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "orders")
public class Orders implements Serializable {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	@Column(name = "orderId")
	public Integer orderId;

	@Basic
	@Column(name = "totalCN")
	public Double totalCN;

	@Basic
	@Column(name = "shipFeeVND")
	public Double shipFeeVND;

	@Basic
	@Column(name = "shipFeeCNY")
	public Double shipFeeCNY;
	
	@Basic
	@Column(name = "totalVN")
	public Double totalVN;
	
	@Basic
	@Column(name = "orderUserName")
	public String orderUserName;
	
	@Basic
	@Column(name = "orderStatus")
	public String orderStatus;
	
	@Basic
	@Column(name = "orderNo")
	public String orderNo;
	
	@Basic
	@Column(name = "receivedDate")
	public Date receivedDate;

	@Basic
	@Column(name = "cancelDate")
	public Date cancelDate;

	@OneToMany(mappedBy = "orderId")
	public List<Item> items;

	@OneToMany(mappedBy = "orderId")
	public List<WayBills> waybills;

}
