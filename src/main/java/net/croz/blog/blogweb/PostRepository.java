package net.croz.blog.blogweb;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PostRepository extends JpaRepository<Post, Integer> {
    @Query("SELECT t FROM Tag t WHERE t.name = ?1")
    Tag findTagByName(String name);
}
