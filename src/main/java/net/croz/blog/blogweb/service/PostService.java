package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Post;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.ui.Model;
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

    String indexPage(Model model, AuthorUserDetails loggedUser);

    String prepareNewPostForm(Model model, AuthorUserDetails loggedUser);

    String processSearchForm(Model model, AuthorUserDetails loggedUser, SearchParams searchParams);

    String openBlogPost(Model model, AuthorUserDetails loggedUser, String pathVariable);
}
