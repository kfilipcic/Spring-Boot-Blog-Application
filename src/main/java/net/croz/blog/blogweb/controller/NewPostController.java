package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.domain.Post;
import net.croz.blog.blogweb.service.PostService;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class NewPostController {
    private PostService postService;

    public NewPostController(PostService postService) {
       this.postService = postService;
    }

    @GetMapping("/new_post")
    public String showNewPostForm(Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        return postService.prepareNewPostForm(model, loggedUser);
    }

    @PostMapping("/processForm")
    public String processForm(@Valid @ModelAttribute("post") Post model, BindingResult result) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        return postService.createNewPost(model, loggedUser, result);
    }
}
