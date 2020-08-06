package net.croz.blog.blogweb.controllers;

import net.croz.blog.blogweb.author.Author;
import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.post.PostRepository;
import net.croz.blog.blogweb.post.PostService;
import net.croz.blog.blogweb.post.PostSpecs;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.security.AuthorUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

        DateFormat format = new SimpleDateFormat("dd.MM.yyyy", Locale.ENGLISH);

        List<Post> posts = new ArrayList<>();
        List<Post> namePosts = new ArrayList<>();
        List<Post> titlePosts = new ArrayList<>();
        List<Post> tagPosts = new ArrayList<>();
        List<Post> dateStartPosts = new ArrayList<>();
        List<Post> dateEndPosts = new ArrayList<>();
        System.out.println("searchparams: " + searchParams);

        if (searchParams.getAuthorName() != null && searchParams.getAuthorName().isPresent()) {
            System.out.println(searchParams.getAuthorName().get());
            Specification<Post> specpost = PostSpecs.authorFirstNameContains(
                    searchParams.getAuthorName().get()
            );
            System.out.println("specpost: " + specpost);
            System.out.println(Specification.where(specpost));
            List<Post> postsss =  postRepository.findAll(Specification.where(specpost));

            System.out.println("Postsssss:");
            System.out.println(postsss);

            //Regular expression for determining
            //if only one or two words were entered
            String namePattern = "(\\S+)?\\s(\\S+)";
            Pattern r = Pattern.compile(namePattern);
            Matcher matcher = r.matcher(searchParams.getAuthorName().get());


            //If two words are entered, search by first and last name separately
            if (!searchParams.getAuthorName().get().isEmpty()) {
                if (matcher.find() && matcher.groupCount() == 2) {
                    List<Post> postsByAuthorFirstName = postService.findPostsByAuthorFirstName(matcher.group(1));
                    List<Post> postsByAuthorLastName = postService.findPostsByAuthorLastName(matcher.group(2));

                    postsByAuthorFirstName.retainAll(postsByAuthorLastName);

                    namePosts.addAll(postsByAuthorFirstName);

                    //If there aren't two words entered, search the entire input
                    // both by first and last name
                } else if (matcher.groupCount() > 0) {
                    namePosts.addAll(postService.findPostsByAuthorFirstName(searchParams.getAuthorName().orElse("_")));
                    namePosts.addAll(postService.findPostsByAuthorLastName(searchParams.getAuthorName().orElse("_")));
                }
            }
        }

        if (searchParams.getTitle() != null && searchParams.getTitle().isPresent() && !searchParams.getTitle().get().isEmpty()) {
            titlePosts = postService.findPostsByTitle(searchParams.getTitle().orElse("_"));
        }

        if (searchParams.getTagName() != null && searchParams.getTagName().isPresent() && searchParams.getTagName().get().isEmpty()) {
            tagPosts = postService.findPostsByTagName(searchParams.getTagName().orElse("_"));
        }

        boolean dateStartFailed = false;
        boolean dateEndFailed = false;

        try {
            dateStartPosts = postService.findPostsByDateStartingWith(format.parse(searchParams.getDateFrom().orElse("_")));
        } catch (ParseException e) {
            System.err.println("Error while parsing start date");
            dateStartFailed = true;
        } catch (Exception e) {
            System.err.println("Error while reading 'dateFrom' parameter");
            dateStartFailed = true;
        }
        try {
            dateEndPosts = postService.findPostsByDateEndingWith(format.parse(searchParams.getDateTo().orElse("_")));
        } catch (ParseException e) {
            System.err.println("Error while parsing end date");
            dateEndFailed = true;
        } catch (Exception e) {
            System.err.println("Error while reading 'dateTo' parameter");
            dateEndFailed = true;
        }

        List<List<Post>> lists = new ArrayList<>();

        if (!dateStartFailed) {
            lists.add(dateStartPosts);
        }
        if (!dateEndFailed) {
            lists.add(dateEndPosts);
        }
        lists.add(namePosts);
        lists.add(tagPosts);
        lists.add(titlePosts);

        boolean first = true;

        for (List<Post> list : lists) {
            if (list.isEmpty()) continue;
            if (first) {
                posts.addAll(list);
                first = false;
            } else {
                posts.retainAll(list);
            }
        }

        // Newest posts are shown first
        Collections.reverse(posts);

        //Pagination implementation

        //Pageable pageable = PageRequest.of(0, 5);
        // Page<Post> page = new PageImpl<>(posts, pageable, posts.size());

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
            currentPageNumber = searchParams.getPageNumber().orElse(0);
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
