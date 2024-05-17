package com.mrChill.Relax.Repository;

import com.mrChill.Relax.entities.ChargMoney;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;

public interface ChargMoneyRepository extends JpaRepository<ChargMoney,Integer> {
    @Query(value = "SELECT sum(cm.amount) FROM ChargMoney cm WHERE cm.chargDate between ?1 AND ?2")
    Double sumAmount(Date startDate, Date endDate);

    @Query(value = "SELECT cm FROM ChargMoney cm WHERE cm.chargDate between ?1 AND ?2")
    Page<ChargMoney> findChargMoneyByChargDateIsBetween(PageRequest of,Date startDate, Date endDate);

    @Query(value = "SELECT sum(cm.amount) FROM ChargMoney cm WHERE cm.userId=?1 AND cm.chargDate between ?2 AND ?3")
    Double sumAmountUser(Integer a,Date startDate, Date endDate);

    @Query(value = "SELECT cm FROM ChargMoney cm WHERE cm.userId=?1 AND cm.chargDate between ?2 AND ?3")
    Page<ChargMoney> findChargMoneyByChargDateIsBetweenUser (Integer a,PageRequest of,Date startDate, Date endDate);

}
