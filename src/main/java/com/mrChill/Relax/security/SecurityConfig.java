package com.mrChill.Relax.security;

import com.mrChill.Relax.Repository.UsersRepository;
import com.mrChill.Relax.entities.Users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
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
import java.util.Collection;
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
                    .mvcMatchers("/", "/ws/**", "/user/**", "/app/**", "/login/**", "/home/**","/api/**").permitAll()
                    // .antMatchers("/backend/**").hasRole("ADMIN")
                    // .antMatchers("/user/**").hasRole("USER")
                    // .anyRequest().authenticated()
            )
            .oauth2Login(oauth2Login -> 
                oauth2Login
                    .loginPage("/doLogin")
                    .userInfoEndpoint(userInfoEndpoint -> 
                        userInfoEndpoint.oidcUserService(oidcUserService()))
                    .successHandler(authenticationSuccessHandler())
                    .failureHandler(authenticationFailureHandler())
            )
            .formLogin(formLogin -> 
                formLogin
                    .loginPage("/doLogin")
                    .successHandler(formAuthenticationSuccessHandler())                    
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
                String registrationId = oauth2Token.getAuthorizedClientRegistrationId();
                
                // Tạo UserPrincipal và JWT từ attributes
                UserPrincipal userPrincipal = new UserPrincipal((String) attributes.get("email"), attributes);
                // Kiểm tra xem tài khoản có tồn tại không 
                String email = userPrincipal.getEmail();
                Users user = ur.findByEmail(email);
                
                if (user == null) {
                    // chưa tồn tại người dùng thì sẽ tạo mới tài khoản
                    user = new Users();
                    // Kiểm tra xem là google hay mạng xã hội nào
                    if ("google".equalsIgnoreCase(registrationId)) {
                        String sub = (String) attributes.get("sub");
                        user.setSocialcode(sub);
                    }
                    if ("facebook".equalsIgnoreCase(registrationId)) {
                        String id = (String) attributes.get("id");
                        user.setSocialcode(id);
                    }
                    // Lấy giá trị của sub từ attributes
                    user.setUserName(userPrincipal.getFullName().trim());
                    user.setEmail(userPrincipal.getEmail().trim());
                    user = ur.save(user);
                    if (user != null) {
                        userPrincipal.setUserId(user.getUserId().longValue());
                    }
                } else {
                    userPrincipal.setUserId(user.getUserId().longValue());
                }
                // nếu tồn tại rồi thì lấy dữ liệu ra 
                
                String jwt = jwtUtil.generateToken(userPrincipal);
                response.sendRedirect("/loginSuccess?token=" + jwt);
            }
        };
    }


    @Bean
    public AuthenticationSuccessHandler formAuthenticationSuccessHandler() {
        return new AuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                // Kiểm tra quyền của người dùng và chuyển hướng tương ứng
                Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
                String redirectUrl = "/home"; // Default redirect URL

                for (GrantedAuthority authority : authorities) {
                    if (authority.getAuthority().equals("ROLE_ADMIN")) {
                        redirectUrl = "backend/home";
                        break;
                    } else if (authority.getAuthority().equals("ROLE_USER")) {
                        redirectUrl = "user/home";
                    }
                }

                response.sendRedirect(redirectUrl);
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
                if (token != null && token.startsWith("Token ")) {
                    token = token.substring(7);
                    // Xóa token hoặc làm gì đó với token
                }
                SecurityContextHolder.clearContext();
            }
        };
    }
}
