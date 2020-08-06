package net.croz.blog.blogweb.post;

import net.croz.blog.blogweb.tag.Tag;

import java.util.Date;
import java.util.List;

public interface PostService {
    List<Post> findAll();

    Post findById(int theId);

    void save(Post post);

    void deleteById(int theId);

    Tag findTagByName(String name);

    List<Post> findPostsByAuthorFirstName(String firstName);

    List<Post> findPostsByAuthorLastName(String lastName);

    List<Post> findPostsByTitle(String title);

    List<Post> findPostsByDateStartingWith(Date dateString);

    List<Post> findPostsByDateEndingWith(Date dateString);

    List<Post> findPostsByTagName(String tagName);
}
