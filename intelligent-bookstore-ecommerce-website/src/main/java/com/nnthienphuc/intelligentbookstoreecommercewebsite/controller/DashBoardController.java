package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.OrderService;

@Controller
@RequestMapping("/admin")
public class DashBoardController {

    @Autowired
    private OrderService orderService;

 

        @GetMapping("/dashboard")  // URL pattern: /admin/orders
        public String listOrders(Model model) {
            // Logic xử lý
            return "admin/dashboard";  // Tên template
        }
   
}