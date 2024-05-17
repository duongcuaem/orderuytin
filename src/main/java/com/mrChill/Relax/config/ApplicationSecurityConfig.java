package com.mrChill.Relax.config;

import com.mrChill.Relax.Repository.UsersRepository;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.config.annotation.web.configurers.FormLoginConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
@Configuration
public class ApplicationSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UsersRepository ur;
    @Autowired
    DataSource ds;
    @Autowired
    private handler successHandler;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
                .dataSource(ds)
                .usersByUsernameQuery("select phone,password,STATUS from users where phone = ?")
                .authoritiesByUsernameQuery("select phone,role from users where phone = ?");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        ((HttpSecurity)((HttpSecurity)((FormLoginConfigurer)((FormLoginConfigurer)((FormLoginConfigurer)((HttpSecurity)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((ExpressionUrlAuthorizationConfigurer.AuthorizedUrl)((HttpSecurity)
                http.csrf().disable().authorizeRequests()
                .antMatchers("/backend/**").hasAnyRole("ADMIN")
                .antMatchers("/user/**").hasAnyRole("USER")
                .antMatchers("/updateRefundItem/**","/updateCancelItem/**","/complainItem","/confirmSuccessOrder/**","/submitComplainOrder/**","/order","/item/**","/cancelItem","/order/**","/pendingOrder/**","/boughtOrder/**","/deleveriedOrder/**","/arriveredOrder/**","/complainOrder/**","/finishedOrder/**","/cancelOrder/**","/cancelItem/**","/addItemToCart","/image/item/**","/signup","/rateApi").permitAll()
                .antMatchers("/order/**","/waybill/**","/statistics/**","/userCurrent/**").permitAll()
                .antMatchers("/cart/**","/addCart").permitAll()
                .antMatchers("/createAccount").permitAll()
                .antMatchers("/userNames").permitAll()
                .antMatchers("/findOrder/**").permitAll()
                .antMatchers("/users").permitAll()
                .antMatchers("/createItem").permitAll()
                .antMatchers("/finishedOrder").permitAll()
                .antMatchers("/fixOrder").permitAll()
                .antMatchers("/complainOrder").permitAll()
                .antMatchers("/pendingOrder").permitAll()
                .antMatchers("/baogia").permitAll()
                .antMatchers("/notification").permitAll()
                .antMatchers("/policies").permitAll()
                .antMatchers("/policies/complain").permitAll()
                .antMatchers("/policies/rules").permitAll()
                .antMatchers("/instructions").permitAll()
                .antMatchers("/news").permitAll()
                .antMatchers("/asset/gdqc/assets/css/core/bootstrap.min.css").permitAll()
                .antMatchers("/css/style.min.cs").permitAll()
                .antMatchers("/img/svg/logo.svg").permitAll()
                .antMatchers("/asset/gdqc/assets/js/core/jquery.min.js").permitAll()
                .antMatchers("/asset/gdqc/assets/js/core/bootstrap.min.js").permitAll()
                .antMatchers("/asset/frontend/css/index_01.css").permitAll()
                .antMatchers("/orderuytin/banner.jpg").permitAll()
                .antMatchers("/orderuytin/banner1.jpg").permitAll()
                .antMatchers("/orderuytin/banner2.jpg").permitAll()
                .antMatchers("/orderuytin/orderuytin.jpg").permitAll()
                .antMatchers("/orderuytin/policies.png").permitAll()
                .antMatchers("/home").permitAll()
                .antMatchers("/create").permitAll()
                .antMatchers("/").permitAll()
                .antMatchers("/loginFailed").permitAll()
                .anyRequest().authenticated()
                .and().formLogin()
                .successHandler(successHandler)
                .loginPage("/doLogin")
                .loginProcessingUrl("/authenticateUser").permitAll()
                .and()
                .logout().permitAll()
                .and()
                .exceptionHandling()
                .accessDeniedPage("/access-denied");
        http.rememberMe().key("uniqueAndSecret").tokenValiditySeconds(1296000);
    }
}

