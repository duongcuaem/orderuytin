package com.mrChill.Relax.Controller;

import com.mrChill.Relax.Dao.UsersDAO;
import com.mrChill.Relax.Repository.*;
import com.mrChill.Relax.Response.*;
import com.mrChill.Relax.Service.UsersService;
import com.mrChill.Relax.entities.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Stack;

@RestController
public class ApiController {
    public static Logger logger = LoggerFactory.getLogger(ApiController.class);
    @Autowired
    UsersService us ;

    @Autowired
    OrdersRepository or;

    @Autowired
    ItemRepository ir;

    @Autowired
    UsersRepository ur;

    @Autowired
    WayBillsRepository wbr;

    @Autowired
    ChargMoneyRepository cmr;

    @Autowired
    PasswordEncoder passwordEncoder;

    @GetMapping(value="/rateApi")
    public Integer  getRate( ){
        return 3500;
    }

    @GetMapping("/boughtOrder/{userName}")
    public ResponseEntity<List<OrdersResponse>> getBoughtOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderStatusContainingAndOrderUserNameContaining("Da mua hang",userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
             }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/deleveriedOrder/{userName}")
    public ResponseEntity<List<OrdersResponse>> getDeleveriedOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderStatusContainingAndOrderUserNameContaining("Da phat hang",userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<>(responseList, HttpStatus.OK);
    }

    @GetMapping("/arriveredOrder/{userName}")
    public ResponseEntity<List<OrdersResponse>> getArriveredOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderStatusContainingAndOrderUserNameContaining("Da ve kho",userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }


