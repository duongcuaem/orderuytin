package com.mrChill.Relax.entities;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import java.util.Date;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "item")
public class Item extends EntityBase {
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	@Column(name = "itemId")
	public Integer itemId;

	@Basic
	@Column(name = "quantity")
	public Integer quantity;

//	@Transient
	@Column(name = "orderId")
    public Integer orderId;

	@JsonIgnore
	@Transient
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="orderId",referencedColumnName="orderId",insertable = false, updatable = false)
    public Orders orders;

	@Basic
	@Column(name = "link")
	public String link;


	@Basic
	@Column(name = "CNYrateVND")
	public Integer CNYrateVND;

	@Basic
	@Column(name = "quantityRefund")
	public Integer quantityRefund;

	@Basic
	@Column(name = "adminNote")
	public String adminNote;
	@Basic
	@Column(name = "userNote")
	public String userNote;
	@Basic
	@Column(name = "image")
	public String image;

	@Basic
	@Column(name = "itemUserName")
	public String itemUserName;

	@Basic
	@Column(name = "describle")
	public String describle;

	@Basic
	@Column(name = "itemStatus")
	public String itemStatus;

	@Basic
	@Column(name = "price")
	public Double price;

	@Basic
	@Column(name = "refundDate")
	public Date refundDate;


	public Item(Integer itemId, int quantity, int orderId, String image, String userName, String describle, String status, float price) {
		super();
	}

}
