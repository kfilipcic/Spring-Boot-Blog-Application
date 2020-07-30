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
import java.util.Date;
import java.util.List;

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
            //return "blog_post";
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
        System.out.println("kakva su ovo CUD");

        Post post = postService.findById(Integer.valueOf(pathVariable));
        model.addAttribute("blogPost", post);
        if (!model.containsAttribute("comment")) {
            model.addAttribute("comment", new Comment());
        }
        model.addAttribute("comments", commentService.findAllByPostId(post.getId()));

        System.out.println((Comment) model.getAttribute("comment"));

        return "blog_post";
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
