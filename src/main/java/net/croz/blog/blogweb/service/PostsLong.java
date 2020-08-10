package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Post;

import java.util.List;

public class PostsLong {
    private List<Post> posts;
    private Long count;

    PostsLong(List<Post> posts, Long count) {
        this.posts = posts;
        this.count = count;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }
}
