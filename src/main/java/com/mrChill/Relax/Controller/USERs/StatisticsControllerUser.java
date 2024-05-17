package com.mrChill.Relax.Controller.USERs;

import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.ChargMoney;
import com.mrChill.Relax.entities.Item;
import com.mrChill.Relax.entities.Orders;
import com.mrChill.Relax.entities.WayBills;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/user/statistics")
public class StatisticsControllerUser {

    @Autowired
    OrdersService os;
    @Autowired
    ChargMoneyService cms;

    @Autowired
    ItemService is;

    @Autowired
    WayBillsService wbs;

    @Autowired
    UsersService us;

    @RequestMapping(value = "totalVNDetail")
    public String totalVNDetailPage (Model model,
                                     @RequestParam(required = false, defaultValue = "1") Integer page,
                                     @RequestParam(required = false, defaultValue = "200") Integer perpage) throws ParseException {
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2022-02-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        String userName = us.currentLoginUser().getUserName();
        Page<Orders> pages = os.showOrdersDetailUser(userName,page,perpage,startDate,endDate);
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("totalVNDetailUser", pages.getContent());
        model.addAttribute("countCartItem", is.countCartItem(userName));
        model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
        model.addAttribute("countCancelItem",is.countCancelItem(userName));
        model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
        model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
        model.addAttribute("countPendingOrder",is.countPendingItem(userName));
        model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
        model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
        model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
        model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
        return "user/statistics/totalVNDetail";
    }

    @RequestMapping("totalVNDetailBetween2Days")
    public String showTotalVNDetailBetween2DaysList(Model model,
                                                    @RequestParam(required = false, defaultValue = "1") Integer page,
                                                    @RequestParam(required = false, defaultValue = "200") Integer perpage,
                                                    @RequestParam(required = false, name="startDate") String start,
                                                    @RequestParam(required = false, name="endDate") String end) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        String userName = us.currentLoginUser().getUserName();
        Page<Orders> pages =  os.showOrdersDetailUser(userName,page,perpage,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("totalVNDetailUser", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "user/statistics/totalVNDetail";
    }

    @RequestMapping(value = "freightDetail")
    public String freightDetailPage (Model model,
                                     @RequestParam(required = false, defaultValue = "1") Integer page,
                                     @RequestParam(required = false, defaultValue = "200") Integer perpage) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2022-02-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        String userName = us.currentLoginUser().getUserName();
        Page<WayBills> pages = wbs.showWayBillPageUser(userName,page,perpage,startDate,endDate);
        model.addAttribute("freightDetailUser", pages.getContent());
        model.addAttribute("startDate", startDate);
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "user/statistics/freightDetail";
    }

    @RequestMapping("freightDetailBetween2Days")
    public String showfreightDetailBetween2DaysList(Model model,
                                            @RequestParam(required = false, defaultValue = "1") Integer page,
                                            @RequestParam(required = false, defaultValue = "200") Integer perpage,
                                            @RequestParam(required = false, name="startDate") String start,
                                            @RequestParam(required = false, name="endDate") String end) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        String userName = us.currentLoginUser().getUserName();
        Page<WayBills> pages =  wbs.showWayBillPageUser(userName,page,perpage,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("freightDetailUser", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "user/statistics/freightDetail";
    }


    @RequestMapping("chargDetail")
    public String showChargList(Model model,
                                @RequestParam(required = false, defaultValue = "1") Integer page,
                                @RequestParam(required = false, defaultValue = "200") Integer perpage) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2022-02-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        String userName = us.currentLoginUser().getUserName();
        Page<ChargMoney> pages =  cms.searchChargListUser(us.currentLoginUser().getUserId(),page,perpage,startDate,endDate);
        model.addAttribute("chargListUser", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "user/statistics/chargDetail";
    }
    @RequestMapping("chargDetailBetween2Days")
    public String showChargBetween2DaysList(Model model,
                                @RequestParam(required = false, defaultValue = "1") Integer page,
                                @RequestParam(required = false, defaultValue = "200") Integer perpage,
                                @RequestParam(required = false, name="startDate") String start,
                                @RequestParam(required = false, name="endDate") String end) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        String userName = us.currentLoginUser().getUserName();
        Page<ChargMoney> pages =  cms.searchChargListUser(us.currentLoginUser().getUserId(),page,perpage,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("chargListUser", pages.getContent());
        model.addAttribute("countCartItem", is.countCartItem(userName));
        model.addAttribute("countWholeOrder",os.countWholeOrder(userName));
        model.addAttribute("countCancelItem",is.countCancelItem(userName));
        model.addAttribute("countBoughtOrder",os.countBoughtOrder(userName));
        model.addAttribute("countCancelOrder",os.countCancelOrder(userName));
        model.addAttribute("countPendingOrder",is.countPendingItem(userName));
        model.addAttribute("countFinishedOrder",os.countFinishedOrder(userName));
        model.addAttribute("countComplainOrder",os.countComplainOrder(userName));
        model.addAttribute("countDeliveredOrder",os.countDeliveredOrder(userName));
        model.addAttribute("countArriveredOrder",os.countArriveredOrder(userName));
        return "user/statistics/chargDetail";
    }

    @RequestMapping("refundDetail")
    public String showRefundDetail(Model model) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2022-02-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        String userName = us.currentLoginUser().getUserName();
        List<Item> item =  is.reFundVNListUser(userName,startDate,endDate);
        List<Orders> orders = os.showOrdersCancelDetailUser(userName,"Huy",startDate,endDate);
        model.addAttribute("showRefundItemDetailUser", item);
        model.addAttribute("showRefundOrderDetailUser", orders);
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

        return "user/statistics/refundDetail";
    }

    @RequestMapping("refundDetailBetween2Days")
    public String showRefundDetailBetween2DaysList(Model model,
                                            @RequestParam(required = false, defaultValue = "Huy") String status,
                                            @RequestParam(required = false, name="startDate") String start,
                                            @RequestParam(required = false, name="endDate") String end) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        String userName = us.currentLoginUser().getUserName();
        List<Item> item =  is.reFundVNListUser(userName,startDate,endDate);
        List<Orders> orders = os.showOrdersCancelDetailUser(userName,status,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("showRefundItemDetailUser", item);
        model.addAttribute("showRefundOrderDetailUser", orders);
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
        return "user/statistics/refundDetail";
    }

    @RequestMapping("/searchStatistics")
    public String searchStatisticsBetween2Days(Model model,
                                               @RequestParam(required = false, name="startDate") String start,
                                               @RequestParam(required = false, name="endDate") String end)
            throws ParseException {
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        String userName = us.currentLoginUser().getUserName();
        model.addAttribute("sumTotalVNUser", os.sumTotalVNUser(userName,startDate,endDate));
        model.addAttribute("sumTotalCancelVNUser", os.sumTotalCancelVNUser(userName,startDate,endDate));
        model.addAttribute("sumTotalFreightUser", wbs.sumTotalFreightUser(userName,startDate, endDate));
        model.addAttribute("sumAmountUser", cms.sumAmountUser(us.currentLoginUser().userId,startDate, endDate));
        model.addAttribute("sumReFundVNUser", is.sumReFundVNUser(userName,startDate,endDate));
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
        return "/user/home";
    }


}
