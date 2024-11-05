package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloSpringBootController {
    @GetMapping("/hellonnthienphuc")
    public String hello() {
        return "Welcome nnthienphuc to Spring Boot!";
    }
}
