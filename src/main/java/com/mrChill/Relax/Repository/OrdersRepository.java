package com.mrChill.Relax.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mrChill.Relax.entities.Orders;

import java.util.Date;
import java.util.List;

@Repository
public interface OrdersRepository extends JpaRepository <Orders,Integer> {
    @Query(value = "SELECT o FROM Orders o WHERE o.orderStatus=?1 ORDER BY o.receivedDate DESC ")
    Page<Orders> findOrdersByOrderStatusContaining(String orderStatus, PageRequest of);

    @Query(value = "SELECT o FROM Orders o WHERE o.orderStatus=?1 ORDER BY o.receivedDate DESC ")
    List<Orders> findOrdersByOrderStatusContaining(String string);

    @Query(value = "SELECT o FROM Orders o WHERE o.orderStatus=?1 AND o.orderUserName=?2 ORDER BY o.receivedDate DESC ")
    List<Orders> findByOrderStatusContainingAndOrderUserNameContaining(String status, String  userName);
    List<Orders> findOrdersByOrderNoIsContaining(String string);

    List<Orders> findByOrderUserNameAndOrderStatusAndCancelDateIsBetween(String userName,String status,Date startDate, Date endDate);

    Orders findOrdersByOrderId (Integer integer);

    @Query(value = "SELECT o FROM Orders o WHERE  o.orderUserName=?1 ORDER BY o.receivedDate DESC ")
    List<Orders> findByOrderUserNameContainsIgnoreCase(String userName);
    Orders findByOrderNo(String orderNo);
    Orders findByOrderId(Integer orderId);

    @Query(value = "SELECT o FROM Orders o WHERE o.receivedDate between ?1 AND ?2")
    Page<Orders> showOrdersDetail(PageRequest of,Date startDate, Date endDate);

    @Query(value = "SELECT o FROM Orders o WHERE o.orderUserName=?1 AND o.receivedDate between ?2 AND ?3")
    Page<Orders> showOrdersDetailUser(String userName,PageRequest of,Date startDate, Date endDate);


    @Query(value = "SELECT o FROM Orders o WHERE  o.orderUserName=?1  ORDER BY o.receivedDate DESC ")
    Page<Orders> findOrdersByOrderUserName(String UserName,PageRequest of);

    @Query(value = "SELECT o FROM Orders o WHERE  o.orderUserName=?1  ORDER BY o.receivedDate DESC ")
    List<Orders> findByOrderUserName(String userName);

//    List<Orders> findByOrderUserName(String userName);

    @Query(value = "SELECT o FROM Orders o WHERE  o.orderUserName=?1 AND o.orderStatus=?2 ORDER BY o.receivedDate DESC ")
    Page<Orders> findOrdersByOrderUserNameAndOrderStatus(String userName, String status,PageRequest of);


     //Đếm số đơn của ADmin
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Cho xu ly' ")
    Integer countPendingOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Da mua hang' ")
    Integer countBoughtOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Da phat hang' ")
    Integer countDeliveredOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Da ve kho' ")
    Integer countArriveredOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Khieu nai' ")
    Integer countComplainOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Thanh cong' ")
    Integer countFinishedOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Huy' ")
    Integer countCancelOrderAdmin();
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderStatus='Sua don'")
    Integer countFixOrder();

    //Thống kê công nợ orders trong tk admin
    @Query(value = "SELECT sum(o.totalVN) FROM Orders o WHERE o.receivedDate between ?1 AND ?2")
    Double sumTotalVN(Date startDate, Date endDate);
    @Query(value = "SELECT sum(o.totalVN) FROM Orders o WHERE o.orderStatus='Huy' AND o.receivedDate between ?1 AND ?2")
    Double sumTotalCancelVN(Date startDate, Date endDate);

    //Đếm số đơn của Client
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1  ")
    Integer countWholeOrder(String userName);
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Huy' ")
    Integer countCancelOrder(String userName);
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Da mua hang' ")
    Integer countBoughtOrder(String userName);
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Da phat hang' ")
    Integer countDeliveredOrder(String userName);
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Da ve kho' ")
    Integer countArriveredOrder(String userName);
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Khieu nai' ")
    Integer countComplainOrder(String userName);
    @Query(value = "SELECT count(o) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Thanh cong' ")
    Integer countFinishedOrder(String userName);


    //Thống kê công nợ orders trong tk khách hàng
    @Query(value = "SELECT sum(o.totalVN) FROM Orders o WHERE o.orderUserName=?1 AND o.receivedDate between ?2 AND ?3")
    Double sumTotalVNUser(String userName,Date startDate, Date endDate);
    @Query(value = "SELECT sum(o.totalVN) FROM Orders o WHERE o.orderUserName=?1 AND o.orderStatus='Huy' AND o.receivedDate between ?2 AND ?3")
    Double sumTotalCancelVNUser(String userName,Date startDate, Date endDate);



}
