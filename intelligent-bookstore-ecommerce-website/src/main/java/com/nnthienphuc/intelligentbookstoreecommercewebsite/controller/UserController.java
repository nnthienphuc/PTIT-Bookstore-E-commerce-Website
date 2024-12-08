package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Cart;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.User;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.MailInfo;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.*;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @Autowired
    private AuthorService authorService;

    @Autowired
    private PublisherService publisherService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private BookService bookService;

    @Autowired
    private HttpSession session;

    @Autowired
    private CookieService cookie;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private MailService mailService;

    @GetMapping("/account/login")
    public String loginForm(Model model) {
        String userId = String.valueOf(cookie.read("userid"));
        String password = String.valueOf(cookie.read("pass"));
        if (userId != null && password != null) {
            model.addAttribute("uid", userId);
            model.addAttribute("pwd", password);
        }
        return "user/account/login";
    }

    @PostMapping("/account/login")
    public String login(
            Model model,
            @RequestParam("userId") @NotEmpty(message = "Username is required!") String userId,
            @RequestParam("pwd") @NotEmpty(message = "Password is required!") String pwd,
            @RequestParam(value = "rm", defaultValue = "true") boolean rememberMe) {

        if (userId.isEmpty() || pwd.isEmpty()) {
            model.addAttribute("message", "Password, Username is not null!");
            return "redirect:/user/account/login";
        }

        Optional<User> userOptional = userService.findById(userId);
        if (userOptional.isEmpty()) {
            model.addAttribute("message", "Invalid username!");
            return "redirect:/user/account/login";
        }

        User user = userOptional.get();

        if (!passwordEncoder.matches(pwd, user.getPwd())) {
            model.addAttribute("message", "Invalid password!");
            return "redirect:/user/account/login";
        }

        if (!user.getIsActive()) {
            model.addAttribute("message", "Your account is Inactivated!");
            return "redirect:/user/account/login";
        }

        model.addAttribute("message", "Login successfully!");
        session.setAttribute("user", user);

        if (rememberMe) {
            cookie.create("userid", user.getUserId(), 30);
            cookie.create("pass", user.getPwd(), 30);
        } else {
            cookie.delete("userid");
            cookie.delete("pass");
        }

//        return (backUrl != null) ? "redirect:" + backUrl : "user/home";
        return "redirect:/user/home";
    }

    @GetMapping("/account/register")
    public String registerForm(Model model) {
        model.addAttribute("user", new User());
        return "user/account/register";
    }

    @PostMapping("/account/register")
    public String register(
            Model model,
            @ModelAttribute("user") User user,
            BindingResult error) throws Exception {

        if (error.hasErrors()) {
            model.addAttribute("message", "Please fill all the required fields!");
            return "redirect:/user/account/register";
        }

        user.setIsActive(false);  // Đặt mặc định là chưa kích hoạt
        userService.create(user);  // Lưu thông tin nhân viên vào cơ sở dữ liệu

        model.addAttribute("message", "Registration successful. Please check your email for activation.");

        String from = "phucnaoto.buildweb@gmail.com";
        String to = user.getEmail();
        String subject = "Activate Your Account!";
        String url = "http://localhost:8080/user/account/active/" + user.getUserId(); // Địa chỉ URL đầy đủ
        // Đường dẫn kích hoạt
        String body = "Click <a href='" + url + "'>here</a> to active your account.";

        MailInfo mail = new MailInfo(from, to, subject, body);
        mailService.send(mail);  // Gửi email

        return "redirect:/user/account/login";
    }

    @GetMapping("account/active/{id}")
    public String active(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
        Optional<User> user = userService.findById(id);

        if (user.isPresent()) {
            User currentUser = user.get();
            if (!currentUser.getIsActive()) {
                currentUser.setIsActive(true);
                userService.update(currentUser);
                redirectAttributes.addFlashAttribute("success", "Account activated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("info", "Account is already active!");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Account not found!");
        }

        return "redirect:/user/account/login";
    }

    @RequestMapping("/account/logout")
    public String logoff() {
        session.removeAttribute("user");
        session.removeAttribute("back-url");
        session.invalidate();
        return "redirect:/user/home";
    }

    @GetMapping("/home")
    public String home(HttpSession session,Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }
        model.addAttribute("cates", categoryService.getAllCategories());
        model.addAttribute("books", bookService.getAllBooks());
        return "user/home";
    }

    @GetMapping("/bookdetail/{id}")
    public String bookDetail(Model model, @PathVariable("id") String id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }
        model.addAttribute("book", bookService.getBookByIsbn(id));
        return "user/bookDetail";
    }
    @PostMapping("/bookDetail/{id}")
    public String bookDetail(
            @PathVariable("id") String bookId,  // Lấy {id} từ URL
            @RequestParam("quantity") short quantity,  // Lấy số lượng sách từ form
            HttpSession session, Model model) {


        // Lấy user từ session
        User user = (User) session.getAttribute("user");
        String userId = user != null ? user.getUserId() : null;
        if(cartService.isExist(userId,bookId)){

            cartService.updateCart(quantity,userId,bookId);
        }
        else{
        cartService.createCartRecord(userId,bookId,quantity);}
        model.addAttribute("book", bookService.getBookByIsbn(bookId));
        return "redirect:/user/bookdetail/" + bookId;
    }


