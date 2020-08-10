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
    List<Post> findAllReversed();

    List<Integer> everyPostCommentsCount();

    Post findById(int theId);

    void save(Post post);

    void deleteById(int theId);

    PostsLong getCurrentPagePosts(Optional<Date> dateFrom, Optional<Date> dateTo, Optional<String> authorFirstName, Optional<String> title, Optional<String> tagName, int currentPageNumber, int itemsPerPage);

    Boolean createNewPost(Post post, AuthorUserDetails authorUserDetails, BindingResult result);

    String processSearchForm(Model model, AuthorUserDetails loggedUser, SearchParams searchParams);
}
