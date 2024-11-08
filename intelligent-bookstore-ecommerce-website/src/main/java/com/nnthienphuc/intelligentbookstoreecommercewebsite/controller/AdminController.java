package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admnin")
@Controller
public class AdminController {
    @RequestMapping("/login")
    public String adminLoginForm() {
        return "admin/login";
    }

    @RequestMapping("/login")
    public String adminRegisterForm() {
        return "admin/register";
    }
}