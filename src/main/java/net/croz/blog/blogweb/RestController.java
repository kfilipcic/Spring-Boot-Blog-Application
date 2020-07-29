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
                                "Pau",
                                "Pechkoo",
                                "pau@gmail.com"),
                        "Kako smrsaviti",
                        "Ovaj clanak ce Vam sve objasniti."
                )
        );
        postService.save(
                new Post(
                        new Author(
                                "Iva",
                                "Ivic",
                                "iva@gmail.com"),
                        "Lorem Ipsum",
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                                "Praesent feugiat sem non imperdiet tempus. Pellentesque nec " +
                                "scelerisque urna. Morbi aliquam ex sed quam rutrum, vitae iaculis " +
                                "sem rutrum. Nulla ac eros tincidunt, ultrices tellus ut, hendrerit dui." +
                                " Ut eu ornare elit, id laoreet nisl. Ut consectetur enim commodo mauris varius imperdiet." +
                                " Nulla sem sapien, viverra sed ligula vitae, aliquam blandit velit."
                )
        );
        return "posts added";
    }

    @GetMapping("/posts")
    public List<Post> findAll() {
        return postService.findAll();
    }
}
