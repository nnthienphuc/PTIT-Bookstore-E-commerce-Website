package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {
    @RequestMapping("/login")
    public String adminLoginForm() {
        return "admin/login";
    }
//
//    @RequestMapping("/login")
//    public String adminRegisterForm() {
//        return "admin/register";
//    }
}
