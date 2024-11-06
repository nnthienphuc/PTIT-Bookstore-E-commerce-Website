package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminLoginController {
    @GetMapping("/adminlogin")
    public String adminLoginForm() {
        return "admin/login";
    }
}
