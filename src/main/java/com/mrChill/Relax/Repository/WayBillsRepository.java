package com.mrChill.Relax.Repository;

import com.mrChill.Relax.entities.Orders;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mrChill.Relax.entities.WayBills;

import java.util.Date;
import java.util.List;

@Repository
public interface WayBillsRepository extends JpaRepository <WayBills,Integer> {

    List<WayBills> findByWayBillCodeIsContainingIgnoreCase(String characters);

    List<WayBills> findByWbUserNameIsContainingAndTypeIsContaining(String userName,String type);
    List<WayBills> findByTypeIsContaining(String type);
    List<WayBills> findByOrderId(Integer orderId);
    WayBills findByWayBillId(Integer wayBillId);
    @Query(value = "SELECT sum(w.freight) FROM WayBills w WHERE w.arriveredDate BETWEEN ?1 AND ?2")
    Double sumTotalFreight(Date startDate, Date endDate);

    @Query(value = "SELECT wb FROM WayBills wb WHERE wb.arriveredDate between ?1 AND ?2")
    Page<WayBills> showWayBillPage(PageRequest of, Date startDate, Date endDate);

    @Query(value = "SELECT sum(w.freight) FROM WayBills w WHERE w.wbUserName=?1 AND w.arriveredDate BETWEEN ?2 AND ?3")
    Double sumTotalFreightUser(String UserNAme,Date startDate, Date endDate);

    @Query(value = "SELECT wb FROM WayBills wb WHERE wb.wbUserName=?1 AND wb.arriveredDate between ?2 AND ?3")
    Page<WayBills> showWayBillPageUser(String UserNAme,PageRequest of, Date startDate, Date endDate);


}
