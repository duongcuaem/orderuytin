package com.mrChill.Relax.Controller.ADMIN;


import com.mrChill.Relax.Repository.OrdersRepository;
import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.Orders;
import com.mrChill.Relax.entities.Users;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.util.List;

@Controller
@RequestMapping("/backend/search")
public class SearchController {

    @Autowired
    WayBillsService wbs;

    @Autowired
    OrdersService os;

    @Autowired
    ItemService is;

    @Autowired
    UsersService us;

    @Autowired
    ChargMoneyService cms;

    @Autowired
    OrdersRepository or;

    @RequestMapping("searchWBNULL")
    public String showCreateWayBill(Model model) {

        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
        model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
        model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
        model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
        model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
        model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
        model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
        model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
        model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
        model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
        return "/backend/search/searchWBNULL";
    }


    @RequestMapping("searchWB")
    public String showWayBillList(Model model, @RequestParam(required = false, name = "search") String search) {
        List<WayBills> WayBillsList = wbs.showWayBillList(search);
        if (WayBillsList.size() == 0) {
            model.addAttribute("users", us.list());
            model.addAttribute("loginUser", us.currentLoginUser());
            return "/backend/search/searchWBNULL";
        }
//        Orders order = or.findByOrderId();

        model.addAttribute("showWayBillList", WayBillsList);
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
        model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
        model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
        model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
        model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
        model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
        model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
        model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
        model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
        model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());

        return "/backend/search/searchWB";
    }


    @RequestMapping("searchClient")
    public String showUserList(Model model, @RequestParam(required = false, name = "search") String search) throws ParseException {
        model.addAttribute("sumTotalUser", us.searchTotalUser(search));
        model.addAttribute("User", us.searchInfoUser(search));
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
        model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
        model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
        model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
        model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
        model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
        model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
        model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
        model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
        model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
        return "backend/search/searchUser";
    }

    @RequestMapping("searchItemOfClient")
    public String showItemOfClient(Model model, @RequestParam(required = false, name = "search") String search) throws ParseException {
        model.addAttribute("showItemOfClient",is.searchItemOfClient(search));
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
        model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
        model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
        model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
        model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
        model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
        model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
        model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
        model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
        model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
        if(is.searchItemOfClient(search).size() == 0){
            model.addAttribute("message","找不到订单");
            return "backend/search/searchItemOfClient";
        }
        return "backend/search/searchItemOfClient";
    }

    @RequestMapping("searchOrder")
    public String showOrderList(Model model, @RequestParam(required = false, name = "search") String search) {
        List<Orders> orderList = os.showOrderList(search);
        if (orderList.size() == 0){
            orderList = os.showOrderListof1Client(search);
        }
        model.addAttribute("showOrderList", orderList);
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
        model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
        model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
        model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
        model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
        model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
        model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
        model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
        model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
        model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
        return "/backend/search/searchOrder";
    }
    @RequestMapping("searchArriveredOrder")
    public String searchArriveredOrder(Model model, @RequestParam(required = false, name = "search") String search) {
        List<Orders> orderList = os.showOrderList(search);
        if (orderList.size() == 0){
            orderList = os.showArriveredOrderList(search);
        }
        model.addAttribute("showOrderList", orderList);
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItemAdmin",is.countCartItemAdmin());
        model.addAttribute("countPendingOrderAdmin",is.countPendingItemAdmin());
        model.addAttribute("countBoughtOrderAdmin",os.countBoughtOrderAdmin());
        model.addAttribute("countDeliveredOrderAdmin",os.countDeliveredOrderAdmin());
        model.addAttribute("countArriveredOrderAdmin",os.countArriveredOrderAdmin());
        model.addAttribute("countFinishedOrderAdmin",os.countFinishedOrderAdmin());
        model.addAttribute("countCancelOrderAdmin",os.countCancelOrderAdmin());
        model.addAttribute("countComplainOrderAdmin",os.countComplainOrderAdmin());
        model.addAttribute("countFixOrderAdmin",os.countFixOrderAdmin());
        model.addAttribute("countCancelItemAdmin",is.countCancelItemAdmin());
        return "/backend/search/searchArriveredOrder";
    }
}
