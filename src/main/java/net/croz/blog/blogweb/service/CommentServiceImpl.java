package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.comment.Comment;
import net.croz.blog.blogweb.repository.CommentRepository;
import net.croz.blog.blogweb.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommentServiceImpl implements CommentService {
    private final CommentRepository commentRepository;

    @Autowired
    public CommentServiceImpl(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
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

}
