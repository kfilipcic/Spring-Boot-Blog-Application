package net.croz.blog.blogweb.post;

import org.springframework.data.jpa.domain.Specification;

import java.text.MessageFormat;

public class PostSpecs {
    public static Specification<Post> authorFirstNameContains(String expression) {
        return (root, query, builder) -> builder.like(root.get("author.firstName"), contains(expression));
    }

    private static String contains(String expression) {
        return MessageFormat.format("%{0}%", expression);
    }
}
