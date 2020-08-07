package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.domain.Comment;
import net.croz.blog.blogweb.service.CommentService;
import net.croz.blog.blogweb.domain.Post;
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

    private PostService postService;

    @Autowired
    public BlogPostController(PostService postService) {
        this.postService = postService;
    }

    @RequestMapping(value = "/blog_post_{post.id}", method = RequestMethod.GET)
    public String openBlogPost(@PathVariable("post.id") String pathVariable, Model model) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        return postService.openBlogPost(model, loggedUser, pathVariable);
    }
}