//    @GetMapping("/search")
//    public String searchUserByName(
//            @RequestParam("name") String name,
//            Model model) {
//
//        List<User> users = userService.findByFullNameContainingIgnoreCase(name);
//        model.addAttribute("users", users);
//        return "user/searchResults";
//    }

    @GetMapping("/cart")
    public String cart(HttpSession session,Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<Cart> carts = cartService.getCartbyUserId(user.getUserId());
            model.addAttribute("user", user);
            model.addAttribute("cart", carts);
            Double bfkm = 0.0;
            for (Cart item : carts) {
                BigDecimal quantityBigDecimal = new BigDecimal(item.getQuantity());
                BigDecimal discountFactor = BigDecimal.valueOf(1 - item.getIsbn().getDiscount_percent());
                BigDecimal result = quantityBigDecimal.multiply( discountFactor.multiply(item.getIsbn().getPrice()));
                bfkm += result.doubleValue();



            }
            model.addAttribute("bfkm", bfkm);
            return "user/cart";
        }

        // Nếu không, chuyển hướng người dùng đến trang đăng nhập
        return "redirect:/user/account/login";

    }

    @PostMapping("/cart/remove/{isbn}")
    public String removeItemFromCart(@PathVariable("isbn") String isbn, HttpSession session) {
        // Lấy thông tin người dùng từ session
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // Gọi service để xóa sản phẩm khỏi giỏ
            cartService.removeItem( user.getUserId(),isbn);
            System.out.println(isbn + ' '+ user.getUserId());
        }
        return "redirect:/user/cart";  // Sau khi xóa, điều hướng lại đến giỏ hàng
    }


    @GetMapping("/booklist")
    public String booklist(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }
        model.addAttribute("cates", categoryService.getAllCategories());
        model.addAttribute("authors",authorService.getAllAuthors());
        model.addAttribute("publishers",publisherService.getAllPublishers());
        model.addAttribute("books", bookService.getAllBooks());

        return "user/booklist";
    }
    @GetMapping("/infor")
    public String infor(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }

        return "user/infor";
    }
    @GetMapping("/historyOrder")
    public String history(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập
        }

        return "user/historyOrder";
    }
    @RequestMapping("/booklist-by-category/{cid}")
    public String listByCategory(Model model, @PathVariable("cid") Integer categoryId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }
        model.addAttribute("cates", categoryService.getAllCategories());
        model.addAttribute("authors",authorService.getAllAuthors());
        model.addAttribute("publishers",publisherService.getAllPublishers());
        model.addAttribute("books", bookService.getBookByCategoryID(categoryId));
    return "user/booklist";
}
    @RequestMapping("/booklist-by-author/{cid}")
    public String listByAuthor(Model model, @PathVariable("cid") Integer authorId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }
        model.addAttribute("cates", categoryService.getAllCategories());
        model.addAttribute("authors",authorService.getAllAuthors());
        model.addAttribute("publishers",publisherService.getAllPublishers());
        model.addAttribute("books", bookService.getBookByAuthorID(authorId));
        return "user/booklist";
    }

    @RequestMapping("/booklist-by-publisher/{cid}")
    public String listByPublisher(Model model, @PathVariable("cid") Integer categoryId, HttpSession session ) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);// Người dùng đã đăng nhập

        }
        model.addAttribute("cates", categoryService.getAllCategories());
        model.addAttribute("authors",authorService.getAllAuthors());
        model.addAttribute("publishers",publisherService.getAllPublishers());
        model.addAttribute("books", bookService.getBookByPublisher(categoryId));
        return "user/booklist";
    }

    @PostMapping("/cart/checkout")

//    public ResponseEntity<Map<String, String>> checkout(HttpSession session, Model model) {
//        try {
//            User user = (User) session.getAttribute("user");
//            orderService.processCheckout(user.getUserId());
//            Map<String, String> response = new HashMap<>();
//            response.put("message", "Thanh toán thành công!");
//            response.put("redirectUrl", "/user/historyOrder"); // Đường dẫn cần chuyển hướng
//            return ResponseEntity.ok(response);
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//                    .body(Map.of("message", "Đã xảy ra lỗi: " + e.getMessage()));
//        }
//    }
    public String checkout(HttpSession session, Model model) {
        // Lấy thông tin user từ session
        User currentUser = (User) session.getAttribute("user");

        try {
            // Gọi service xử lý thanh toán
            orderService.processCheckout(currentUser.getUserId());

            // Thêm thông báo thành công vào model
            model.addAttribute("message", "Đặt hàng thành công!");
            return "redirect:/user/historyOrder";

        } catch (Exception e) {
            // Thêm thông báo thất bại vào model
            model.addAttribute("message", "Đặt hàng thất bại: " + e.getMessage());
        }

        // Quay lại trang giỏ hàng (hoặc trang khác nếu cần)
        return "redirect:/user/cart";
    }

}
