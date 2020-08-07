package net.croz.blog.blogweb.security;

import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.service.AuthorUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;

import javax.validation.Valid;

@Controller
public class SecurityController {
    @Autowired
    private AuthorUserDetailsService userDetailsService;
    private AuthenticationManager authenticationManager;

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/loginSecure")
    public String processLogin(@RequestAttribute("username") String username,
                               @RequestAttribute("password") String password) {
        //does the authentication
        final Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        username,
                        password
                )
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return "index";
    }

    @GetMapping("/registration")
    public String registrationPage(Model model) {
        return userDetailsService.prepareRegistrationPage(model);
    }

    @PostMapping("/registrationProcessing")
    public String loginPage(@Valid @ModelAttribute("userForm") Author author) {
        return userDetailsService.registerUser(author);
    }
}
