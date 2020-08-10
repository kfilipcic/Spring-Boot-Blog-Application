package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.domain.Comment;
import net.croz.blog.blogweb.request.CommentRequest;
import net.croz.blog.blogweb.service.CommentService;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
public class CommentController {

    private CommentService commentService;

    @Autowired
    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @PostMapping("/blog/processComment")
    public String processComment(
            @Valid @ModelAttribute("comment") CommentRequest commentRequest,
            BindingResult result,
            RedirectAttributes redirectAttributes
    ) {
        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        String postId = commentService.createComment(new Comment(commentRequest),
                                                loggedUser,
                                                result,
                                                redirectAttributes);

        return "redirect:/blog/" + postId + "#comments";
    }
}
