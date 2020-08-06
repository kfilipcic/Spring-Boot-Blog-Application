package net.croz.blog.blogweb.controllers;

import net.croz.blog.blogweb.author.Author;
import net.croz.blog.blogweb.comment.Comment;
import net.croz.blog.blogweb.comment.CommentService;
import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.post.PostService;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.security.AuthorUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Date;

@Controller
public class CommentController {

    private PostService postService;
    private CommentService commentService;

    @Autowired
    public CommentController(PostService postService, CommentService commentService) {
        this.postService = postService;
        this.commentService = commentService;
    }

    @Autowired
    private AuthorUserRepository authorUserRepository;

    @PostMapping("/processComment")
    public String processComment(
            @Valid @ModelAttribute("comment") Comment comment,
            BindingResult result,
            RedirectAttributes redirectAttributes
    ) {


        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Author currentAuthor = authorUserRepository.findByUserName(loggedUser.getUsername()).orElse(null);

        comment.setAuthor(currentAuthor);

        String postId = String.valueOf(comment.getPost().getId());

        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.comment", result);
            redirectAttributes.addFlashAttribute("comment", comment);
            return "redirect:/blog_post_" + postId + "#comments";
        }

        Post post = postService.findById(comment.getPost().getId());
        comment.setPost(post);

        comment.setDateCreated(new Date());
        commentService.save(comment);

        return "redirect:/blog_post_" + postId + "#comments";
    }
}
