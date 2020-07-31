package net.croz.blog.blogweb;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

public interface PostRepository extends JpaRepository<Post, Integer> {
    @Query("SELECT t FROM Tag t WHERE t.name = ?1")
    Tag findTagByName(String name);

    @Query("SELECT p FROM Post p WHERE p.author.firstName LIKE ?1")
    List<Post> findPostsByAuthorFirstName(String firstName);

    @Query("SELECT p FROM Post p WHERE p.author.lastName LIKE ?1")
    List<Post> findPostsByAuthorLastName(String lastName);

    @Query("SELECT p FROM Post p WHERE p.title LIKE ?1")
    List<Post> findPostsByTitle(String title);

    @Query("SELECT p FROM Post p WHERE p.dateCreated >= ?1")
    List<Post> findPostsByDateStartingWith(Date dateString);

    @Query("SELECT p FROM Post p WHERE p.dateCreated <= ?1")
    List<Post> findPostsByDateEndingWith(Date dateString);

    @Query("SELECT p FROM Post p WHERE p.tag.name LIKE ?1")
    List<Post> findPostsByTagName(String tagName);
}
