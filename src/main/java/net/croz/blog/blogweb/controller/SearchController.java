package net.croz.blog.blogweb.controller;

import net.croz.blog.blogweb.service.PostService;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SearchController {

    private PostService postService;

    @Autowired
    public SearchController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/search")
    public String processSearch(SearchParams searchParams, Model model) {

        AuthorUserDetails loggedUser = (AuthorUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();

        return postService.processSearchForm(model, loggedUser, searchParams);
    }
}
