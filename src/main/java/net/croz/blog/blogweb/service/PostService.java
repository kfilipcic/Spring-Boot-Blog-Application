package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.tag.Tag;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface PostService {
    List<Post> findAll();

    Post findById(int theId);

    void save(Post post);

    void deleteById(int theId);

    List<Post> getPosts(Optional<Date> dateFrom, Optional<Date> dateTo, Optional<String> authorFirstName, Optional<String> title, Optional<String> tagName);

    String createNewPost(Post post, AuthorUserDetails authorUserDetails, BindingResult result);
}
