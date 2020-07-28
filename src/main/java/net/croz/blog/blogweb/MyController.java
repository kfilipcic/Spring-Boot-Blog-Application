package net.croz.blog.blogweb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class MyController {
    @GetMapping("/")
    public String showIndex() {
        return "index";
    }
}
