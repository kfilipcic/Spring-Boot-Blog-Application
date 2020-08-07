package net.croz.blog.blogweb.repository;

import net.croz.blog.blogweb.post.Post;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.validation.BindingResult;

public interface PostRepository extends JpaRepository<Post, Integer>, JpaSpecificationExecutor<Post> {
}
