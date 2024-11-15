//package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;
//
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Book;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Author;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.User;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.repository.UserRepository;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.BookService;
//import jakarta.mail.MessagingException;
//import org.hibernate.validator.constraints.NotEmpty;
//import org.springframework.ui.Model;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Category;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.AuthorService;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CategoryService;
//import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CookieService;
//import jakarta.persistence.EntityManager;
//import org.springframework.validation.BindingResult;
//import org.springframework.validation.annotation.Validated;
//import org.springframework.web.bind.annotation.*;
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpSession;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.stereotype.Controller;
//
//import java.io.IOException;
//import java.util.List;
//import java.util.Optional;
//
//@RequestMapping("/user")
//@Controller
//public class UserController {
//    @Autowired
//    UserRepository userRepository;
//
//    @Autowired
//    EntityManager entityManager;
//
//    @Autowired
//    CategoryService categoryService;
//
//    @Autowired
//    AuthorService authorService;
//
//    @Autowired
//    BookService bookService;
//
//    @Autowired
//    HttpSession session;
//
//    @Autowired
//    CookieService cookie;
//
//    // GET request để hiển thị form đăng nhập và điền sẵn thông tin người dùng (nếu có)
//    @GetMapping("account/login")
//    public String login(Model model) {
//        Cookie ckid = cookie.read("userid");
//        Cookie ckpw = cookie.read("pass");
//        if (ckid != null) {
//            String uid = ckid.getValue();
//            String pwd = ckpw.getValue();
//            model.addAttribute("uid", uid);
//            model.addAttribute("pwd", pwd);
//        }
//        return "user/account/login";
//    }
//
//    @PostMapping("/account/login")
//    public String login(Model model,
//                        @RequestParam("id") @NotEmpty(message = "Username is required!") String id,
//                        @RequestParam("pwd") @NotEmpty(message = "Password is required!") String pwd,
//                        @RequestParam(value = "rm", defaultValue = "false") boolean rm) {
//
//        if (id.isEmpty() || pwd.isEmpty()) {
//            model.addAttribute("message", "Password, Username is not null!");
//            return "user/account/login";  // Trả về trang login nếu thiếu thông tin
//        }
//
//        // Kiểm tra người dùng từ cơ sở dữ liệu
//        Optional<User> user = userRepository.findById(id);
//        if (user.isEmpty()) {
//            model.addAttribute("message", "Invalid username!");
//            return "user/account/login";  // Trả về thông báo lỗi nếu không tìm thấy người dùng
//        } else if (!pwd.equals(user.get().getPwd())) {
//            model.addAttribute("message", "Invalid password!");
//            return "user/account/login";  // Trả về thông báo lỗi nếu mật khẩu không khớp
//        } else if (!user.get().getIsActive()) {
//            model.addAttribute("message", "Your account is Inactivated!");
//            return "user/account/login";  // Trả về thông báo nếu tài khoản chưa kích hoạt
//        }
//
//        // Đăng nhập thành công
//        model.addAttribute("message", "Login successfully!");
//        session.setAttribute("user", user);
//
//        // Ghi nhớ tài khoản nếu checkbox "remember me" được chọn
//        if (rm) {
//            cookie.create("userid", user.get().getUserId(), 30);  // Ghi nhớ user ID
//            cookie.create("pass", user.get().getPwd(), 30);  // Ghi nhớ mật khẩu
//        } else {
//            cookie.delete("userid");
//            cookie.delete("pass");
//        }
//
//        // Nếu có URL quay lại trước đó, chuyển hướng đến URL đó
//        String backUrl = (String) session.getAttribute("back-url");
//        if (backUrl != null) {
//            return "redirect:" + backUrl;  // Quay lại trang trước đó
//        }
//
//        return "user/account/success";  // Trả về trang thành công
//    }
//
////    @RequestMapping("/account/register")
////    public String register(Model model) {
////        User user = new User();
////        model.addAttribute("user", user);
////        return "user/account/register";
////    }
//
////    @PostMapping("/account/register")
////    public String register(Model model, @Validated @ModelAttribute("form"), User user, BindingResult error) throws IllegalStateException, IOException, MessagingException {
////        if(error.hasErrors()) {
////            model.addAttribute("message", "Please fill all the required fields!");
////            return "user/account/register";
////        }
////        else {
////            user.setIsActive(false);
////            user.create(user)
////        }
////    }
//
//    @RequestMapping("/account/logoff")
//    public String logoff(Model model) {
//        session.removeAttribute("user");
//        session.removeAttribute("back-url");
//
//        return "redirect:/home/";
//    }
//
//    @GetMapping("/home")
//    public String home(
//            @RequestParam(value = "keyword", required = false) String keyword,
//            @RequestParam(value = "authorId", required = false) Long authorId,
//            @RequestParam(value = "categoryId", required = false) Long categoryId,
//            @RequestParam(defaultValue = "0") int page,
//            @RequestParam(defaultValue = "8") int size,
//            Model model) {
//        
//        try {
//            Page<Book> bookPage;
//            
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                bookPage = bookService.searchBooks(keyword.trim(), PageRequest.of(page, size));
//            } else if (authorId != null) {
//                bookPage = bookService.findByAuthor_id(authorId, PageRequest.of(page, size));
//            } else if (categoryId != null) {
//                bookPage = bookService.findByCategory_id(categoryId, PageRequest.of(page, size));
//            } else {
//                bookPage = bookService.getAllBooksPaged(PageRequest.of(page, size));
//            }
//
//            List<Author> authors = authorService.getAllAuthors();
//            List<Category> categories = categoryService.getAllCategories();
//
//            model.addAttribute("books", bookPage.getContent());
//            model.addAttribute("currentPage", page);
//            model.addAttribute("totalPages", bookPage.getTotalPages());
//            model.addAttribute("totalItems", bookPage.getTotalElements());
//            model.addAttribute("keyword", keyword);
//            model.addAttribute("authors", authors);
//            model.addAttribute("categories", categories);
//            model.addAttribute("selectedAuthorId", authorId);
//            model.addAttribute("selectedCategoryId", categoryId);
//            
//            return "user/home";
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "error";
//        }
//    }
//
//    @RequestMapping("/bookdetail/{id}")
//    public String home(Model model, @PathVariable("id") String id) {
//        Book book = bookService.getBookById(id);
//        model.addAttribute("book", book);
//
//        return "user/bookDetail";
//    }
//}
