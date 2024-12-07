package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Map;

@Controller
@RequestMapping("/admin/dashboard")
public class DashBoardController {
    @Autowired
    private OrderService orderService;

    @GetMapping
    public String showRevenueStatistics(Model model) {
        // Tổng quan thống kê
        Map<String, Long> orderStatusCounts = orderService.getOrderCountByStatus();
        BigDecimal todayRevenue = calculateTodayRevenue();
        BigDecimal thisMonthRevenue = calculateMonthlyRevenue();
        BigDecimal thisYearRevenue = calculateYearlyRevenue();

        // Điền dữ liệu vào model
        model.addAttribute("todayRevenue", formatCurrency(todayRevenue));
        model.addAttribute("monthRevenue", formatCurrency(thisMonthRevenue));
        model.addAttribute("yearRevenue", formatCurrency(thisYearRevenue));
        model.addAttribute("totalOrders", orderStatusCounts.values().stream().mapToLong(Long::longValue).sum());

        // Dữ liệu cho biểu đồ tròn đơn hàng
        model.addAttribute("orderStatusCounts", orderStatusCounts);

        return "admin/dashboard";
    }

    private BigDecimal calculateTodayRevenue() {
        LocalDate today = LocalDate.now();
        // Implement logic to calculate today's revenue from orders
        return orderService.calculateRevenueByDate(today);
    }

    private BigDecimal calculateMonthlyRevenue() {
        LocalDate firstDayOfMonth = LocalDate.now().withDayOfMonth(1);
        LocalDate lastDayOfMonth = LocalDate.now().plusMonths(1).withDayOfMonth(1).minusDays(1);
        return orderService.calculateRevenueByDateRange(firstDayOfMonth, lastDayOfMonth);
    }

    private BigDecimal calculateYearlyRevenue() {
        LocalDate firstDayOfYear = LocalDate.now().withDayOfYear(1);
        LocalDate lastDayOfYear = LocalDate.now().withDayOfYear(LocalDate.now().lengthOfYear());
        return orderService.calculateRevenueByDateRange(firstDayOfYear, lastDayOfYear);
    }

    private String formatCurrency(BigDecimal amount) {
        // Format số tiền theo định dạng Việt Nam
        return String.format("%,.0f ₫", amount.doubleValue());
    }
}
