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

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.User;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.OrderService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.UserService;

@Controller
@RequestMapping("/admin/customer")
public class CustomerController {

    @Autowired
    private UserService userService;

    @GetMapping("")
    public String showUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        try {
            Page<User> userPage;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm có phân trang
            	userPage = userService.searchUsers(keyword.trim(), PageRequest.of(page, size));
            } else {
                // Lấy tất cả có phân trang
            	userPage = userService.getAllUsersPagging(PageRequest.of(page, size));
            }
            
            model.addAttribute("users", userPage);
            model.addAttribute("keyword", keyword);
            
            return "admin/Customer";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @GetMapping("/{id}")
    @ResponseBody
    public User getUserById(@PathVariable String id) {
        return userService.getUserById(id);
    }

    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable String id) {
        userService.deleteUser(id);
        return "redirect:/admin/customer";
    }

    @PostMapping("/edit")
    public String editUser(@ModelAttribute User User, RedirectAttributes redirectAttributes) {
        try {
            userService.saveUser(User);
            redirectAttributes.addFlashAttribute("success", "edit");
            return "redirect:/admin/customer";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "edit");
            return "redirect:/admin/customer";
        }
    }
}