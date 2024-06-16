package com.mrChill.Relax.security;

import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.config.handler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@EnableWebSecurity
@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Autowired
    private JwtRequestFilter jwtRequestFilter;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private handler successHandler;

    @Autowired
    UsersRepository ur;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
            .authorizeRequests(authorizeRequests -> 
                authorizeRequests
                    .mvcMatchers("/", "/ws/**", "/app/**", "/login/**", "/api/loginUser").permitAll()
                    .antMatchers("/backend/**").hasRole("ADMIN")
                    .antMatchers("/user/**").hasRole("USER")
                    .antMatchers(
                        "/updateRefundItem/**", "/updateCancelItem/**", "/complainItem", "/confirmSuccessOrder/**", 
                        "/submitComplainOrder/**", "/order", "/item/**", "/cancelItem", "/order/**", "/pendingOrder/**", 
                        "/boughtOrder/**", "/deleveriedOrder/**", "/arriveredOrder/**", "/complainOrder/**", "/finishedOrder/**", 
                        "/cancelOrder/**", "/cancelItem/**", "/addItemToCart", "/image/item/**", "/signup", "/rateApi",
                        "/order/**", "/waybill/**", "/statistics/**", "/userCurrent/**", "/cart/**", "/addCart", 
                        "/createAccount", "/userNames", "/findOrder/**", "/users", "/createItem", "/finishedOrder", 
                        "/fixOrder", "/complainOrder", "/pendingOrder", "/baogia", "/notification", "/policies", 
                        "/policies/complain", "/policies/rules", "/instructions", "/news",
                        "/asset/gdqc/assets/css/core/bootstrap.min.css", "/css/style.min.cs", "/img/svg/logo.svg",
                        "/asset/gdqc/assets/js/core/jquery.min.js", "/asset/gdqc/assets/js/core/bootstrap.min.js",
                        "/asset/frontend/css/index_01.css", "/orderuytin/banner.jpg", "/orderuytin/banner1.jpg",
                        "/orderuytin/banner2.jpg", "/orderuytin/orderuytin.jpg", "/orderuytin/policies.png",
                        "/home", "/create", "/", "/loginFailed"
                    ).permitAll()
                    .anyRequest().authenticated()
            )
            .oauth2Login(oauth2Login -> 
                oauth2Login
                    .loginPage("/login")
                    .defaultSuccessUrl("/home")
                    .userInfoEndpoint(userInfoEndpoint -> 
                        userInfoEndpoint.oidcUserService(oidcUserService()))
                    .successHandler(authenticationSuccessHandler())
                    .failureHandler(authenticationFailureHandler())
            )
            .formLogin(formLogin -> 
                formLogin
                    .loginPage("/doLogin")
                    .defaultSuccessUrl("/home")
                    .successHandler(successHandler)
                    .permitAll()
            )
            .logout(logout -> 
                logout
                    .logoutUrl("/logout")
                    .logoutSuccessHandler(logoutSuccessHandler())
                    .addLogoutHandler(logoutHandler())
            )
            .addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public OidcUserService oidcUserService() {
        return new OidcUserService();
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return new AuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                OAuth2AuthenticationToken oauth2Token = (OAuth2AuthenticationToken) authentication;
                OAuth2User oauth2User = oauth2Token.getPrincipal();
                Map<String, Object> attributes = oauth2User.getAttributes();

                // Tạo UserPrincipal và JWT từ attributes
                UserPrincipal userPrincipal = new UserPrincipal((String) attributes.get("email"), attributes);
                String jwt = jwtUtil.generateToken(userPrincipal);

                // Redirect về trang chủ với JWT trong URL
                response.sendRedirect("/loginSuccess?token=" + jwt);
            }
        };
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new AuthenticationFailureHandler() {
            @Override
            public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, org.springframework.security.core.AuthenticationException exception) throws IOException, ServletException {
                System.err.println("Authentication failed: " + exception.getMessage());
                request.setAttribute("error", exception.getMessage());
                request.getRequestDispatcher("/error").forward(request, response);
            }
        };
    }

    @Bean
    public LogoutSuccessHandler logoutSuccessHandler() {
        return new LogoutSuccessHandler() {
            @Override
            public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                // Xử lý khi logout thành công
                response.sendRedirect("/login?logout");
            }
        };
    }

    @Bean
    public LogoutHandler logoutHandler() {
        return new LogoutHandler() {
            @Override
            public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
                // Xóa JWT hoặc các thông tin xác thực khác nếu cần
                String token = request.getHeader("Authorization");
                if (token != null && token.startsWith("Bearer ")) {
                    token = token.substring(7);
                    // Xóa token hoặc làm gì đó với token
                }
                SecurityContextHolder.clearContext();
            }
        };
    }
}
