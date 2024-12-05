package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller.admin;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Staff;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.model.MailInfo;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CookieService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.MailService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.StaffService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@RequestMapping("/admin")
@Controller
public class AdminController {
    @Autowired
    private StaffService staffService;

    @Autowired
    private HttpSession session;

    @Autowired
    private CookieService cookie;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    MailService mailService;

    @GetMapping("/account/login")
    public String loginForm(org.springframework.ui.Model model) {
        String staffId = String.valueOf(cookie.read("id"));
        String password = String.valueOf(cookie.read("pass"));
        if (staffId != null && password != null) {
            model.addAttribute("id", staffId);
            model.addAttribute("pwd", password);
        }
        return "admin/account/login";
    }

    @PostMapping("/account/login")
    public String login(
            Model model,
            @RequestParam("staffid") @NotEmpty(message = "Username is required!") String staffId,
            @RequestParam("pass") @NotEmpty(message = "Password is required!") String pwd,
            @RequestParam(value = "rm", defaultValue = "true") boolean rememberMe) {

        Optional<Staff> staffOptional = staffService.findById(staffId);
        if (staffOptional.isEmpty()) {
            model.addAttribute("message", "Invalid username!");
            return "redirect:/admin/account/login";
        }

        Staff staff = staffOptional.get();

        if (!passwordEncoder.matches(pwd, staff.getPwd())) {
            model.addAttribute("message", "Invalid password!");
            return "redirect:/admin/account/login";
        }

        if (!staff.getIsActive()) {
            model.addAttribute("message", "Your account is Inactivated!");
            return "redirect:/admin/account/login";
        }

        model.addAttribute("message", "Login successfully!");
        session.setAttribute("staff", staff);

        if (rememberMe) {
            cookie.create("staffid", staff.getStaffId(), 30);
            cookie.create("pass", staff.getPwd(), 30);
        } else {
            cookie.delete("staffid");
            cookie.delete("pass");
        }

        String backUrl = (String) session.getAttribute("back-url");

        if (backUrl != null) {
            return "redirect:" + backUrl;
        }
        return "redirect:/admin/book";

//        return (backUrl != null) ? "redirect:" + backUrl : "admin/Author";
    }


    @GetMapping("/account/register")
    public String registerForm(Model model) {
        model.addAttribute("staff", new Staff());
        return "admin/account/register";
    }

//    @PostMapping("/account/register")
//    public String register(
//            Model model,
//            @ModelAttribute("staff") Staff staff,
//            BindingResult error) throws Exception {
//
//        if (error.hasErrors()) {
//            model.addAttribute("message", "Please fill all the required fields!");
//            return "redirect:/user/account/register";
//        }
//
//        staff.setIsActive(false);
//        staffService.create(staff);
//
//
//        model.addAttribute("message", "Registration successful. Please check your email for activation.");
//
//        String from = "phucnaoto.buildweb@gmail.com";
//        String to = staff.getEmail();
//        String subject = "Let Active Your Account!";
//        String url = request.getRequestURL().toString().replace("register", "activate/" + staff.getStaffId());
//        String body = "Click <a href='" + url + "'> to active your account.</a>";
//        MailInfo mail = new MailInfo(from, to, subject, body);
//        mailService.send(mail);
//
//        return "redirect:/admin/account/login";
//    }

    @PostMapping("/account/register")
    public String register(
            Model model,
            @ModelAttribute("staff") Staff staff,
            BindingResult error) throws Exception {

        if (error.hasErrors()) {
            model.addAttribute("message", "Please fill all the required fields!");
            return "redirect:/admin/account/register";
        }

        staff.setIsActive(false);  // Đặt mặc định là chưa kích hoạt
        staffService.create(staff);  // Lưu thông tin nhân viên vào cơ sở dữ liệu

        model.addAttribute("message", "Registration successful. Please check your email for activation.");

        String from = "phucnaoto.buildweb@gmail.com";
        String to = staff.getEmail();
        String subject = "Activate Your Account!";
        String url = "http://localhost:8080/admin/account/active/" + staff.getStaffId(); // Địa chỉ URL đầy đủ
        // Đường dẫn kích hoạt
        String body = "Click <a href='" + url + "'>here</a> to active your account.";

        MailInfo mail = new MailInfo(from, to, subject, body);
        mailService.send(mail);  // Gửi email

        return "redirect:/admin/account/login";
    }

    @GetMapping("account/active/{id}")
    public String active(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
        Optional<Staff> staff = staffService.findById(id);

        if (staff.isPresent()) {
            Staff currentStaff = staff.get();
            if (!currentStaff.getIsActive()) {
                currentStaff.setIsActive(true);
                staffService.update(currentStaff);
                redirectAttributes.addFlashAttribute("success", "Account activated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("info", "Account is already active!");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Account not found!");
        }

        return "redirect:/admin/account/login";
    }

    @RequestMapping("/account/logoff")
    public String logoff() {
        session.removeAttribute("user");
        session.removeAttribute("back-url");
        return "redirect:/admin/account/login";
    }
}
