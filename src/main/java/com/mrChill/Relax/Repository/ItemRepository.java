package com.mrChill.Relax.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mrChill.Relax.entities.Item;

import java.util.Date;
import java.util.List;

@Repository
public interface ItemRepository extends JpaRepository <Item,Integer> {

	Page<Item> findItemByItemStatusContaining(String string, PageRequest of);
	List<Item> findItemByItemStatusContaining(String status);
	List<Item> findByItemStatusContainingAndItemUserName(String status,String userName);
	List<Item> findByOrderId(Integer orderId);
	List<Item> findByDescribleContainingAndItemUserNameContaining(String describle,String userName);
	List<Item> findItemByItemUserNameContainingAndItemStatusContaining(String userName,String status);
	Page<Item> findByItemStatusAndItemUserName(String Status, String UserName, PageRequest of);
	Page<Item> findByItemStatus(String Status, PageRequest of);

	Item findByItemId(Integer itemId);

   //Đếm số item trong gio hang
	@Query(value = "SELECT count(i) FROM Item i WHERE i.itemUserName=?1 AND i.itemStatus='Gio hang' ")
	Integer countCartItem(String userName);

	@Query(value = "SELECT count(i) FROM Item i WHERE i.itemStatus='Gio hang' ")
	Integer countCartItemAdmin();

	@Query(value = "SELECT count(i) FROM Item i WHERE i.itemUserName=?1 AND i.itemStatus='Cho xu ly' ")
	Integer countPendingItem(String userName);

	@Query(value = "SELECT count(i) FROM Item i WHERE i.itemStatus='Cho xu ly' ")
	Integer countPendingItemAdmin();

	@Query(value = "SELECT count(i) FROM Item i WHERE i.itemUserName=?1 AND i.itemStatus='Huy' ")
	Integer countCancelItem(String userName);
	@Query(value = "SELECT count(i) FROM Item i WHERE i.itemStatus='Huy' ")
	Integer countCancelItemAdmin();

	@Query(value = "SELECT sum(i.quantityRefund*i.price*i.CNYrateVND) FROM Item i WHERE i.refundDate between ?1 AND ?2")
	Double sumReFundVN(Date startDate, Date endDate);

	@Query(value = "SELECT i FROM Item i WHERE i.quantityRefund>0 AND i.refundDate between ?1 AND ?2")
	List<Item> findItemByRefundVN(Date startDate, Date endDate);

	@Query(value = "SELECT sum(i.quantityRefund*i.price*i.CNYrateVND) FROM Item i WHERE i.itemUserName=?1 AND i.refundDate between ?2 AND ?3")
	Double sumReFundVNUser(String userName,Date startDate, Date endDate);

	@Query(value = "SELECT i FROM Item i WHERE i.quantityRefund>0 AND i.itemUserName=?1 AND i.refundDate between ?2 AND ?3")
	List<Item> findItemByRefundVNUser(String userName, Date startDate, Date endDate);


}
