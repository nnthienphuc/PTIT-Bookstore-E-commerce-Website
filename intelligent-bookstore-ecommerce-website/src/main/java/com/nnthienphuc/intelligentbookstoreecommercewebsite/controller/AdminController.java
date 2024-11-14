package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {
    @RequestMapping("account/login")
    public String adminLoginForm() {
        return "admin/account/login";
    }

    @RequestMapping("account/register")
    public String adminRegisterForm() {
        return "admin/account/register";
    }
}
