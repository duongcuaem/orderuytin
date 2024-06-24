package com.mrChill.Relax.Controller.Manager;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.entities.Users;
import com.mrChill.Relax.entity.Token;

import com.mrChill.Relax.security.JwtUtil;
import com.mrChill.Relax.security.UserPrincipal;
import com.mrChill.Relax.serviceBase.TokenService;
import com.mrChill.Relax.serviceBase.UserService;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;

@RestController
@RequestMapping("/api")
public class ManagerController {

    @Autowired
    private TokenService tokenService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserService userService;

    @Autowired
    private UsersRepository usersRepository;

    @PostMapping("/loginUser")
    public ResponseEntity<?> login(@RequestBody @Valid Users user, HttpServletRequest request) {
        UserPrincipal userPrincipal = userService.findByUserName(user.getUserName());
        if (userPrincipal == null) {
            userPrincipal = userService.findByPhone(user.getUserName());
            if (userPrincipal == null) {
                userPrincipal = userService.findByEmail(user.getUserName());
            }
        }

        if (null == userPrincipal || !new BCryptPasswordEncoder().matches(user.getPassword(), userPrincipal.getPassword())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "Tài khoản hoặc mật khẩu không chính xác"));
        }
        Token token = new Token();
        token.setToken(jwtUtil.generateToken(userPrincipal));
        token.setTokenExpDate(jwtUtil.generateExpirationDate());
        token.setCreatedBy(userPrincipal.getUserId());

        Set<GrantedAuthority> authorities = new HashSet<>(userPrincipal.getAuthorities());

        String redirectUrl = "/home"; // Default redirect URL

        for (GrantedAuthority authority : authorities) {
            if (authority.getAuthority().equals("ROLE_ADMIN")) {
                redirectUrl = "/backend/home";
                break;
            } else if (authority.getAuthority().equals("ROLE_USER")) {
                redirectUrl = "/user/home";
                break;
            }
        }

        // Kiểm tra xem token có tồn tại không
        if (tokenService.findByToken(token.getToken()) == null) {
            tokenService.createToken(token);

            // Lưu token vào SecurityContextHolder
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userPrincipal, null, authorities);
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authentication);

            return ResponseEntity.ok(Map.of("success", true, "token", token.getToken(), "url", redirectUrl));
        }
        // Lưu thông tin người dùng vào SecurityContextHolder
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userPrincipal, null, userPrincipal.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);
        // Nếu token đã tồn tại trả về luôn
        return ResponseEntity.ok(Map.of("success", true, "token", token.getToken(), "url", redirectUrl));
    }

    // @PostMapping("/register")
    // public Users register(@RequestBody Users user) {
    //     user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
    //     return userService.createUser(user);
    // }

    @GetMapping("/me")
    public Users me(@RequestHeader("Authorization") String token) {
        // Kiểm tra và loại bỏ tiền tố "Token "
        if (token != null && token.startsWith("Token ")) {
            token = token.substring(6);
        } 

        Integer userId = jwtUtil.getUserIdFromJWT(token);

        return usersRepository.findByUserId(userId);

    }

    @PostMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
