package net.croz.blog.blogweb;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
public class RegistrationController {
    @Autowired
    private MyUserDetailsService userDetailsService;

    @GetMapping("/registration")
    public String registrationPage(Model model) {
        model.addAttribute("userForm", new Author());
        return "registration";
    }

    @PostMapping("/registrationProcessing")
    public String loginPage(@Valid @ModelAttribute("userForm") Author author, BindingResult result) {
        userDetailsService.signUpUser(author);

        return "redirect:/";
    }
}
