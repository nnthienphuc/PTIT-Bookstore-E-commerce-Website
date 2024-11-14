package com.nnthienphuc.intelligentbookstoreecommercewebsite.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorizeRequests ->
                        authorizeRequests
                                .antMatchers("/user/account/login", "/user/account/register").permitAll()  // Cho phép truy cập không cần đăng nhập
                                .anyRequest().authenticated()  // Các trang khác cần đăng nhập
                )
                .formLogin()
                .loginPage("/user/account/login")  // Trang đăng nhập tùy chỉnh
                .loginProcessingUrl("/user/account/login")  // URL xử lý đăng nhập
                .permitAll()
                .and()
                .logout()
                .permitAll();  // Cho phép đăng xuất không cần xác thực

        return http.build();
    }
}
