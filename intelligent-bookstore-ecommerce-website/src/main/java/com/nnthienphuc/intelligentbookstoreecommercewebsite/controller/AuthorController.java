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

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.AuthorService;

@Controller
@RequestMapping("/admin/author")
public class AuthorController {

    @Autowired
    private AuthorService AuthorService; // Giả sử bạn có AuthorService

    @GetMapping("")
    public String showAuthorPage(Model model) {
        // Lấy danh sách categories
        List<Author> authors = AuthorService.getAllAuthors();
        
        // Thêm dữ liệu vào model để truyền xuống view
        model.addAttribute("authors", authors);
        
        // Thêm một Author mới trống để dùng cho form thêm mới
        model.addAttribute("newAuthor", new Author());

        return "admin/Author"; // Trả về tên view
    }
    @GetMapping("/{id}")
    @ResponseBody
    public Author getAuthorById(@PathVariable Long id) {
        return AuthorService.getAuthorById(id);
    }
    @PostMapping("/add")
    public String addAuthor(@ModelAttribute Author Author, RedirectAttributes redirectAttributes) {
        try {
            AuthorService.saveAuthor(Author);
            // Thêm thông báo thành công
            redirectAttributes.addAttribute("success", "add");
            return "redirect:/admin/author";
        } catch (Exception e) {
            // Thêm thông báo thất bại
            redirectAttributes.addAttribute("error", "add");
            return "redirect:/admin/author";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteAuthor(@PathVariable Long id) {
        AuthorService.deleteAuthor(id);
        return "redirect:/admin/author";
    }

    @PostMapping("/edit")
    public String editAuthor(@ModelAttribute Author Author, RedirectAttributes redirectAttributes) {
        try {
            AuthorService.saveAuthor(Author);
            redirectAttributes.addAttribute("success", "edit");
            return "redirect:/admin/author";
        } catch (Exception e) {
            redirectAttributes.addAttribute("error", "edit");
            return "redirect:/admin/author";
        }
    }
    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<Author>> searchCategories(@RequestParam(required = false) String keyword) {
        try {
            List<Author> results = AuthorService.searchByKeyword(keyword);
            return ResponseEntity.ok(results);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}