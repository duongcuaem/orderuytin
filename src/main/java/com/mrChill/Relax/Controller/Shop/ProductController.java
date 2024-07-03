package com.mrChill.Relax.Controller.Shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mrChill.Relax.Service.UsersService;
import com.mrChill.Relax.Service.shop.ProductService;
import com.mrChill.Relax.entities.shop.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/shop")
public class ProductController {
    @Autowired
    private ProductService productService;

    @Autowired
    private UsersService us;

    @GetMapping("/products")
    public String getAllProducts(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("loginUser", us.currentLoginUser());
        model.addAttribute("products", products);
        return "user/shop/products";
    }

    @GetMapping("/product/{id}")
    public String getProductById(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "product";
    }

    @PostMapping("/add-to-cart")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody Map<String, Object> payload, HttpSession session) {
        Long productId = Long.valueOf(payload.get("productId").toString());
        String name = payload.get("name").toString();
        Double price = Double.valueOf(payload.get("price").toString());
        Integer quantity = Integer.valueOf(payload.get("quantity").toString());
        String image = payload.get("image").toString();

        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Logic để thêm sản phẩm vào giỏ hàng
        Map<String, Object> product = new HashMap<>();
        product.put("productId", productId);
        product.put("name", name);
        product.put("price", price);
        product.put("quantity", 1);
        product.put("image", image);
        cart.add(product);

        session.setAttribute("cart", cart);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/get-cart")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCart(HttpSession session) {
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        Map<String, Object> response = new HashMap<>();
        response.put("cart", cart);
        return ResponseEntity.ok(response);
    }

     @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        double total = cart.stream().mapToDouble(item -> (double) item.get("price") * (int) item.get("quantity")).sum();
        model.addAttribute("user", us.currentLoginUser());
        model.addAttribute("cart", cart);
        model.addAttribute("total", total);

        return "user/shop/checkout";
    }

    @PostMapping("/complete-checkout")
    public String completeCheckout(HttpSession session, @RequestParam Map<String, String> formData) {
        // Process the payment and complete the order

        // Clear the cart
        session.removeAttribute("cart");

        return "redirect:/shop/thank-you";
    }

    @GetMapping("/thank-you")
    public String thankYou() {
        return "user/shop/thank-you";
    }
}
