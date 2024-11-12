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

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Publisher;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.PublisherService;

@Controller
@RequestMapping("/admin/publisher")
public class PublisherController {

    @Autowired
    private PublisherService PublisherService; // Giả sử bạn có PublisherService

    @GetMapping("")
    public String showPublisherPage(Model model) {
        // Lấy danh sách categories
        List<Publisher> publishers = PublisherService.getAllPublishers();
        
        // Thêm dữ liệu vào model để truyền xuống view
        model.addAttribute("publishers", publishers);
        
        // Thêm một Publisher mới trống để dùng cho form thêm mới
        model.addAttribute("newPublisher", new Publisher());

        return "admin/Publisher"; // Trả về tên view
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
    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<Publisher>> searchCategories(@RequestParam(required = false) String keyword) {
        try {
            List<Publisher> results = PublisherService.searchByKeyword(keyword);
            return ResponseEntity.ok(results);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}