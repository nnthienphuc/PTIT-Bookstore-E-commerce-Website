package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    public String showPromotionPage(Model model) {
        // Lấy danh sách categories
        List<Promotion> promotions = PromotionService.getAllPromotions();
        
        // Thêm dữ liệu vào model để truyền xuống view
        model.addAttribute("promotions", promotions);
        
        // Thêm một Promotion mới trống để dùng cho form thêm mới
        model.addAttribute("newPromotion", new Promotion());

        return "admin/promotion"; // Trả về tên view
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
    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<Promotion>> searchCategories(@RequestParam(required = false) String keyword) {
        try {
            List<Promotion> results = PromotionService.searchByKeyword(keyword);
            return ResponseEntity.ok(results);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}