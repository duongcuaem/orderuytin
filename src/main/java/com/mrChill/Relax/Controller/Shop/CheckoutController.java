package com.mrChill.Relax.Controller.Shop;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;

@Controller
public class CheckoutController {

    @PostMapping("/checkout")
    public String checkout(HttpSession session) {
        // Logic xử lý thanh toán
        session.removeAttribute("cart");
        return "redirect:/products";
    }
}
