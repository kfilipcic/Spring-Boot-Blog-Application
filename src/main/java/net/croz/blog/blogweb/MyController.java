package net.croz.blog.blogweb;

import org.springframework.beans.factory.annotation.Autowired;
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
    public String processSearch(@Valid @ModelAttribute("post") Post model,
                                BindingResult result,
                                @RequestParam("dateFrom") String dateFrom,
                                @RequestParam("dateTo") String dateTo, Model modell) {

        List<Post> posts = postService.findAll();
        Post post = new Post();
        Author author = new Author();
        if (modell.getAttribute("post") == null) {
            modell.addAttribute("post", post);
        }
        if (modell.getAttribute("posts") == null) {
            modell.addAttribute("posts", post);
        }
        modell.addAttribute("posts", posts);

        List<Post> results = new ArrayList<>();

        if (model.getAuthor() != null) {
            if (model.getAuthor().getFirstName() != null ) {
                List<Post> results1 = postService.findPostsByAuthorFirstName(model.getAuthor().getFirstName());
                System.out.println("RESULTS1: ");
                for (Post p : results1) {
                    System.out.println(p.getAuthor());
                }
                results.addAll(results1);
            }
            if (model.getAuthor().getLastName() != null) {
                List<Post> results2 = postService.findPostsByAuthorFirstName(model.getAuthor().getLastName());
                System.out.println("RESULTS2: ");
                for (Post p : results2) {
                    System.out.println(p.getAuthor());
                }
                results.addAll(results2);
            }
        }
        if (model.getTitle() != null) {
            List<Post> results3 = postService.findPostsByTitle(model.getTitle());
            System.out.println("RESULTS3: ");
            for (Post p : results3) {
                System.out.println(p);
            }
            results.addAll(results3);
        }
        if (model.getTag() != null && model.getTag().getName() != null) {
            List<Post> results4 = postService.findPostsByTagName(model.getTag().getName());
            System.out.println("RESULTS4: ");
            for (Post p : results4) {
                System.out.println(p);
            }
            results.addAll(results4);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            DateFormat format = new SimpleDateFormat("dd.MM.yyyy", Locale.ENGLISH);
            Date date = new Date();
            try {
                date = format.parse(dateFrom);
            } catch (ParseException e) {
                System.err.println("Error while parsing date");
                e.printStackTrace();
            }
            List<Post> results5 = postService.findPostsByDateStartingWith(date);
            System.out.println("RESULTS5: ");
            for (Post p : results5) {
                System.out.println(p);
            }
            results.addAll(results5);
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            DateFormat format = new SimpleDateFormat("dd.MM.yyyy", Locale.ENGLISH);
            Date date = new Date();
            try {
                date = format.parse(dateTo);
            } catch (ParseException e) {
                System.err.println("Error while parsing date");
                e.printStackTrace();
            }
            List<Post> results6 = postService.findPostsByDateStartingWith(date);
            System.out.println("RESULTS5: ");
            for (Post p : results6) {
                System.out.println(p);
            }
            results.addAll(results6);
        }
        System.out.println("FOUND RESULTS: ");
        for (Post r : results) {
            System.out.println(r);
        }
        return "search";
    }

    @GetMapping("/autocomplete")
    public String autoComplete(Model model) {
        return "autocomplete";
    }

    @GetMapping("/")
    public String showIndex(Model model) {
        List<Post> posts = postService.findAll();
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
