package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;


import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/user")
@Controller
public class HomeController {

    @Autowired
    CategoryService categoryService;

    @RequestMapping("/home")
    public String home(Model model) {
        List<Category> cates = categoryService.getAllCategories();
        model.addAttribute("cates", cates);
        return "home/index";
    }
}
