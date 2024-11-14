package com.nnthienphuc.intelligentbookstoreecommercewebsite.controller;

import com.nnthienphuc.intelligentbookstoreecommercewebsite.entity.Staff;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.CookieService;
import com.nnthienphuc.intelligentbookstoreecommercewebsite.service.StaffService;
import jakarta.servlet.http.HttpSession;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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
            @RequestParam(value = "rm", defaultValue = "false") boolean rememberMe) {

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
        session.setAttribute("staffId", staff);

        if (rememberMe) {
            cookie.create("staffid", staff.getStaffId(), 30);
            cookie.create("pass", staff.getPwd(), 30);
        } else {
            cookie.delete("staffid");
            cookie.delete("pass");
        }

        String backUrl = (String) session.getAttribute("back-url");
        return (backUrl != null) ? "redirect:" + backUrl : "admin/Author";
    }


    @GetMapping("/account/register")
    public String registerForm(Model model) {
        model.addAttribute("staff", new Staff());
        return "admin/account/register";
    }

    @PostMapping("/account/register")
    public String register(
            Model model,
            @ModelAttribute("staff") Staff staff,
            BindingResult error) throws Exception {

        if (error.hasErrors()) {
            model.addAttribute("message", "Please fill all the required fields!");
            return "redirect:/user/account/register";
        }

        staff.setIsActive(false);
        staffService.create(staff);


        model.addAttribute("message", "Registration successful. Please check your email for activation.");
        return "redirect:/admin/account/login";
    }

    @RequestMapping("/account/logoff")
    public String logoff() {
        session.removeAttribute("user");
        session.removeAttribute("back-url");
        return "redirect:/admin/account/login";
    }
}
