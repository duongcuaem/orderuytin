package com.mrChill.Relax.Controller;


import com.mrChill.Relax.Dao.UsersDAO;
import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entity.User;
import com.mrChill.Relax.entity.UserProfile;
import com.mrChill.Relax.entity.UserRegistrationDto;
import com.mrChill.Relax.serviceBase.UserBaseService;
import com.mrChill.Relax.serviceBase.UserProfileService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller// đánh dấu nó là 1 controller
public class HomeController {
    @Autowired
    UsersService us;

    @Autowired
    OrdersService os;

    @Autowired
    ChargMoneyService cms;

    @Autowired
    ItemService is;

    @Autowired
    WayBillsService wbs;

    @Autowired
    UsersRepository ur;

    @Autowired
    UserBaseService userBaseService;

    @Autowired
    UserProfileService userProfileService;

//    @Autowired
//    PasswordEncoder passwordEncoder;

    @GetMapping("home")
    public String showHomePage(Model model){
        model.addAttribute("loginUser", us.currentLoginUser());
        return "home";
    }

    @RequestMapping({ "", "home/abc"})
    public String home(Model model){
        model.addAttribute("loginUser", us.currentLoginUser());
        return "home";
    }

    @RequestMapping("home/{path}")
//    @ResponseBody
    public String homeModel(Model model, @PathVariable String path,
                            @RequestParam(required = false) String key){
        return "/WEB-INF/views/home.jsp";
    }

    @RequestMapping("doLogin")
    public String login(){
        return "login";
    }

    @RequestMapping("notification")
    public String notification( ){ return "notification"; }

    @RequestMapping("instructions")
    public String instructions( ){ return "instructions"; }
    @RequestMapping("policies")
    public String policies( ){ return "policies"; }

    @RequestMapping("policies/rules")
    public String rules( ){ return "/policies/rules"; }

    @RequestMapping("policies/complain")
    public String complain( ){ return "/policies/complain"; }

    @RequestMapping("news")
    public String news( ){ return "news"; }
    @RequestMapping("baogia")
    public String baogia( ){ return "baogia"; }
    @RequestMapping("signup")
    public String signup(Model model){ 
        model.addAttribute("userRegistrationDto", new UserRegistrationDto());
        return "signup"; 
    }

//     @RequestMapping(value="create",method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
//     public String create(@Valid @ModelAttribute UsersDAO usersDAO,
//                          RedirectAttributes model)  throws Exception {

//         // Bước 1: Kiểm tra xem trùng email hay ko
// //        Users userEntity = ur.findFirstByEmail(usersDAO.getEmail());
//         if (ur.existsByEmail(usersDAO.getEmail())) {
//             model.addFlashAttribute("message","Email đã được dùng để đăng ký tài khoản. Quý khách vui lòng sử dụng email khác.");
//             return "redirect:/signup";
//         }
//         if(ur.existsByPhone(usersDAO.getPhone())) {
//             model.addFlashAttribute("message","Số điện thoại đã được dùng để đăng ký tài khoản. Quý khách vui lòng sử dụng email khác.");
//             return "redirect:/signup";
//         }
//         if(!usersDAO.getRePassword().equals(usersDAO.getPassword())) {
//             model.addFlashAttribute("message","Mật khẩu nhập lại không đúng .Vui lòng nhập đúng mật khẩu 2 lần.");
//             return "redirect:/signup";
//         }
//         // Bước 2: Lưu user vào bảng user
//         us.createUser(usersDAO);
//         model.addFlashAttribute("message","Quý khách đã tạo tài khoản thành công.Vui lòng đăng nhập để bắt đầu mua  sắm!!!");
//         return "redirect:/doLogin" ;
//     }
   @PostMapping(value = "/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String register(@ModelAttribute @Valid UserRegistrationDto userRegistrationDto, BindingResult result, RedirectAttributes model) {
        if (result.hasErrors()) {
            return "signup";
        }

        try {
            User user = userRegistrationDto.getUser();
            UserProfile userProfile = userRegistrationDto.getUserProfile();

            // Check if passwords match
            if (!user.getPassword().equals(userRegistrationDto.getRePassword())) {
                model.addFlashAttribute("message", "Mật khẩu không khớp!!!");
                return "redirect:/signup";
            }

            // Encode the user's password
            user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));

            // Check if the username already exists
            if (userBaseService.existsByUsername(user.getUsername())) {
                model.addFlashAttribute("message", "Tên tài khoản đã tồn tại!!!");
                return "redirect:/signup";
            }

            // Check if the email already exists
            if (userProfileService.existsByEmail(userProfile.getEmail())) {
                model.addFlashAttribute("message", "Email đã tồn tại!!!");
                return "redirect:/signup";
            }

            // Check if the phone number already exists
            if (userProfileService.existsByPhone(userProfile.getPhone())) {
                model.addFlashAttribute("message", "Số điện thoại đã tồn tại!!!");
                return "redirect:/signup";
            }

            // Create the user
            User createdUser = userBaseService.createUser(user);

            // Set the userId for userProfile and save userProfile
            userProfile.setUserId(createdUser.getId());
            userProfile.setUsername(createdUser.getUsername());
            userProfileService.createUserProfile(userProfile);

            model.addFlashAttribute("message", "Quý khách đã tạo tài khoản thành công. Vui lòng đăng nhập để bắt đầu mua sắm!!!");
            return "redirect:/doLogin";

        } catch (Exception e) {
            model.addFlashAttribute("message", "Đã xảy ra lỗi khi tạo tài khoản. Vui lòng thử lại.");
            return "redirect:/signup";
        }
    }

    @RequestMapping("loginFailed")
    public String login(Model model, @RequestParam Map<String, String> map) {
        if (map != null && map.size() > 0) {
            for (Map.Entry<String, String> entry: map.entrySet()
            ) {
                if (StringUtils.equals(entry.getKey(), "type")) {
                    if (StringUtils.equals(entry.getValue(), "1")) {
                        model.addAttribute("message", "Không tìm thấy tài khoản");
                    }
                } else if (StringUtils.equals(entry.getKey(), "username")){
                    model.addAttribute(entry.getKey(), entry.getValue());
                }
            }
        }
        return "login";
    }

    @RequestMapping("user/home")
    public String statisticsPage (Model model) throws ParseException {
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2023-01-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
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

    @RequestMapping("backend/home")
    public String statisticsAdminPage (Model model) throws ParseException {
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2023-01-01");
        Date endDate = java.util.Calendar.getInstance().getTime();
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

    // DuongDx
    @GetMapping("/loginSuccess")
    public String userInfo(HttpServletRequest request, Model model) {
        return "loginSuccess";
    }

    

}