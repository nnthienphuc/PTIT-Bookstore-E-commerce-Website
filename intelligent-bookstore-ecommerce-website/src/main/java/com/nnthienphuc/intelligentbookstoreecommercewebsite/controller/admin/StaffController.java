package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import java.util.Optional;

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

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Staff;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.OrderService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.StaffService;

@Controller
@RequestMapping("/admin/employee")
public class StaffController {

    @Autowired
    private StaffService StaffService;

    @GetMapping("")
    public String showStaffs(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        try {
            Page<Staff> StaffPage = StaffService.searchStaffs(keyword, PageRequest.of(page, size));
            model.addAttribute("staffs", StaffPage);
            model.addAttribute("keyword", keyword);
            
            return "admin/Employee";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @GetMapping("/{id}")
    @ResponseBody
    public Staff getStaffById(@PathVariable String id) {
        return StaffService.getStaffById(id);
    }

    @PostMapping("/delete/{id}")
    public String deleteStaff(@PathVariable String id) {
        StaffService.deleteStaff(id);
        return "redirect:/admin/employee";
    }

    @PostMapping("/edit")
    public String editStaff(@ModelAttribute Staff Staff, RedirectAttributes redirectAttributes) {
        try {
            StaffService.saveStaff(Staff);
            redirectAttributes.addFlashAttribute("success", "edit");
            return "redirect:/admin/employee";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "edit");
            return "redirect:/admin/employee";
        }
    }
    @PostMapping("/ban/{id}")
    public String banStaff(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
        	Staff Staff = StaffService.getStaffById(id);  
        	Staff.setIsActive(!Staff.getIsActive());
            StaffService.saveStaff(Staff);
            redirectAttributes.addFlashAttribute("success", "edit");
            return "redirect:/admin/employee";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "edit");
            return "redirect:/admin/employee";
        }
    }
}