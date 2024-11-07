package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CookieService;
import jakarta.persistence.EntityManager;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
    @Autowired
    EntityManager entityManager;

    @Autowired
    HttpSession session;

    @Autowired
    CookieService cookieService;

    @RequestMapping ("/login")
    public String userLoginForm() {
        return "user/login";
    }

    @RequestMapping("/register")
    public String userRegisterForm() {
        return "user/register";
    }
}
