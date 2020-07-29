package net.croz.blog.blogweb;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Date;
import java.util.List;

@Controller
public class MyController {
    private PostService postService;

    @Autowired
    public MyController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/")
    public String showIndex(Model model) {
        List<Post> posts = postService.findAll();
        model.addAttribute("posts", posts);
        return "index";
    }

    @GetMapping("/index2")
    public String showIndex2(Model model) {
        List<Post> posts = postService.findAll();
        model.addAttribute("posts", posts);
        return "index2";
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
        if(existingTag != null) {
            // If the tag already exists, just make a reference to it
            model.setTag(existingTag);
        }
        if (result.hasErrors()) {
            //System.out.println(result.getAllErrors());
            System.out.println("it has errors");
            return "new_post";
        } else {
            postService.save(model);
            return "index";
        }
    }
}
