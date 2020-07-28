package net.croz.blog.blogweb;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@org.springframework.web.bind.annotation.RestController
@RequestMapping("/api")
public class RestController {
    private PostService postService;

    @Autowired
    public RestController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/add_post")
    public String addPost() {
        postService.save(
                new Post(
                        new Author(
                                "Siba",
                                "China",
                                "nez@gmail.com"),
                        "What to do",
                        "The best thing to do is to do something."
                )
        );
        return "post added";
    }

    @GetMapping("/posts")
    public List<Post> findAll() {
        return postService.findAll();
    }
}
