package com.mrChill.Relax.Controller.USERs;


import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.Orders;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/user/search")
public class SearchControllerUser {

    @Autowired
    WayBillsService wbs;

    @Autowired
    OrdersService os;

    @Autowired
    UsersService us;

    @Autowired
    ItemService is;

    @RequestMapping("searchWB")
    public String showWayBillList(Model model, @RequestParam(required = false, name="search") String search) {
        String userName = us.currentLoginUser().getUserName();
        List<WayBills> showWayBillList =  wbs.showWayBillList(search);
        model.addAttribute("showWayBillList", showWayBillList);
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItem", is.countCartItem(userName));
        model.addAttribute("countPendingOrder",is.countPendingItem(userName));
        model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
        model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
        model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
        model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
        model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
        model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
        model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
        model.addAttribute("countCancelItem",is.countCancelItem(userName));
        return "/user/search/searchWB";
    }

    @RequestMapping("searchOrder")
    public String  showOrderList(Model model,  @RequestParam(required = false, name="search") String search) {
        String userName = us.currentLoginUser().getUserName();
        model.addAttribute("showOrderList", os.showSearchOrdersClient(search,userName));
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("countCartItem", is.countCartItem(userName));
        model.addAttribute("countPendingOrder",is.countPendingItem(userName));
        model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
        model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
        model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
        model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
        model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
        model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
        model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
        model.addAttribute("countCancelItem",is.countCancelItem(userName));
        return "/user/search/searchOrder";
    }
}
