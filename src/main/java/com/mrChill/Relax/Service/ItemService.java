package com.mrChill.Relax.Service;

import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Repository.ItemRepository;
import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.entities.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.entities.Item;

import java.util.Date;
import java.util.List;

@Service
public class ItemService {

	@Autowired
    ItemRepository ir;

    @Autowired
    OrdersRepository or;

    @Autowired
    UsersService us;

    public void saveItem (ItemDAO itemDAO){
        Item itemEntity = itemDAO.convertToEntity();
        ir.save(itemEntity);
    }

	public void save (ItemDAO itemDAO){
       Item itemEntity = itemDAO.convertToEntity();
       //tìm Order bằng id trong OrderRepo, nếu tìm được thì lấy Order, không tìm được thì lấy null
       Orders o = or.findById(itemEntity.getOrderId()).orElse(null);
       itemEntity.setOrders(o);
        ir.save(itemEntity);
    }

    public void remove ( Item item){ ir.delete(item);}
    public void handle (ItemDAO itemDAO){
        Item itemEntity = itemDAO.convertToEntity();
        ir.save(itemEntity);
    }
    public void updateCancel (Integer itemId){
        Item itemEntity = ir.findByItemId(itemId);
        itemEntity.setItemStatus("Huy");
        ir.save(itemEntity);
    }
    public void updateRestore(Integer itemId){
        Item itemEntity= ir.findByItemId(itemId);
        itemEntity.setOrderId(null);
        itemEntity.setItemStatus("Cho xu ly");
        ir.save(itemEntity);
    }
    public void updateEdit (Integer itemId){
        Item itemEntity = ir.findByItemId(itemId);
        ir.save(itemEntity);
    }

    public Integer countCartItem (String userName){ return  ir.countCartItem(userName);}
    public Integer countCartItemAdmin (){ return  ir.countCartItemAdmin();}

    public Integer countPendingItem (String userName){ return  ir.countPendingItem(userName);}
    public Integer countPendingItemAdmin (){ return  ir.countPendingItemAdmin();}

    public Integer countCancelItem (String userName){ return  ir.countCancelItem(userName);}
    public Integer countCancelItemAdmin (){ return  ir.countCancelItemAdmin();}
    public List<Item> searchItemOfClient (String userName){
        return ir.findItemByItemUserNameContainingAndItemStatusContaining(userName,"Cho xu ly");
    }

    public List<Item> showItemByOrderId (Integer orderId){
        return ir.findByOrderId(orderId);
    }
    public Double sumReFundVN (Date startDate, Date endDate){
        return ir.sumReFundVN(startDate,endDate);
    }
    public List<Item>  reFundVNList (Date startDate, Date endDate){
        return ir.findItemByRefundVN(startDate, endDate);
    }
    public List<Item>  showItemList (String searchKey){
        return ir.findItemByItemStatusContaining(searchKey);
    }
    public List<Item>  showItemListofClient (String userName){
        return ir.findByItemStatusContainingAndItemUserName("Huy",userName);
    }

    public Double sumReFundVNUser (String userName,Date startDate, Date endDate){
        return ir.sumReFundVNUser(userName,startDate,endDate);
    }
    public List<Item> reFundVNListUser (String userName, Date startDate, Date endDate){
        return ir.findItemByRefundVNUser(userName,startDate, endDate);
    }

	
	public Page<Item> list (Integer page , Integer perpage , String searchKey){
        return ir.findItemByItemStatusContaining(searchKey,PageRequest.of(page - 1, perpage));
    }
    public Page<Item> showClientPendingList (Integer page , Integer perpage , String Status, String UserName){
        return ir.findByItemStatusAndItemUserName(Status,us.currentLoginUser().getUserName(),PageRequest.of(page - 1, perpage));
    }


    public Page<Item> showItemCartList (Integer page , Integer perpage , String Status, String UserName){
        return ir.findByItemStatusAndItemUserName("Gio hang",us.currentLoginUser().getUserName(),PageRequest.of(page - 1, perpage));
    }

    public Page<Item> showItemCartAdminList (Integer page , Integer perpage , String Status){
        return ir.findByItemStatus("Gio hang",PageRequest.of(page - 1, perpage));
    }

    public Item findByItemId(Integer itemId){
        return ir.findByItemId(itemId);
    }


}
