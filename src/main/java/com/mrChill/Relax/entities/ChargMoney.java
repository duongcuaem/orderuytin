package com.mrChill.Relax.entities;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "chargMoney")
public class ChargMoney extends EntityBase {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "chargId")
    public Integer chargId;

    @Basic
    @Column(name = "userId")
    public Integer userId;

//    @Transient
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="userId", insertable = false, updatable = false)
    public Users users;

    @Basic
    @Column(name = "amount")
    public Double amount ;

    @Basic
    @Column(name = "note")
    public String note;

    @Basic
    @Column(name = "chargDate")
    public Date chargDate;

}
