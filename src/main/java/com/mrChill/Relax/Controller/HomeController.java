package com.mrChill.Relax.Controller;


import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.Service.*;
import com.mrChill.Relax.entities.Users;
import com.mrChill.Relax.security.JwtUtil;
import com.mrChill.Relax.security.UserPrincipal;
import com.mrChill.Relax.serviceBase.UserService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
import java.util.HashMap;
import java.util.Map;

@Controller// đánh dấu nó là 1 controller
public class HomeController {
    
    @Autowired
    private JwtUtil jwtUtil;

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
    UserService userBaseService;

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
        model.addAttribute("userRegistrationDto");
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
    public String register(@ModelAttribute @Valid Users users, BindingResult result, RedirectAttributes model) {
        if (result.hasErrors()) {
            return "signup";
        }

        try {

            // Check if passwords match
            if (!users.getPassword().equals(users.getRePassword())) {
                model.addFlashAttribute("message", "Mật khẩu không khớp!!!");
                return "redirect:/signup";
            }

            // Encode the user's password
            users.setPassword(new BCryptPasswordEncoder().encode(users.getPassword()));
            users.setRePassword(users.getPassword());


            // Check if the username already exists
            if (ur.existsByUserName(users.getUserName())) {
                model.addFlashAttribute("message", "Tên tài khoản đã tồn tại!!!");
                return "redirect:/signup";
            }

            // Check if the email already exists
            if (ur.existsByEmail(users.getEmail())) {
                model.addFlashAttribute("message", "Email đã tồn tại!!!");
                return "redirect:/signup";
            }

            // Check if the phone number already exists
            if (ur.existsByPhone(users.getPhone())) {
                model.addFlashAttribute("message", "Số điện thoại đã tồn tại!!!");
                return "redirect:/signup";
            }

            // Create the user
            userBaseService.createUser(users);

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

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @RequestMapping("user/home")
    public String statisticsPage (Model model) throws ParseException {
        return "/user/home";
    }

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @GetMapping("/userInfo")
    public ResponseEntity<Map<String, Object>> getUserInfo(@RequestHeader("Authorization") String token, Model model) throws ParseException {
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2023-01-01");
        Date endDate = java.util.Calendar.getInstance().getTime();

        // Kiểm tra và loại bỏ tiền tố "Token "
        if (token != null && token.startsWith("Token ")) {
            token = token.substring(6);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Invalid token"));
        }

        // Lấy userId từ JWT
        Integer userId = jwtUtil.getUserIdFromJWT(token);
        if (userId == null) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "User ID not found"));
        }

        // Lấy thông tin người dùng bằng UserId
        Users users = ur.findByUserId(userId);
        if (users == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "User ID not found"));
        }
        String userName = users.getUserName();

        Map<String, Object> response = new HashMap<>();
        response.put("sumTotalVNUser", os.sumTotalVNUser(userName, startDate, endDate));
        response.put("sumTotalCancelVNUser", os.sumTotalCancelVNUser(userName, startDate, endDate));
        response.put("sumTotalFreightUser", wbs.sumTotalFreightUser(userName, startDate, endDate));
        response.put("sumAmountUser", cms.sumAmountUser(users.getUserId(), startDate, endDate));
        response.put("sumReFundVNUser", is.sumReFundVNUser(userName, startDate, endDate));
        response.put("loginUser", users);
        response.put("countCartItem", is.countCartItem(userName));
        response.put("countPendingOrder", is.countPendingItem(userName));
        response.put("countBoughtOrder", os.countBoughtOrder(userName));
        response.put("countDeliveredOrder", os.countDeliveredOrder(userName));
        response.put("countArriveredOrder", os.countArriveredOrder(userName));
        response.put("countFinishedOrder", os.countFinishedOrder(userName));
        response.put("countCancelOrder", os.countCancelOrder(userName));
        response.put("countComplainOrder", os.countComplainOrder(userName));
        response.put("countWholeOrder", os.countWholeOrder(userName));
        response.put("countCancelItem", is.countCancelItem(userName));

        return ResponseEntity.ok(response);
    }


    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
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

    // DuongDx
    @GetMapping("/userRedirection")
    public String userRedirection(@RequestHeader("Authorization") String token) {
        if (token != null && token.startsWith("Token ")) {
            token = token.substring(6); // Loại bỏ tiền tố "Bearer "
        } else {
            return "Token is missing or invalid";
        }
        Integer user = jwtUtil.getUserIdFromJWT(token);

        if (user == null) {
            return "User not found";
        }

        return "userRedirection";
    }
}