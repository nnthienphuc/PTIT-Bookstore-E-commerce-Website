package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.BookService;
import org.springframework.ui.Model;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CookieService;
import jakarta.persistence.EntityManager;
import org.springframework.web.bind.annotation.ModelAttribute;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/user")
@Controller
public class UserController {
    @Autowired
    EntityManager entityManager;
    @Autowired
    CategoryService categoryService;
    @Autowired
    BookService bookService;

    @Autowired
    HttpSession session;

    @Autowired
    CookieService cookieService;

    @RequestMapping ("/login")
    public String userLoginForm() {
        return "user/login";
    }

    @RequestMapping("/register")
    public String userRegisterForm() {
        return "user/register";
    }

    @RequestMapping("/home")
    public String home(Model model) {
        List<Category> cates = categoryService.getAllCategories();
        model.addAttribute("cates", cates);
        List<Book> books = bookService.getAllBook();
        model.addAttribute("books", books);
        for (Book book : books) {
            System.out.println(book.getTitle());
        }
    return "user/home";
    }

    @RequestMapping("/bookdetail/{id}")
    public String home(Model model, @PathVariable("id") String id) {
        Book book = bookService.getBookById(id);
        model.addAttribute("book", book);

        return "user/bookDetail";
    }
}
