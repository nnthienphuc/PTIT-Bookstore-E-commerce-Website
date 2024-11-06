package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserLoginController {
    @GetMapping("/userlogin")
    public String adminLoginForm() {
        return "user/login";
    }
}
