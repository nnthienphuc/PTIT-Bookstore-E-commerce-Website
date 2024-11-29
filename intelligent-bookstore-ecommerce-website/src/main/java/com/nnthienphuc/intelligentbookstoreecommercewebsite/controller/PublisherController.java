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
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Publisher;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.PublisherService;

@Controller
@RequestMapping("/admin/publisher")
public class PublisherController {

    @Autowired
    private PublisherService PublisherService; // Giả sử bạn có PublisherService

    @GetMapping("")
    public String showPublishers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        try {
            Page<Publisher> publisherPage;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm có phân trang
                publisherPage = PublisherService.searchPublishers(keyword.trim(), PageRequest.of(page, size));
            } else {
                // Lấy tất cả có phân trang
            	publisherPage = PublisherService.getAllPublishers(PageRequest.of(page, size));
            }
            
            model.addAttribute("publishers", publisherPage);
            model.addAttribute("keyword", keyword);
            
            return "admin/publisher";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    @GetMapping("/{id}")
    @ResponseBody
    public Publisher getPublisherById(@PathVariable Long id) {
        return PublisherService.getPublisherById(id);
    }
    @PostMapping("/add")
    public String addPublisher(@ModelAttribute Publisher Publisher, RedirectAttributes redirectAttributes) {
        try {
            PublisherService.savePublisher(Publisher);
            // Thêm thông báo thành công
            redirectAttributes.addAttribute("success", "add");
            return "redirect:/admin/publisher";
        } catch (Exception e) {
            // Thêm thông báo thất bại
            redirectAttributes.addAttribute("error", "add");
            return "redirect:/admin/publisher";
        }
    }

    @PostMapping("/delete/{id}")
    public String deletePublisher(@PathVariable Long id) {
        PublisherService.deletePublisher(id);
        return "redirect:/admin/publisher";
    }

    @PostMapping("/edit")
    public String editPublisher(@ModelAttribute Publisher Publisher, RedirectAttributes redirectAttributes) {
        try {
            PublisherService.savePublisher(Publisher);
            redirectAttributes.addAttribute("success", "edit");
            return "redirect:/admin/publisher";
        } catch (Exception e) {
            redirectAttributes.addAttribute("error", "edit");
            return "redirect:/admin/publisher";
        }
    }
    
}