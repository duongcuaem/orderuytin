package com.mrChill.Relax.Controller.Shop;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.mrChill.Relax.Service.shop.ProductService;
import com.mrChill.Relax.entities.shop.Product;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CartController {
    @Autowired
    private ProductService productService;

    @PostMapping("/add-to-cart")
    public String addToCart(Long productId, HttpSession session) {
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        Product product = productService.getProductById(productId);
        cart.add(product);
        session.setAttribute("cart", cart);
        return "redirect:/products";
    }

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        model.addAttribute("cart", cart);
        return "cart";
    }
}
