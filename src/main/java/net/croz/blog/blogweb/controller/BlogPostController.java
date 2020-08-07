package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.comment.Comment;
import net.croz.blog.blogweb.service.CommentService;
import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.service.PostService;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.repository.AuthorUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BlogPostController {

    @Autowired
    private AuthorUserRepository authorUserRepository;

    private PostService postService;
    private CommentService commentService;

    @Autowired
    public BlogPostController(PostService postService, CommentService commentService) {
        this.postService = postService;
        this.commentService = commentService;
    }

    @RequestMapping(value = "/blog_post_{post.id}", method = RequestMethod.GET)
    public String openBlogPost(@PathVariable("post.id") String pathVariable, Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        authorUserRepository.findByUserName(loggedUser.getUsername()).orElse(null);

        model.addAttribute("currentUsername", loggedUser.getUsername());

        Post post = postService.findById(Integer.valueOf(pathVariable));
        model.addAttribute("blogPost", post);
        if (!model.containsAttribute("comment")) {
            model.addAttribute("comment", new Comment());
        }
        model.addAttribute("comments", commentService.findAllByPostId(post.getId()));

        return "blog_post";
    }
}
