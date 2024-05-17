package com.mrChill.Relax;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@SpringBootApplication
@EnableScheduling
public class OrderuytinApplication {

        public static void main(String[] args) {
            SpringApplication.run(OrderuytinApplication.class, args);
        }

//    @Bean
//    BCryptPasswordEncoder brBcryptPasswordEncoder(){
//        return new BCryptPasswordEncoder();
//    }

//    @Bean
//    CommandLineRunner run(UserService userService){
//            return args -> {
//                userService.saveRole(new Role(null,"ROLE_USER"));
//                userService.saveRole(new Role(null,"ROLE_ADMIN"));
//
//                userService.saveRole(new Role(null,"ROLE_ADMIN"));
//            };
//    }
    }

