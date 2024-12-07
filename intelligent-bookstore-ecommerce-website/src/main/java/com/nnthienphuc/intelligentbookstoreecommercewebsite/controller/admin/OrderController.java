package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.DTO.OrderDTO;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Order;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.OrderStatus;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.OrderService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/order")
public class OrderController {

    @Autowired
    private OrderService orderService;


        @GetMapping
        public String showOrders(
                @RequestParam(defaultValue = "0") int page,
                @RequestParam(defaultValue = "10") int size,
                @RequestParam(required = false) String keyword,
                @RequestParam(required = false) Long orderId,
                @RequestParam(required = false) String status,
                Model model) {
            
            try {
                Page<OrderDTO> orderPage;
                Map<String, Long> orderStatus = orderService.getOrderCountByStatus();
//                if (keyword != null && !keyword.trim().isEmpty()) {
//                    // Tìm kiếm có phân trang
//                	orderPage = orderService.searchOrders(orderId,keyword.trim(), status, PageRequest.of(page, size));
//                } else {
                    // Lấy tất cả có phân trang
                	orderPage = orderService.getAllOrders(PageRequest.of(page, size));
//                }
                
                model.addAttribute("orders", orderPage);
                model.addAttribute("orderStatus", orderStatus);
                model.addAttribute("keyword", keyword);
                
                return "admin/order";
                
            } catch (Exception e) {
                e.printStackTrace();
                return "error";
            }
        }
}