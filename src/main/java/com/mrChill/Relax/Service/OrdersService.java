package com.mrChill.Relax.Service;

import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Dao.OrdersDAO;
import com.mrChill.Relax.Repository.ItemRepository;
import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.Repository.WayBillsRepository;
import com.mrChill.Relax.entities.MergedList;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.Orders;

import java.util.*;

import javax.transaction.Transactional;

@Service
@Transactional
public class OrdersService {

	@Autowired
    OrdersRepository or;

    @Autowired
    ItemService is;

    @Autowired
    ItemRepository ir;

    @Autowired
    MergedListService ms;

    @Autowired
    WayBillsRepository wbr;

    @Autowired
    UsersService us;


	public void insertSingleOrder (OrdersDAO ordersDAO, ItemDAO itemDAO){
        Orders orderEntity = ordersDAO.convertToEntity();
           orderEntity.setOrderId(null);
        Item itemEntity = itemDAO.convertToEntity();
        or.save(orderEntity);
        itemEntity.setOrderId(orderEntity.orderId);
        ir.save(itemEntity);
    }

    public void insertMultiOrder(OrdersDAO ordersDAO, MergedList m){
    Orders orderEntity = ordersDAO.convertToEntity();
        orderEntity.setOrderId(null);
        or.save(orderEntity);
        List<Item> lstItem = new ArrayList<>();
        for(Item itemEntity : m.items) {
        itemEntity.setItemStatus("Da mua hang");
        itemEntity.setOrderId(orderEntity.orderId);
        lstItem.add(itemEntity);
    }
        ir.saveAll(lstItem);
        ms.reset();
}
    public void saveOrder (OrdersDAO ordersDAO){
        Orders orderEntity = ordersDAO.convertToEntity();
        or.save(orderEntity);
    }
    public void editStatus (Integer orderId){
        Orders orderEntity = or.findByOrderId(orderId);
        orderEntity.setOrderStatus("Thanh cong");
        or.save(orderEntity);
    }

    public Orders showDetailByOrderNo (String orderNo){return or.findByOrderNo(orderNo) ;}

//Đếm số đơn
    public Integer countBoughtOrder (String userName){ return  or.countBoughtOrder(userName);}
    public Integer countBoughtOrderAdmin (){ return  or.countBoughtOrderAdmin();}
    public Integer countDeliveredOrder (String userName){ return  or.countDeliveredOrder(userName);}
    public Integer countDeliveredOrderAdmin (){ return  or.countDeliveredOrderAdmin();}
    public Integer countArriveredOrder (String userName){ return  or.countArriveredOrder(userName);}
    public Integer countArriveredOrderAdmin (){ return  or.countArriveredOrderAdmin();}
    public Integer countComplainOrder (String userName){ return  or.countComplainOrder(userName);}
    public Integer countComplainOrderAdmin (){ return  or.countComplainOrderAdmin();}
    public Integer countFinishedOrder (String userName){ return  or.countFinishedOrder(userName);}
    public Integer countFinishedOrderAdmin (){ return  or.countFinishedOrderAdmin();}
    public Integer countCancelOrder (String userName){ return  or.countCancelOrder(userName);}
    public Integer countCancelOrderAdmin (){ return  or.countCancelOrderAdmin();}
    public Integer countWholeOrder (String userName){ return  or.countWholeOrder(userName);}
    public Integer countFixOrderAdmin (){ return  or.countFixOrder();}

    public Page<Orders> showWholeOrderList (Integer page , Integer perpage ){
        return or.findAll( PageRequest.of(page - 1, perpage));
    }
    public List<Orders> showOrderList ( String searchKey){
        return or.findOrdersByOrderNoIsContaining(searchKey);
    }
    public List<Orders> showOrderListof1Client ( String searchKey){
        return or.findByOrderUserNameContainsIgnoreCase(searchKey);
    }

    public List<Orders> showArriveredOrderList ( String searchKey){
        List<WayBills> wayBillList = wbr.findByWayBillCodeIsContainingIgnoreCase(searchKey);
        List<Orders> orderList = new ArrayList<>();
        for ( WayBills wb : wayBillList ) {
            orderList.add(or.findOrdersByOrderId(wb.orderId));
        }
        return orderList;
    }


    public TimerTask changeStatus() {
        List<Orders> orderList =  or.findOrdersByOrderStatusContaining("Da ve kho");
        for(Orders order :orderList){
            order.setOrderStatus("Thanh cong");
            or.save(order);
        }
        return null;
    }
    public void scheduleDHOrder() {
        Timer timer = new Timer();
        timer.schedule(changeStatus(), 604800000);
    }



    public Double sumTotalVN (Date startDate, Date endDate){
        return or.sumTotalVN(startDate,endDate);
    }
    public Double sumTotalCancelVN (Date startDate, Date endDate){
        return or.sumTotalCancelVN(startDate,endDate);
    }

