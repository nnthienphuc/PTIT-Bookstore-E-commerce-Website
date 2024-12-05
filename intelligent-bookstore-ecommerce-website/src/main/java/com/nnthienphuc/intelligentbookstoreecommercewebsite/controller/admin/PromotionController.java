package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Promotion;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.PromotionService;

@Controller
@RequestMapping("/admin/promotion")
public class PromotionController {

    @Autowired
    private PromotionService PromotionService; // Giả sử bạn có PromotionService

    @GetMapping("")
    public String showPromotions(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        try {
            Page<Promotion> promotionPage;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm có phân trang
                promotionPage = PromotionService.searchPromotions(keyword.trim(), PageRequest.of(page, size));
            } else {
                // Lấy tất cả có phân trang
            	promotionPage = PromotionService.getAllPromotions(PageRequest.of(page, size));
            }
            
            model.addAttribute("promotions", promotionPage);
            model.addAttribute("keyword", keyword);
            
            return "admin/promotion";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @GetMapping("/{id}")
    @ResponseBody
    public Promotion getPromotionById(@PathVariable Long id) {
        return PromotionService.getPromotionById(id);
    }
    @PostMapping("/add")
    public String addPromotion(@ModelAttribute Promotion Promotion, RedirectAttributes redirectAttributes) {
        try {
            PromotionService.savePromotion(Promotion);
            // Thêm thông báo thành công
            redirectAttributes.addAttribute("success", "add");
            return "redirect:/admin/promotion";
        } catch (Exception e) {
            // Thêm thông báo thất bại
            redirectAttributes.addAttribute("error", "add");
            return "redirect:/admin/promotion";
        }
    }

    @PostMapping("/delete/{id}")
    public String deletePromotion(@PathVariable Long id) {
        PromotionService.deletePromotion(id);
        return "redirect:/admin/promotion";
    }

    @PostMapping("/edit")
    public String editPromotion(@ModelAttribute Promotion Promotion, RedirectAttributes redirectAttributes) {
        try {
            PromotionService.savePromotion(Promotion);
            redirectAttributes.addAttribute("success", "edit");
            return "redirect:/admin/promotion";
        } catch (Exception e) {
            redirectAttributes.addAttribute("error", "edit");
            return "redirect:/admin/promotion";
        }
    }
    
}