package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.domain.Comment;
import net.croz.blog.blogweb.domain.Post;
import net.croz.blog.blogweb.repository.CommentRepository;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class CommentServiceImpl implements CommentService {
    private final CommentRepository commentRepository;
    private PostService postService;
    private AuthorUserDetailsService authorUserDetailsService;

    @Autowired
    public CommentServiceImpl(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @Autowired
    public void setPostService(PostService postService) {
        this.postService = postService;
    }

    @Autowired
    public void setAuthorUserDetailsService(AuthorUserDetailsService authorUserDetailsService) {
        this.authorUserDetailsService = authorUserDetailsService;
    }

    @Override
    public List<Comment> findAll() {
        return commentRepository.findAll();
    }

    @Override
    public Comment findById(int theId) {
        Optional<Comment> result = commentRepository.findById(theId);
        Comment comment = null;
        if (result.isPresent()) {
            comment = result.get();
        }
        return comment;
    }

    @Override
    public void save(Comment post) {
        commentRepository.save(post);
    }

    @Override
    public void deleteById(int theId) {
        commentRepository.deleteById(theId);
    }

    @Override
    public List<Comment> findAllByPostId(int postId) {
        return commentRepository.findAllByPostId(postId);
    }

    @Override
    public String createComment(Comment comment,
                                AuthorUserDetails loggedUser,
                                BindingResult result,
                                RedirectAttributes redirectAttributes) {

        Author currentAuthor = authorUserDetailsService.findByUserName(loggedUser.getUsername()).orElse(null);
        comment.setAuthor(currentAuthor);

        String postId = String.valueOf(comment.getPost().getId());

        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.comment", result);
            redirectAttributes.addFlashAttribute("comment", comment);
            return postId;
        }

        Post post = postService.findById(comment.getPost().getId());
        comment.setPost(post);

        comment.setDateCreated(new Date());
        this.save(comment);
        return postId;
    }

}
