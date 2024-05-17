package com.mrChill.Relax.Controller.ADMIN;

import com.mrChill.Relax.Dao.ChargMoneyDAO;
import com.mrChill.Relax.Service.ChargMoneyService;
import com.mrChill.Relax.Service.ItemService;
import com.mrChill.Relax.Service.OrdersService;
import com.mrChill.Relax.Service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/backend/chargMoney")
public class ChargMoneyController {

    @Autowired
    ChargMoneyService cms;

   @Autowired
    UsersService us;

   @Autowired
    ItemService is;

   @Autowired
    OrdersService os;

    @RequestMapping(value = "chargForm")
    public String statisticsPage (Model model){
        model.addAttribute("listUser", us.list());
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
        return "backend/chargMoney/chargForm";
    }

    @RequestMapping(value="charg",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String save(@Valid @ModelAttribute ChargMoneyDAO chargMoneyDAO,
                       BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
                       RedirectAttributes model)  throws Exception {
        if(bindingResult.hasErrors()){
            model.addFlashAttribute("message","Chưa nạp đươc tiền cho khách.");
            return "redirect:/backend/chargMoney/chargForm";
        }
        cms.charg(chargMoneyDAO);
        model.addFlashAttribute("message","Đã nạp tiền cho khách hàng thành công.");
        return "redirect:/backend/chargMoney/chargForm";
    }


}
