package net.croz.blog.blogweb;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.Arrays.asList;

@Controller
public class MyController {
    private PostService postService;
    private CommentService commentService;

    @Autowired
    public MyController(PostService postService, CommentService commentService) {
        this.postService = postService;
        this.commentService = commentService;
    }

    @GetMapping("/form_example")
    public String formExample(Model model) {
        model.addAttribute("post", new Post());
        return "form_example";
    }

    @PostMapping("/processComment")
    public String processComment(
            @Valid @ModelAttribute("comment") Comment comment,
            BindingResult result,
            RedirectAttributes redirectAttributes
            ) {


        String postId = String.valueOf(comment.getPost().getId());

        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.comment", result);
            redirectAttributes.addFlashAttribute("comment", comment);
            return "redirect:/blog_post_" + postId + "#comments";
        }

        Post post = postService.findById(comment.getPost().getId());
        comment.setPost(post);

        comment.setDateCreated(new Date());
        commentService.save(comment);

        return "redirect:/blog_post_" + postId + "#comments";
    }

    @RequestMapping(value = "/blog_post_{post.id}", method = RequestMethod.GET)
    public String openBlogPost(@PathVariable("post.id") String pathVariable, Model model) {
        Post post = postService.findById(Integer.valueOf(pathVariable));
        model.addAttribute("blogPost", post);
        if (!model.containsAttribute("comment")) {
            model.addAttribute("comment", new Comment());
        }
        model.addAttribute("comments", commentService.findAllByPostId(post.getId()));

        return "blog_post";
    }

    @GetMapping("/search")
    public String processSearch(@RequestParam("dateFrom") Optional<String> dateFrom,
                                @RequestParam("dateTo") Optional<String> dateTo,
                                @RequestParam("authorName") Optional<String> authorName,
                                @RequestParam("title") Optional<String> title,
                                @RequestParam("tagName") Optional<String> tagName,
                                @RequestParam("page") Optional<Integer> pageNumber,
                                @RequestParam("itemsNum")  Optional<Integer> itemsNum,
                                Model model) {


        // For autocompletion - temporary hack
        // Not memory efficient
        model.addAttribute("allPosts", postService.findAll());

        DateFormat format = new SimpleDateFormat("dd.MM.yyyy", Locale.ENGLISH);

        List<Post> posts = new ArrayList<>();
        List<Post> namePosts = new ArrayList<>();
        List<Post> titlePosts = new ArrayList<>();
        List<Post> tagPosts = new ArrayList<>();
        List<Post> dateStartPosts = new ArrayList<>();
        List<Post> dateEndPosts = new ArrayList<>();

        if (authorName.isPresent()) {
            //Regular expression for determining
            //if only one or two words were entered
            String namePattern = "(\\S+)?\\s(\\S+)";
            Pattern r = Pattern.compile(namePattern);
            Matcher matcher = r.matcher(authorName.get());


            //If two words are entered, search by first and last name separately
            if (!authorName.get().isEmpty()) {
                if (matcher.find() && matcher.groupCount() == 2) {
                    List<Post> postsByAuthorFirstName = postService.findPostsByAuthorFirstName(matcher.group(1));
                    List<Post> postsByAuthorLastName = postService.findPostsByAuthorLastName(matcher.group(2));

                    postsByAuthorFirstName.retainAll(postsByAuthorLastName);

                    namePosts.addAll(postsByAuthorFirstName);

                    //If there aren't two words entered, search the entire input
                    // both by first and last name
                } else if (matcher.groupCount() > 0) {
                    namePosts.addAll(postService.findPostsByAuthorFirstName(authorName.orElse("_")));
                    namePosts.addAll(postService.findPostsByAuthorLastName(authorName.orElse("_")));
                }
            }
        }

        if (title.isPresent() && !title.get().isEmpty()) {
            titlePosts = postService.findPostsByTitle(title.orElse("_"));
        }

        if (tagName.isPresent() && tagName.get().isEmpty()) {
            tagPosts = postService.findPostsByTagName(tagName.orElse("_"));
        }

        boolean dateStartFailed = false;
        boolean dateEndFailed = false;

        try {
            dateStartPosts = postService.findPostsByDateStartingWith(format.parse(dateFrom.orElse("_")));
        } catch (ParseException e) {
            System.err.println("Error while parsing start date");
            dateStartFailed = true;
        }
        try {
            dateEndPosts = postService.findPostsByDateEndingWith(format.parse(dateTo.orElse("_")));
        } catch (ParseException e) {
            System.err.println("Error while parsing end date");
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

        PagedListHolder<Post> page = new PagedListHolder<>(posts);
            page.setPageSize(itemsNum.orElse(5));
            page.setPage(pageNumber.orElse(0));

            int totalPages = page.getPageCount();
            List<Post> currentPosts = page.getPageList();

        model.addAttribute("posts", currentPosts);
        model.addAttribute("totalPages", String.valueOf(totalPages+1));
        model.addAttribute("currentPageNum", String.valueOf(pageNumber.orElse(0)+1));

        return "search";
    }

    @GetMapping("/autocomplete")
    public String autoComplete(Model model) {
        return "autocomplete";
    }

    @GetMapping("/")
    public String showIndex(Model model) {
        List<Post> posts = postService.findAll();

        //Show newest posts first
        Collections.reverse(posts);

        model.addAttribute("posts", posts);
        return "index";
    }

    @GetMapping("/new_post")
    public String showNewPostForm(Model model) {
        model.addAttribute("post", new Post());
        return "new_post";
    }

    @PostMapping("/processForm")
    public String processForm(@Valid @ModelAttribute("post") Post model, BindingResult result) {
        String tagName = model.getTag().getName();

        // Set the current date (it can't be null)
        model.setDateCreated(new Date());

        // Check if tag already exists in database
        Tag existingTag = postService.findTagByName(tagName);
        if (existingTag != null) {
            // If the tag already exists, just make a reference to it
            model.setTag(existingTag);
        }
        if (result.hasErrors()) {
            return "new_post";
        } else {
            postService.save(model);
            return "redirect:/";
        }
    }
}
