package com.mrChill.Relax.Controller.ADMIN;

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
@RequestMapping("/backend/statistics")
public class StatisticsController {

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
        Page<Orders> pages = os.showOrdersDetail(page,perpage,startDate,endDate);
        model.addAttribute("totalVNDetail", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "backend/statistics/totalVNDetail";
    }

    @RequestMapping("totalVNDetailBetween2Days")
    public String showTotalVNDetailBetween2DaysList(Model model,
                                                    @RequestParam(required = false, defaultValue = "1") Integer page,
                                                    @RequestParam(required = false, defaultValue = "200") Integer perpage,
                                                    @RequestParam(required = false, name="startDate") String start,
                                                    @RequestParam(required = false, name="endDate") String end) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        Page<Orders> pages =  os.showOrdersDetail(page,perpage,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("totalVNDetail", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "backend/statistics/totalVNDetail";
    }

    @RequestMapping(value = "freightDetail")
    public String freightDetailPage (Model model,
                                     @RequestParam(required = false, defaultValue = "1") Integer page,
                                     @RequestParam(required = false, defaultValue = "200") Integer perpage) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2022-02-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        Page<WayBills> pages = wbs.showWayBillPage(page,perpage,startDate,endDate);
        model.addAttribute("freightDetail", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "backend/statistics/freightDetail";
    }

    @RequestMapping("freightDetailBetween2Days")
    public String showfreightDetailBetween2DaysList(Model model,
                                            @RequestParam(required = false, defaultValue = "1") Integer page,
                                            @RequestParam(required = false, defaultValue = "200") Integer perpage,
                                            @RequestParam(required = false, name="startDate") String start,
                                            @RequestParam(required = false, name="endDate") String end) throws ParseException{

        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        Page<WayBills> pages =  wbs.showWayBillPage(page,perpage,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("freightDetail", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "backend/statistics/freightDetail";
    }


    @RequestMapping("chargDetail")
    public String showChargList(Model model,
                                @RequestParam(required = false, defaultValue = "1") Integer page,
                                @RequestParam(required = false, defaultValue = "200") Integer perpage) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2023-01-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        Page<ChargMoney> pages =  cms.searchChargList(page,perpage,startDate,endDate);
        model.addAttribute("chargList", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "backend/statistics/chargDetail";
    }
    @RequestMapping("chargDetailBetween2Days")
    public String showChargBetween2DaysList(Model model,
                                @RequestParam(required = false, defaultValue = "1") Integer page,
                                @RequestParam(required = false, defaultValue = "200") Integer perpage,
                                @RequestParam(required = false, name="startDate") String start,
                                @RequestParam(required = false, name="endDate") String end) throws ParseException{

        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        Page<ChargMoney> pages =  cms.searchChargList(page,perpage,startDate,endDate);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("chargList", pages.getContent());
        model.addAttribute("page", page);
        model.addAttribute("perpage", perpage);
        model.addAttribute("total", pages.getTotalPages());
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
        return "backend/statistics/chargDetail";
    }

    @RequestMapping("refundDetail")
    public String showRefundDetail(Model model) throws ParseException{
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2023-01-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
        model.addAttribute("showRefundItemDetail", is.reFundVNList(startDate,endDate));
        model.addAttribute("showRefundOrderDetail", os.showOrdersCancelDetail("Huy"));
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
        return "backend/statistics/refundDetail";
    }

    @RequestMapping("refundDetailBetween2Days")
    public String showRefundDetailBetween2DaysList(Model model,
                                            @RequestParam(required = false, name="startDate") String start,
                                            @RequestParam(required = false, name="endDate") String end) throws ParseException{

        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        List<Item> item =  is.reFundVNListUser(us.currentLoginUser().getUserName(),startDate,endDate);
        List<Orders> orders = os.showOrdersCancelDetail("Huy");
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("showRefundItemDetail", item);
        model.addAttribute("showRefundOrderDetail", orders);
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
        return "backend/statistics/refundDetail";
    }

    @RequestMapping("statisticsAdminBetween2Days")
    public String statisticsAdminBetween2Days(Model model,
                                                    @RequestParam(required = false, name="startDate") String start,
                                                    @RequestParam(required = false, name="endDate") String end) throws ParseException {

        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(start);
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        model.addAttribute("from", startDate);
        model.addAttribute("to", endDate);
        model.addAttribute("sumTotalVN", os.sumTotalVN(startDate,endDate));
        model.addAttribute("sumTotalCancelVN", os.sumTotalCancelVN(startDate,endDate));
        model.addAttribute("sumTotalFreight", wbs.sumTotalFreight(startDate, endDate));
        model.addAttribute("sumAmount", cms.sumAmount(startDate, endDate));
        model.addAttribute("sumReFundVN", is.sumReFundVN(startDate,endDate));
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
        return "/backend/home";
    }
}
