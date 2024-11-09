package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class HomeController {
    @RequestMapping("/home")
    public String home() {
        return "home/index";
    }
}
