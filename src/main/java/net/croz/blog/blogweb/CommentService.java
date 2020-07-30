package net.croz.blog.blogweb;

import java.util.List;

public interface CommentService {
    List<Comment> findAll();

    Comment findById(int theId);

    void save(Comment comment);

    void deleteById(int theId);

    List<Comment> findAllByPostId(int postId);
}
