package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Comment;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

public interface CommentService {
    List<Comment> findAll();

    Comment findById(int theId);

    void save(Comment comment);

    void deleteById(int theId);

    List<Comment> findAllByPostId(int postId);

    String createComment(Comment comment,
                                AuthorUserDetails loggedUser,
                                BindingResult result,
                                RedirectAttributes redirectAttributes);
}