    @GetMapping("/finishedOrder/{userName}")
    public ResponseEntity<List<OrdersResponse>> getFinishedOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderStatusContainingAndOrderUserNameContaining("Thanh cong",userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/complainOrder/{userName}")
    public ResponseEntity<List<OrdersResponse>> getComplainOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderStatusContainingAndOrderUserNameContaining("Khieu nai",userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/cancelOrder/{userName}")
    public ResponseEntity<List<OrdersResponse>> getCancelOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderStatusContainingAndOrderUserNameContaining("Huy",userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }
 

    @GetMapping("/order/{userName}")
    public ResponseEntity<List<OrdersResponse>> getOrder(@PathVariable(value = "userName") String userName) {
        List<Orders> list = or.findByOrderUserName(userName);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/pendingOrder/{itemUserName}")
    public ResponseEntity<List<ItemResponse>> getPendingOrder(@PathVariable(value = "itemUserName") String itemUserName) {
        List<Item> list = ir.findByItemStatusContainingAndItemUserName("Cho xu ly",itemUserName);
        List<ItemResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            ItemResponse irp = new ItemResponse();
            irp.setOrderId(e.getOrderId());
            irp.setAdminNote(e.getAdminNote());
            irp.setDescrible(e.getDescrible());
            irp.setLink(e.getLink());
            irp.setImage(e.getImage());
            irp.setItemId(e.getItemId());
            irp.setPrice(e.getPrice());
            irp.setItemStatus(e.getItemStatus());
            irp.setCNYrateVND(e.getCNYrateVND());
            irp.setQuantity(e.getQuantity());
            irp.setUserNote(e.getUserNote());
            irp.setRefundDate(e.getRefundDate());
            irp.setQuantityRefund(e.getQuantityRefund());
            irp.setItemUserName(e.getItemUserName());

            responseList.add(irp);
        });

        return new ResponseEntity<List<ItemResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/cancelItem/{itemUserName}")
    public ResponseEntity<List<ItemResponse>> getCancelItem(@PathVariable(value = "itemUserName") String itemUserName) {
        List<Item> list = ir.findByItemStatusContainingAndItemUserName("Huy",itemUserName);
        List<ItemResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            ItemResponse irp = new ItemResponse();
            irp.setOrderId(e.getOrderId());
            irp.setAdminNote(e.getAdminNote());
            irp.setDescrible(e.getDescrible());
            irp.setLink(e.getLink());
            irp.setImage(e.getImage());
            irp.setItemId(e.getItemId());
            irp.setPrice(e.getPrice());
            irp.setItemStatus(e.getItemStatus());
            irp.setCNYrateVND(e.getCNYrateVND());
            irp.setQuantity(e.getQuantity());
            irp.setUserNote(e.getUserNote());
            irp.setRefundDate(e.getRefundDate());
            irp.setQuantityRefund(e.getQuantityRefund());
            irp.setItemUserName(e.getItemUserName());

            responseList.add(irp);
        });
        return new ResponseEntity<List<ItemResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/cart/{itemUserName}")
    public ResponseEntity<List<ItemResponse>> getItemInCart(@PathVariable(value = "itemUserName") String itemUserName) {
        List<Item> list = ir.findByItemStatusContainingAndItemUserName("Gio hang",itemUserName);
        List<ItemResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            ItemResponse irp = new ItemResponse();
            irp.setOrderId(e.getOrderId());
            irp.setAdminNote(e.getAdminNote());
            irp.setDescrible(e.getDescrible());
            irp.setLink(e.getLink());
            irp.setImage(e.getImage());
            irp.setItemId(e.getItemId());
            irp.setPrice(e.getPrice());
            irp.setItemStatus(e.getItemStatus());
            irp.setCNYrateVND(e.getCNYrateVND());
            irp.setQuantity(e.getQuantity());
            irp.setUserNote(e.getUserNote());
            irp.setRefundDate(e.getRefundDate());
            irp.setQuantityRefund(e.getQuantityRefund());
            irp.setItemUserName(e.getItemUserName());
            responseList.add(irp);
        });
        return new ResponseEntity<List<ItemResponse>>( responseList,HttpStatus.OK);
    }


    @GetMapping("/users")
    public ResponseEntity<List<UsersResponse>> getUsers() {
        List<Users> list = ur.findAll();
        List<UsersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            UsersResponse urp = new UsersResponse();
            urp.setRePassword(e.getRePassword());
            urp.setUserName(e.getUserName());
            urp.setPassword(e.getPassword());
            urp.setAddress(e.getAddress());
            urp.setUserId(e.getUserId());
            urp.setSTATUS(e.getSTATUS());
            urp.setRateM3(e.getRateM3());
            urp.setRateKg(e.getRateKg());
            urp.setPhone(e.getPhone());
            urp.setEmail(e.getEmail());
            urp.setRole(e.getRole());
            urp.setRate(e.getRate());

            responseList.add(urp);
        });

        return new ResponseEntity<List<UsersResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/userNames")
    public ResponseEntity<List<String>> getUserName() {
        List<Users> list = ur.findAll();
        List<String> responseList = new ArrayList<>();
        list.forEach(e->{
//            UsersResponse urp = new UsersResponse();
            responseList.add(e.getUserName());
        });

        return new ResponseEntity<List<String>>( responseList,HttpStatus.OK);
    }



    @GetMapping("/chargMoney")
    public ResponseEntity<List<ChargMoneyResponse>> getChargMoney() {
        List<ChargMoney> list = cmr.findAll();
        List<ChargMoneyResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            ChargMoneyResponse cmrp = new ChargMoneyResponse();
                cmrp.setChargId(e.getChargId());
                cmrp.setUserId(e.getUserId());
                cmrp.setNote(e.getNote());
                cmrp.setAmount(e.getAmount());
                cmrp.setChargDate(e.getChargDate());

            responseList.add(cmrp);
        });

        return new ResponseEntity<List<ChargMoneyResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/wayBills")
    public ResponseEntity<List<WayBillsResponse>> getWayBills() {
        List<WayBills> list = wbr.findAll();
        List<WayBillsResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            WayBillsResponse wbrp = new WayBillsResponse();
            wbrp.setWayBillId(e.getWayBillId());
            wbrp.setKg(e.getKg());
            wbrp.setRateKg(e.getRateKg());
            wbrp.setCubic(e.getCubic());
            wbrp.setFreight(e.getFreight());
            wbrp.setWayBillCode(e.getWayBillCode());
            wbrp.setArriveredDate(e.getArriveredDate());
            wbrp.setType(e.getType());
            wbrp.setOrderId(e.getOrderId());
            wbrp.setRateCubic(e.getRateCubic());
            wbrp.setWbUserName(e.getWbUserName());
            responseList.add(wbrp);
        });

        return new ResponseEntity<List<WayBillsResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/findWayBill/{wayBillCode}")
    public ResponseEntity<List<WayBillsResponse>> findWayBill(@PathVariable(value = "wayBillCode") String wayBillCode) {
        List<WayBills> list = wbr.findByWayBillCodeIsContainingIgnoreCase(wayBillCode);
        List<WayBillsResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            WayBillsResponse wbrp = new WayBillsResponse();
            wbrp.setWayBillId(e.getWayBillId());
            wbrp.setKg(e.getKg());
            wbrp.setRateKg(e.getRateKg());
            wbrp.setCubic(e.getCubic());
            wbrp.setFreight(e.getFreight());
            wbrp.setWayBillCode(e.getWayBillCode());
            wbrp.setArriveredDate(e.getArriveredDate());
            wbrp.setType(e.getType());
            wbrp.setOrderId(e.getOrderId());
            wbrp.setRateCubic(e.getRateCubic());
            wbrp.setWbUserName(e.getWbUserName());
            responseList.add(wbrp);
        });

        return new ResponseEntity<List<WayBillsResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/findBoughtOrder/{orderNo}")
    public ResponseEntity<List<OrdersResponse>> findBoughtOrder(@PathVariable(value = "orderNo") String orderNo) {
        List<Orders> list = or.findOrdersByOrderNoIsContaining(orderNo);
        List<OrdersResponse> responseList = new ArrayList<>();
        list.forEach(e->{
            OrdersResponse orp = new OrdersResponse();
            orp.setOrderId(e.getOrderId());
            orp.setOrderNo(e.getOrderNo());
            orp.setOrderStatus(e.getOrderStatus());
            orp.setOrderUserName(e.getOrderUserName());
            orp.setReceivedDate(e.getReceivedDate());
            orp.setShipFeeCNY(e.getShipFeeCNY());
            orp.setShipFeeVND(e.getShipFeeVND());
            orp.setCancelDate(e.getCancelDate());
            orp.setTotalCN(e.getTotalCN());
            orp.setTotalVN(e.getTotalVN());
            List<Item> items = new ArrayList<>();
            for (Item i: e.getItems()  ) {
                items.add(i);
            }
            List<WayBills> wbs = new ArrayList<>();
            for (WayBills w: e.getWaybills()) {
                wbs.add(w);
            }
            orp.setItems(items);
            orp.setWaybills(wbs);
            responseList.add(orp);
        });

        return new ResponseEntity<List<OrdersResponse>>( responseList,HttpStatus.OK);
    }

    @GetMapping("/findOrder/{orderId}")
    public ResponseEntity<OrdersResponse> findOrder(@PathVariable(value = "orderId") Integer orderId) {
        Orders order = or.findByOrderId(orderId);
        OrdersResponse orp = new OrdersResponse();
        orp.setOrderId(order.getOrderId());
        orp.setOrderNo(order.getOrderNo());
        orp.setOrderStatus(order.getOrderStatus());
        orp.setOrderUserName(order.getOrderUserName());
        orp.setReceivedDate(order.getReceivedDate());
        orp.setShipFeeCNY(order.getShipFeeCNY());
        orp.setShipFeeVND(order.getShipFeeVND());
        orp.setCancelDate(order.getCancelDate());
        orp.setTotalCN(order.getTotalCN());
        orp.setTotalVN(order.getTotalVN());
        List<Item> items = new ArrayList<>();
        for (Item i: order.getItems()  ) {
            items.add(i);
        }
        List<WayBills> wbs = new ArrayList<>();
        for (WayBills w: order.getWaybills()) {
            wbs.add(w);
        }
        orp.setItems(items);
        orp.setWaybills(wbs);
    return new ResponseEntity<OrdersResponse>( orp,HttpStatus.OK);
    }


    @RequestMapping(value = "/item/{itemId}", method = RequestMethod.DELETE)
    public ResponseEntity<ItemResponse> deleteItem(@PathVariable(value = "itemId") Integer itemId) {
        Item item = ir.findByItemId(itemId);
        if(item == null) {
            return ResponseEntity.notFound().build();
        }

        ir.delete(item);
        return ResponseEntity.ok().build();
    }



    @RequestMapping(value = "/order/{orderId}", method = RequestMethod.DELETE)
    public ResponseEntity<OrdersResponse> deleteOrder(@PathVariable(value = "orderId") Integer orderId) {
        Orders order = or.findByOrderId(orderId);
        if(order == null) {
            return ResponseEntity.notFound().build();
        }
        List<Item> listItems = ir.findByOrderId(orderId);
        List<WayBills> listWayBills = wbr.findByOrderId(orderId);
        for (Item item: listItems) {
            ir.delete(item);
        }
        for (WayBills wb: listWayBills) {
            wbr.delete(wb);
        }
        or.delete(order);
        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/updateCancelItem/{itemId}", method = RequestMethod.PUT)
    public Item updateCancelItem(@PathVariable(value = "itemId") Integer itemId) {
        Item i = ir.findByItemId(itemId);
        if(i == null) {
            return null;
        }
        i.setOrderId(i.getOrderId());
        i.setAdminNote(i.getAdminNote());
        i.setDescrible(i.getDescrible());
        i.setLink(i.getLink());
        i.setImage(i.getImage());
        i.setItemId(i.getItemId());
        i.setPrice(i.getPrice());
        i.setItemStatus("Huy");
        i.setCNYrateVND(i.getCNYrateVND());
        i.setQuantity(i.getQuantity());
        i.setUserNote(i.getUserNote());
        i.setRefundDate(i.getRefundDate());
        i.setQuantityRefund(i.getQuantityRefund());
        i.setItemUserName(i.getItemUserName());
        return ir.save(i);
    }

    @RequestMapping(value = "/confirmSuccessOrder/{orderId}", method = RequestMethod.PUT)
    public Orders confirmSuccessOrder (@PathVariable(value = "orderId") Integer orderId) {
        Orders o = or.findByOrderId(orderId);
        if(o == null) {
            return null;
        }
     o.setOrderStatus("Thanh cong");

        return or.save(o);
    }

    @RequestMapping(value = "/submitComplainOrder/{orderId}", method = RequestMethod.PUT)
    public Orders submitComplainOrder (@PathVariable(value = "orderId") Integer orderId) {
        Orders o = or.findByOrderId(orderId);
        if(o == null) {
            return null;
        }
        o.setOrderStatus("Khieu nai");

        return or.save(o);
    }


    @RequestMapping(value = "/putBuyNowItem/{itemId}", method = RequestMethod.PUT)
    public Item putBuyNowItem (@PathVariable(value = "itemId") Integer itemId) {
      Item i = ir.findByItemId(itemId);
        if(i == null) {
            return null;
        }
        i.setItemStatus("Cho xu ly");

        return ir.save(i);
    }

    @RequestMapping(value = "/updateRefundItem/{itemId}", method = RequestMethod.PUT)
    public Item updateRefundItem(@PathVariable(value = "itemId") Integer itemId) {
        Item i = ir.findByItemId(itemId);
        if(i == null) {
            return null;
        }
        i.setOrderId(i.getOrderId());
        i.setAdminNote(i.getAdminNote());
        i.setDescrible(i.getDescrible());
        i.setLink(i.getLink());
        i.setImage(i.getImage());
        i.setItemId(i.getItemId());
        i.setPrice(i.getPrice());
        i.setItemStatus("Cho xu ly");
        i.setCNYrateVND(i.getCNYrateVND());
        i.setQuantity(i.getQuantity());
        i.setUserNote(i.getUserNote());
        i.setRefundDate(i.getRefundDate());
        i.setQuantityRefund(i.getQuantityRefund());
        i.setItemUserName(i.getItemUserName());
        return ir.save(i);
    }

    @RequestMapping(value = "/complainItem", method = RequestMethod.PUT)
    public Item complainItem(@RequestParam(value = "itemId") Integer itemId,
                             @RequestParam(value = "userNote") String userNote) {
        Item i = ir.findByItemId(itemId);
        if(i == null) {
            return null;
        }
        i.setOrderId(i.getOrderId());
        i.setAdminNote(i.getAdminNote());
        i.setDescrible(i.getDescrible());
        i.setLink(i.getLink());
        i.setImage(i.getImage());
        i.setItemId(i.getItemId());
        i.setPrice(i.getPrice());
        i.setItemStatus("Khieu nai");
        i.setCNYrateVND(i.getCNYrateVND());
        i.setQuantity(i.getQuantity());
        i.setUserNote(userNote);
        i.setRefundDate(i.getRefundDate());
        i.setQuantityRefund(i.getQuantityRefund());
        i.setItemUserName(i.getItemUserName());

        Orders o = or.findByOrderId(i.getOrderId());
        o.setOrderStatus("Khieu nai");
        or.save(o);
        return ir.save(i);
    }

//    @RequestMapping(value = "/complainItem/{itemId}", method = RequestMethod.PUT)
//    public Item complainItemId(@PathVariable(value = "itemId") Integer itemId,
//                             @RequestParam(value = "userNote") String userNote) {
//        Item i = ir.findByItemId(itemId);
//        if(i == null) {
//            return null;
//        }
//        i.setOrderId(i.getOrderId());
//        i.setAdminNote(i.getAdminNote());
//        i.setDescrible(i.getDescrible());
//        i.setLink(i.getLink());
//        i.setImage(i.getImage());
//        i.setItemId(i.getItemId());
//        i.setPrice(i.getPrice());
//        i.setItemStatus("Khieu nai");
//        i.setCNYrateVND(i.getCNYrateVND());
//        i.setQuantity(i.getQuantity());
//        i.setUserNote(userNote);
//        i.setRefundDate(i.getRefundDate());
//        i.setQuantityRefund(i.getQuantityRefund());
//        i.setItemUserName(i.getItemUserName());
//
//        Orders o = or.findByOrderId(i.getOrderId());
//        o.setOrderStatus("Khieu nai");
//        or.save(o);
//        return ir.save(i);
//    }

    @RequestMapping(value = "/waybill/{waybillId}", method = RequestMethod.DELETE)
    public ResponseEntity<WayBillsResponse> deleteWaybill(@PathVariable(value = "waybillId") Integer waybillId) {
        WayBills wb = wbr.findByWayBillId(waybillId);
        if(wb == null) {
            return ResponseEntity.notFound().build();
        }

        wbr.delete(wb);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/getUserDetails/{userId}")
    public ResponseEntity<UsersResponse> getUserDetails(@PathVariable(value = "userId") Integer userId) {
        Users user = ur.findByUserId(userId);

        UsersResponse ures = new UsersResponse();
        ures.setRole(user.getRole());
        ures.setUserId(user.getUserId());
        ures.setUserName(user.getUserName());
        ures.setRePassword(user.getRePassword());
        ures.setSTATUS(user.getSTATUS());
        ures.setRate(user.getRate());
        ures.setRateM3(user.getRateM3());
        ures.setRateKg(user.getRateKg());
        ures.setPassword(user.getPassword());
        ures.setEmail(user.getEmail());
        ures.setPhone(user.getPhone());
        ures.setAddress(user.getAddress());
        if(user == null) {return null ;}

        return new ResponseEntity<UsersResponse>( ures,HttpStatus.OK);
    }

    @RequestMapping(value="createAccount",method = RequestMethod.POST)
    public Users createAccount(@Valid @RequestBody Users user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRePassword(passwordEncoder.encode(user.getRePassword()));
        return ur.save(user) ;
    }

    @RequestMapping(value = "/createItem", method = RequestMethod.POST)
    public Item saveItem(@Valid @RequestBody Item item) {
        return ir.save(item);
    }

    @RequestMapping(value = "/addCart", method = RequestMethod.POST)
    public Item addCart(@Valid @RequestBody Item item) { return ir.save(item);}

    @GetMapping("/statistics/{userName}")
    public ResponseEntity<StatisticsResponse> getStatisticsClient(@PathVariable(value = "userName") String userName) throws ParseException {
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2023-01-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        Users user = ur.findByUserNameIsContainingIgnoreCase(userName);
        StatisticsResponse statisticsResponse = new StatisticsResponse();

        statisticsResponse.countPendingItem = ir.countPendingItem(userName);
        statisticsResponse.countWholeOrder = or.countWholeOrder(userName);
        statisticsResponse.countCancelItem = ir.countCancelItem(userName);
        statisticsResponse.countCartItem = ir.countCartItem(userName);
        statisticsResponse.countCancelOrder = or.countCancelOrder(userName);
        statisticsResponse.countBoughtOrder = or.countBoughtOrder(userName);
        statisticsResponse.countComplainOrder = or.countComplainOrder(userName);
        statisticsResponse.countFinishedOrder = or.countFinishedOrder(userName);
        statisticsResponse.countDeliveredOrder = or.countDeliveredOrder(userName);
        statisticsResponse.countArriveredOrder = or.countArriveredOrder(userName);
        statisticsResponse.sumTotalVNUser = or.sumTotalVNUser(userName,startDate,endDate);
        statisticsResponse.sumReFundVNUser = ir.sumReFundVNUser(userName,startDate,endDate);
        statisticsResponse.sumAmountUser = cmr.sumAmountUser(user.getUserId(),startDate,endDate);
        statisticsResponse.sumTotalCancelVNUser = or.sumTotalCancelVNUser(userName,startDate,endDate);
        statisticsResponse.sumTotalFreightUser = wbr.sumTotalFreightUser(userName,startDate,endDate);

        return new ResponseEntity<StatisticsResponse>( statisticsResponse,HttpStatus.OK);
    }


    @GetMapping("/userCurrent/{userName}")
    public ResponseEntity<Integer> getUser(@PathVariable(value = "userName") String userName) {
        Users user = ur.findByUserNameIsContainingIgnoreCase(userName);

        Integer rate = user.getRate();
        return new ResponseEntity<Integer>( rate,HttpStatus.OK);
    }
}