    public Page<Orders> showOrdersDetail (Integer page , Integer perpage ,Date startDate, Date endDate){
        return or.showOrdersDetail(PageRequest.of(page - 1, perpage),startDate,endDate);
    }

    public Double sumTotalVNUser (String userName,Date startDate, Date endDate){
        return or.sumTotalVNUser(userName,startDate,endDate);
    }
    public Double sumTotalCancelVNUser (String userName,Date startDate, Date endDate){
        return or.sumTotalCancelVNUser(userName,startDate,endDate);
    }

    public Page<Orders> showOrdersDetailUser (String userName,Integer page , Integer perpage ,Date startDate, Date endDate){
        return or.showOrdersDetailUser(userName,PageRequest.of(page - 1, perpage),startDate,endDate);
    }

    public List<Orders> showOrdersCancelDetail (String status){
        return or.findOrdersByOrderStatusContaining(status);
    }
    public List<Orders> showSearchOrdersClient (String describle,String userName){
        List<Item> listItems = ir.findByDescribleContainingAndItemUserNameContaining(describle,userName);
        List<Orders> listOrders = new ArrayList<Orders>();
        List<Integer> listOrderId = new ArrayList<Integer>();
        for (Item item :listItems) {
            listOrderId.add(item.getOrderId());
        }
        for (int i = 0; i < listOrderId.size() ; i++) {
            for (int j = i+1; j < listOrderId.size(); j++) {
                if(listOrderId.get(i) == (listOrderId.get(j))){
                    listOrderId.remove(listOrderId.get(i));
                }
            }
        }
        for (Integer orderId:listOrderId ) {
            listOrders.add(or.findOrdersByOrderId(orderId));
        }
        if(listOrders.size() == 0){
            listOrders.add(or.findByOrderNo(describle));
        }
        return listOrders;
    }
    public void remove ( Orders order){ or.delete(order);}
    public List<Orders> showOrdersCancelDetailUser (String userName,String status,Date startDate, Date endDate){
        return or.findByOrderUserNameAndOrderStatusAndCancelDateIsBetween(userName,status,startDate,endDate);
    }

    //pthuc service cuaAdmin
    public List<Orders> showFixOrder (){
        return or.findOrdersByOrderStatusContaining("Sua don");
    }
    public Page<Orders> showBoughtOrderList (Integer page , Integer perpage ){
        return or.findOrdersByOrderStatusContaining("Da mua hang", PageRequest.of(page - 1, perpage));
    }
    public Page<Orders> showDeliveriedOrderList (Integer page , Integer perpage){
        return or.findOrdersByOrderStatusContaining("Da phat hang", PageRequest.of(page - 1, perpage));
    }
    public Page<Orders> showArriveredOrderList (Integer page , Integer perpage ){
        return or.findOrdersByOrderStatusContaining("Da ve kho", PageRequest.of(page - 1, perpage));
    }
    public Page<Orders> showFinishedOrderList (Integer page , Integer perpage ){
        return or.findOrdersByOrderStatusContaining("Thanh cong", PageRequest.of(page - 1, perpage));
    }
    public List<Orders> showComplainOrderList ( String searchKey){
        return or.findOrdersByOrderStatusContaining(searchKey);
    }

    public List<Orders> showCancelOrderList (){
        return or.findOrdersByOrderStatusContaining("Huy");
    }


    //pthuc service cua khach hang
    public Page<Orders> showBoughtOrderListofClient (Integer page , Integer perpage ){
        return or.findOrdersByOrderUserNameAndOrderStatus(us.currentLoginUser().getUserName(), "Da mua hang",PageRequest.of(page - 1, perpage));
    }
    public Page<Orders> showDeliveriedOrderListofClient (Integer page , Integer perpage ){
        return or.findOrdersByOrderUserNameAndOrderStatus(us.currentLoginUser().getUserName(),"Da phat hang", PageRequest.of(page - 1, perpage));
    }
    public Page<Orders> showArriveredOrderListofClient (Integer page , Integer perpage ){
        return or.findOrdersByOrderUserNameAndOrderStatus(us.currentLoginUser().getUserName(),"Da ve kho", PageRequest.of(page - 1, perpage));
    }
    public Page<Orders> showFinishedOrderListofClient (Integer page , Integer perpage ){
        return or.findOrdersByOrderUserNameAndOrderStatus(us.currentLoginUser().getUserName(),"Thanh cong", PageRequest.of(page - 1, perpage));
    }

    public List<Orders> showCancelOrderListofClient (){
        return or.findByOrderStatusContainingAndOrderUserNameContaining(us.currentLoginUser().getUserName(),"Huy");
    }
    public Page<Orders> showWholeOrderListofClient (Integer page , Integer perpage ){
        return or.findOrdersByOrderUserName(us.currentLoginUser().getUserName(), PageRequest.of(page - 1, perpage));
    }

    public List<Orders> showComplainOrderListfofClient (String userName){
        return or.findByOrderStatusContainingAndOrderUserNameContaining("Khieu nai",userName);
    }

}
