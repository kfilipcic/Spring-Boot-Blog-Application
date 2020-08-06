package net.croz.blog.blogweb.comment;

import net.croz.blog.blogweb.comment.Comment;

import java.util.List;

public interface CommentService {
    List<Comment> findAll();

    Comment findById(int theId);

    void save(Comment comment);

    void deleteById(int theId);

    List<Comment> findAllByPostId(int postId);
}
