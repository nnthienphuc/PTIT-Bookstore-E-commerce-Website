package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.OrderService;

@Controller
@RequestMapping("/admin")
public class EmployeeController {

    @Autowired
    private OrderService orderService;

 

        @GetMapping("/employee")  // URL pattern: /admin/orders
        public String listOrders(Model model) {
            // Logic xử lý
            return "admin/employee";  // Tên template
        }
   
}