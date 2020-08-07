package net.croz.blog.blogweb.controller;
import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.service.PostService;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@Controller
public class MainPageController {
    private PostService postService;

    @Autowired
    public MainPageController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/")
    public String showIndex(Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("currentUsername", loggedUser.getUsername());

        List<Post> posts = postService.findAll();

        //Show newest posts first
        Collections.reverse(posts);

        model.addAttribute("posts", posts);
        return "index";
    }
}
