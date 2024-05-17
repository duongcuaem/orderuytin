package com.mrChill.Relax.Controller.ADMIN;

import com.mrChill.Relax.Dao.ItemDAO;
import com.mrChill.Relax.Dao.OrdersDAO;
import com.mrChill.Relax.Dao.ResponseDAO;
import com.mrChill.Relax.Dao.WayBillsDAO;
import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.Service.ItemService;
import com.mrChill.Relax.Service.OrdersService;
import com.mrChill.Relax.Service.UsersService;
import com.mrChill.Relax.Service.WayBillsService;
import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.Orders;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/backend/wayBill")
public class WayBillsController {
    @Autowired
    OrdersService os;

    @Autowired
    OrdersRepository or;

    @Autowired
    ItemService is;

    @Autowired
    WayBillsService wbs;

    @Autowired
    UsersService us;

    @RequestMapping(value="saveWayBill",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String saveWayBill(@Valid @ModelAttribute OrdersDAO ordersDAO, WayBillsDAO waybillsDAO,
                                    BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
                                    RedirectAttributes model)  throws Exception {
        if(waybillsDAO.getWayBillCode().equals("")){
            os.saveOrder(ordersDAO);
            model.addFlashAttribute("message","更新订单成功.");
            return "redirect:/backend/order/bought" ;
        }
        if(ordersDAO.getOrderStatus().equals("Da ve kho")){
            wbs.saveWayBill(ordersDAO,waybillsDAO);
            model.addFlashAttribute("message","更新运费成功.");
            return "redirect:/backend/order/deliveried" ;
        }
        if(ordersDAO.getOrderStatus().equals("Huy")){
            Date today = java.util.Calendar.getInstance().getTime();
            ordersDAO.setCancelDate(today);
            os.saveOrder(ordersDAO);
            model.addFlashAttribute("message","已删除订单.");
            return "redirect:/backend/order/bought" ;
        }
        if(bindingResult.hasErrors()){
            return "redirect:/backend/order/bought";
        }

        //lưu wayBill vào csdl
        wbs.saveWayBill(ordersDAO,waybillsDAO);
        model.addFlashAttribute("message","已发货.");
        return "redirect:/backend/order/bought" ;
    }

    @RequestMapping("remove/{wayBillId}")
    public String updateCancel(RedirectAttributes model, @PathVariable Integer wayBillId) throws Exception{
        wbs.remove(wayBillId);
        model.addFlashAttribute("message", "运单号已取消.");
        model.addAttribute("loginUser", us.currentLoginUser());

        return "redirect:/backend/order/bought";
    }
    @RequestMapping("confirm/{wayBillId}")
    public String updateConfirm(RedirectAttributes model, @PathVariable Integer wayBillId) throws Exception{
        wbs.confirm(wayBillId);
        model.addFlashAttribute("message", "更新订单成功.");
        model.addAttribute("loginUser", us.currentLoginUser());

        return "redirect:/backend/order/arrivered";
    }

    @RequestMapping(value="create",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String create(@Valid @ModelAttribute WayBillsDAO waybillsDAO,
                       RedirectAttributes model)  throws Exception {

        //lưu wayBill vào csdl
        wbs.create(waybillsDAO);
        model.addFlashAttribute("message","更新运单号成功.");
        return "redirect:/backend/search/searchWBNULL" ;
    }

    @RequestMapping(value="save",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String save(@ModelAttribute WayBillsDAO waybillsDAO,
                              BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
                              RedirectAttributes model)  throws Exception {
        if(bindingResult.hasErrors()){
            return "redirect:/backend/order/deliveried";
        }
        //lưu wayBill vào csdl
         wbs.save(waybillsDAO);
        model.addFlashAttribute("message","更新运费成功.");
        return "redirect:/backend/order/deliveried" ;
    }




}
