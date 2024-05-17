package com.mrChill.Relax.Service;

import com.mrChill.Relax.Dao.OrdersDAO;
import com.mrChill.Relax.Dao.WayBillsDAO;
import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.Repository.WayBillsRepository;
import com.mrChill.Relax.entities.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.entities.WayBills;

import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;


@Service
public class WayBillsService {

	@Autowired
    WayBillsRepository wbr;

    @Autowired
    OrdersRepository or;

    @Autowired
    UsersService us;

	public void saveWayBill (OrdersDAO ordersDAO,WayBillsDAO wayBillsDAO){
          Orders ordersEntity = ordersDAO.convertToEntity();
      WayBills wayBillsEntity = wayBillsDAO.convertToEntity();
       or.save(ordersEntity);
        Orders o = or.findById(wayBillsEntity.getOrderId()).orElse(null);
        wayBillsEntity.setOrders(o);
      wbr.save(wayBillsEntity);
    }

    public void create (WayBillsDAO wayBillsDAO){
        WayBills wayBillsEntity = wayBillsDAO.convertToEntity();
        wbr.save(wayBillsEntity);
    }

    public void remove (Integer wayBillId){
       WayBills wb = wbr.findByWayBillId(wayBillId);
        wbr.delete(wb);
    }
    public void confirm (Integer wayBillId){
        WayBills wb = wbr.findByWayBillId(wayBillId);
        wb.setType("KGHT");
        wbr.save(wb);
    }

    public void save (WayBillsDAO wayBillsDAO){
        WayBills wayBillsEntity = wayBillsDAO.convertToEntity();
        Orders order = or.findById(wayBillsEntity.getOrderId()).orElse(null);
        order.setOrderStatus("Da ve kho");
        or.save(order);
        wayBillsEntity.setOrders(order);
        wbr.save(wayBillsEntity);
    }

    public Double sumTotalFreight (Date startDate, Date endDate){
        return wbr.sumTotalFreight(startDate,endDate); }

    public List<WayBills> showWayBillList (String searchKey){
        return wbr.findByWayBillCodeIsContainingIgnoreCase(searchKey);
    }

    public void remove ( WayBills waybill){ wbr.delete(waybill);}
    public Page<WayBills> showWayBillPage (Integer page , Integer perpage ,Date startDate, Date endDate){
        return wbr.showWayBillPage(PageRequest.of(page - 1, perpage), startDate,  endDate);
    }

    public Double sumTotalFreightUser (String userName,Date startDate, Date endDate){
        return wbr.sumTotalFreightUser(userName,startDate,endDate); }

    public Page<WayBills> showWayBillPageUser (String userName,Integer page , Integer perpage ,Date startDate, Date endDate){
        return wbr.showWayBillPageUser(userName,PageRequest.of(page - 1, perpage), startDate,  endDate);
    }
    public List<WayBills> showWayBillsByOrderId (Integer orderId){
        return wbr.findByOrderId(orderId);
    }
    public List<WayBills> showKGwaybillsList (){
        return wbr.findByWbUserNameIsContainingAndTypeIsContaining(us.currentLoginUser().getUserName(),"KGVK");
    }

    public List<WayBills> showKGHTwaybillsList (){
        return wbr.findByWbUserNameIsContainingAndTypeIsContaining(us.currentLoginUser().getUserName(),"KGHT");
    }

    public List<WayBills> showKGwaybillsListofAdMin (){
        return wbr.findByTypeIsContaining("KGVK");
    }

    public List<WayBills> showKGHTwaybillsListofAdMin (){
        return wbr.findByTypeIsContaining("KGHT");
    }

    public TimerTask changeStatus() {
        List<WayBills> wbist =  wbr.findByTypeIsContaining("KGVK");
        for(WayBills wayBills :wbist){
            wayBills.setType("KGHT");
            wbr.save(wayBills);
        }
        return null;
    }
    public void scheduleDHOrder() {
        Timer timer = new Timer();
        timer.schedule(changeStatus(), 604800000);
    }
}
