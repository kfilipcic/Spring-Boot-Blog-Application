package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.author.Author;
import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.repository.PostRepository;
import net.croz.blog.blogweb.service.PostService;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.repository.AuthorUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.*;

@Controller
public class SearchController {

    private PostService postService;
    private PostRepository postRepository;

    @Autowired
    public SearchController(PostService postService) {
        this.postService = postService;
    }

    @Autowired
    private AuthorUserRepository authorUserRepository;

    @GetMapping("/search")
    public String processSearch(SearchParams searchParams, Model model) {

        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Author currentAuthor = authorUserRepository.findByUserName(loggedUser.getUsername()).orElse(null);

        model.addAttribute("currentUsername", loggedUser.getUsername());

        // For autocompletion - not memory efficient!
        model.addAttribute("allPosts", postService.findAll());

        List<Post> posts = postService.getPosts(
                searchParams.getDateFrom(),
                searchParams.getDateTo(),
                searchParams.getAuthorName(),
                searchParams.getTitle(),
                searchParams.getTagName()
        );

        // Newest posts are shown first
        Collections.reverse(posts);

        //Pagination implementation
        int itemsPerPage = 5;
        int currentPageNumber = 0;

        PagedListHolder<Post> page = new PagedListHolder<>(posts);

        try {
            itemsPerPage = searchParams.getItemsNum().orElse(5);
        } catch (Exception e) {
            System.err.println("Error while getting items per page number - using 5 instead...");
        }

        page.setPageSize(itemsPerPage);

        try {
            currentPageNumber = searchParams.getPage().orElse(0);
        } catch (Exception e) {
            System.err.println("Error while getting page number - using 0 instead...");
        }

        page.setPage(currentPageNumber);

        int totalPages = page.getPageCount();
        List<Post> currentPosts = page.getPageList();

        model.addAttribute("posts", currentPosts);
        model.addAttribute("totalPages", String.valueOf(totalPages + 1));
        model.addAttribute("currentPageNum", String.valueOf(currentPageNumber + 1));

        return "search";
    }

    @GetMapping("/autocomplete")
    public String autoComplete(Model model) {
        return "autocomplete";
    }
}
