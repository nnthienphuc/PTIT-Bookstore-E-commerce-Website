package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category.CategoryEntity;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;

@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService; // Giả sử bạn có CategoryService

    @GetMapping("")
    public String showCategoryPage(Model model) {
        // Lấy danh sách categories
        List<CategoryEntity> categories = categoryService.getAllCategories();
        
        // Thêm dữ liệu vào model để truyền xuống view
        model.addAttribute("categories", categories);
        
        // Thêm một category mới trống để dùng cho form thêm mới
        model.addAttribute("newCategory", new CategoryEntity());

        return "admin/Category"; // Trả về tên view
    }
    @GetMapping("/{id}")
    @ResponseBody
    public CategoryEntity getCategoryById(@PathVariable Long id) {
        return categoryService.getCategoryById(id);
    }
    @PostMapping("/add")
    public String addCategory(@ModelAttribute CategoryEntity category, RedirectAttributes redirectAttributes) {
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
    public String editCategory(@ModelAttribute CategoryEntity category, RedirectAttributes redirectAttributes) {
        try {
            categoryService.saveCategory(category);
            redirectAttributes.addAttribute("success", "edit");
            return "redirect:/admin/category";
        } catch (Exception e) {
            redirectAttributes.addAttribute("error", "edit");
            return "redirect:/admin/category";
        }
    }
    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<CategoryEntity>> searchCategories(@RequestParam(required = false) String keyword) {
        try {
            List<CategoryEntity> results = categoryService.searchByKeyword(keyword);
            return ResponseEntity.ok(results);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}