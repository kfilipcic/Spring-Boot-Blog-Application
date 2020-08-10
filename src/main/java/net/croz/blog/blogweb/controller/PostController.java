package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.domain.Comment;
import net.croz.blog.blogweb.domain.Post;
import net.croz.blog.blogweb.repository.AuthorUserRepository;
import net.croz.blog.blogweb.request.PostRequest;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.service.CommentService;
import net.croz.blog.blogweb.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
public class PostController {
    private PostService postService;
    private CommentService commentService;
    private AuthorUserRepository authorUserRepository;

    @Autowired
    public PostController(PostService postService, CommentService commentService, AuthorUserRepository authorUserRepository) {
        this.postService = postService;
        this.commentService = commentService;
        this.authorUserRepository = authorUserRepository;
    }

    @RequestMapping(value = "/blog/{post.id}", method = RequestMethod.GET)
    public String openBlogPost(@PathVariable("post.id") String pathVariable, Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        authorUserRepository.findByUserName(loggedUser.getUsername()).orElse(null);

        model.addAttribute("currentUsername", loggedUser.getUsername());

        Post post = postService.findById(Integer.valueOf(pathVariable));
        model.addAttribute("blogPost", post);
        if (!model.containsAttribute("comment")) {
            model.addAttribute("comment", new Comment());
        }
        model.addAttribute("comments", commentService.findAllByPostId(post.getId()));
        model.addAttribute("commentsCount", commentService.findAllByPostId(post.getId()).size());

        return "blog_post";
    }

    @GetMapping("/new_post")
    public String showNewPostForm(Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        model.addAttribute("currentUsername", loggedUser.getUsername());
        model.addAttribute("post", new Post());

        return "new_post";
    }

    @PostMapping("/processForm")
    public String processNewPostForm(@Valid @ModelAttribute("post") PostRequest model, BindingResult result) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        if (postService.createNewPost(new Post(model), loggedUser, result)) {
            return "redirect:/";
        } else {
            return "new_post";
        }
    }

    @GetMapping("/search")
    public String searchPostsPage(SearchParams searchParams, Model model) {

        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        return postService.processSearchForm(model, loggedUser, searchParams);
    }
}
