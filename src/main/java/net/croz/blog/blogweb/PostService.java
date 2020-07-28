package net.croz.blog.blogweb;

import java.util.List;

public interface PostService {
    List<Post> findAll();

    Post findById(int theId);

    void save(Post post);

    void deleteById(int theId);
}
