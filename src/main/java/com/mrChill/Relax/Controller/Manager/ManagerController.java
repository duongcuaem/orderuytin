package com.mrChill.Relax.Controller.Manager;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrChill.Relax.entity.Token;
import com.mrChill.Relax.entity.User;
import com.mrChill.Relax.entity.UserProfile;
import com.mrChill.Relax.security.JwtUtil;
import com.mrChill.Relax.security.UserPrincipal;
import com.mrChill.Relax.serviceBase.TokenService;
import com.mrChill.Relax.serviceBase.UserBaseService;
import com.mrChill.Relax.serviceBase.UserProfileService;

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
    private UserBaseService userService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private UserProfileService userProfileService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/loginUser")
    public ResponseEntity<?> login(@RequestBody @Valid User user, HttpServletRequest request) {
        UserPrincipal userPrincipal = userService.findByUsername(user.getUsername());
        if (null == userPrincipal || !new BCryptPasswordEncoder().matches(user.getPassword(), userPrincipal.getPassword())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "Tài khoản hoặc mật khẩu không chính xác"));
        }
        Token token = new Token();
        token.setToken(jwtUtil.generateToken(userPrincipal));
        token.setTokenExpDate(jwtUtil.generateExpirationDate());
        token.setCreatedBy(userPrincipal.getUserId());
        // Kiểm tra xem token có tồn tại không
        if (tokenService.findByToken(token.getToken()) == null) {
            tokenService.createToken(token);

            // Lưu token vào SecurityContextHolder
            Set<GrantedAuthority> authorities = new HashSet<>(userPrincipal.getAuthorities());
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userPrincipal, null, authorities);
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authentication);

            return ResponseEntity.ok(Map.of("success", true, "token", token.getToken()));
        }
        // Nếu token đã tồn tại trả về luôn
        return ResponseEntity.ok(Map.of("success", true, "token", token.getToken()));
    }

    @GetMapping("/me")
    public UserProfile getCurrentUser() {
        return userProfileService.setUserProfile();
    }

    @PostMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
