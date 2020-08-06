package net.croz.blog.blogweb.controllers;

import net.croz.blog.blogweb.author.Author;
import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.post.PostService;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.security.AuthorUserRepository;
import net.croz.blog.blogweb.tag.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Date;

@Controller
public class NewPostController {
    private PostService postService;

    @Autowired
    private AuthorUserRepository authorUserRepository;

    public NewPostController(PostService postService) {
       this.postService = postService;
    }

    @GetMapping("/new_post")
    public String showNewPostForm(Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        model.addAttribute("currentUsername", loggedUser.getUsername());
        model.addAttribute("post", new Post());

        return "new_post";
    }

    @PostMapping("/processForm")
    public String processForm(@Valid @ModelAttribute("post") Post model, BindingResult result) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Author currentAuthor = authorUserRepository.findByUserName(loggedUser.getUsername()).orElse(null);

        model.setAuthor(currentAuthor);

        String tagName = model.getTag().getName();

        // Set the current date (it can't be null)
        model.setDateCreated(new Date());

        // Check if tag already exists in database
        Tag existingTag = postService.findTagByName(tagName);
        if (existingTag != null) {
            // If the tag already exists, just make a reference to it
            model.setTag(existingTag);
        }
        if (result.hasErrors()) {
            return "new_post";
        } else {
            postService.save(model);
            return "redirect:/";
        }
    }
}
