package com.mrChill.Relax.Controller.ADMIN;

import com.mrChill.Relax.Dao.UsersDAO;
import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.ParseException;
import java.util.List;

@Controller
@RequestMapping("/backend/user")
@PreAuthorize("hasAnyRole('ADMIN')")
public class UserController {

    @Autowired
    UsersService us;

    @Autowired
    ItemService is;

    @Autowired
    OrdersService os;

    @Autowired
    WayBillsService wbs;

    @Autowired
    ChargMoneyService cms;


    @RequestMapping(value="save",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String save( @ModelAttribute  UsersDAO userDAO,
                        BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
                        RedirectAttributes model)  throws Exception {

        if (bindingResult.hasErrors()) {
            return "backend/search/searchUser";
        }
        //lưu user vào csdl
         us.save(userDAO);
        model.addFlashAttribute("message","账户更新成功.");
        model.addAttribute("loginUser", us.currentLoginUser());

        return "/backend/search/searchUser" ;
    }

    @RequestMapping(value="savePassword",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String savePassword( @ModelAttribute  UsersDAO userDAO,
                        BindingResult bindingResult ,// ngay sau biến có @Valid , chứa kết quả sau khi valid
                        RedirectAttributes model)  throws Exception {

        if (bindingResult.hasErrors()) {
            return "backend/user/userList";
        }
        //lưu user vào csdl
        us.savePassword(userDAO);
        model.addAttribute("loginUser", us.currentLoginUser());
        return "backend/user/userList" ;
    }

    @RequestMapping("userList")
    public String showUserList(Model model) throws Exception {
        model.addAttribute("sumTotal", us.sumTotal());
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
        return "backend/user/userList";
    }
    @RequestMapping("resetPassword/{id}")
    public String resetPassword(Model model, @PathVariable Integer id) throws Exception {
        model.addAttribute("User", us.changPass(id));
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
        return "backend/user/resetPassword";
    }


    @GetMapping("/delete/{id}")
    public String deleteUser (@PathVariable  Integer id,RedirectAttributes model){
        String username = us.currentLoginUser().getUserName();
        us.delete(id);
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addFlashAttribute("message","删除 " + username +" 账户成功");
        return "redirect:/backend/user/userList";
    }

    @RequestMapping("/updateRate")
    public String updateRate (Model model,
                              @RequestParam(required = false, name="rate") Integer rate ,
                              @RequestParam(required = false, name="rateKg")Integer rateKg,
                              @RequestParam(required = false, name="rateM3")Integer rateM3)
            throws ParseException {
       List<Users> usersList = us.list();
       UsersDAO userDAO = new UsersDAO();
        for (Users u : usersList) {
            userDAO.setRate(rate);
            userDAO.setRateKg(rateKg);
            userDAO.setRateM3(rateM3);
            userDAO.setUserId(u.getUserId());
            userDAO.setPassword(u.getPassword());
            userDAO.setEmail(u.getEmail());
            userDAO.setAddress(u.getAddress());
            userDAO.setPhone(u.getPhone());
            userDAO.setRole(u.getRole());
            userDAO.setSTATUS(u.getSTATUS());
            userDAO.setRePassword(u.getRePassword());
            userDAO.setUserName(u.getUserName());
        us.save(userDAO);
        }

        model.addAttribute("message","调整汇率成功");
        model.addAttribute("loginUser", us.currentLoginUser());

        return "backend/user/userList";
    }
}
