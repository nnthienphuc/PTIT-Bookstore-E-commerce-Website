package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;

@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService; // Giả sử bạn có CategoryService

    @GetMapping("")
    public String showCategories(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        try {
            Page<Category> categoryPage;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm có phân trang
            	categoryPage = categoryService.searchCategories(keyword.trim(), PageRequest.of(page, size));
            } else {
                // Lấy tất cả có phân trang
            	categoryPage = categoryService.getAllCategories(PageRequest.of(page, size));
            }
            
            model.addAttribute("categories", categoryPage);
            model.addAttribute("keyword", keyword);
            
            return "admin/category";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @GetMapping("/{id}")
    @ResponseBody
    public Category getCategoryById(@PathVariable Long id) {
        return categoryService.getCategoryById(id);
    }
    @PostMapping("/add")
    public String addCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        try {
            categoryService.saveCategory(category);
            // Thêm thông báo thành công
            redirectAttributes.addAttribute("success", "add");
            return "redirect:/admin/category";
        } catch (Exception e) {
            // Thêm thông báo thất bại
            redirectAttributes.addAttribute("error", "add");
            return "redirect:/admin/category";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteCategory(@PathVariable Long id) {
        categoryService.deleteCategory(id);
        return "redirect:/admin/category";
    }

    @PostMapping("/edit")
    public String editCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        try {
            categoryService.saveCategory(category);
            redirectAttributes.addAttribute("success", "edit");
            return "redirect:/admin/category";
        } catch (Exception e) {
            redirectAttributes.addAttribute("error", "edit");
            return "redirect:/admin/category";
        }
    }
    
}