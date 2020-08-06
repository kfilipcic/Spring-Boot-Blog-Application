package net.croz.blog.blogweb.post;

import net.croz.blog.blogweb.tag.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PostServiceImpl implements PostService {
    private PostRepository postRepository;

    @Autowired
    public PostServiceImpl(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    @Override
    public List<Post> findAll() {
        return postRepository.findAll();
    }

    @Override
    public Post findById(int theId) {
        Optional<Post> result = postRepository.findById(theId);
        Post post = null;
        if (result.isPresent()) {
            post = result.get();
        }
        return post;
    }

    @Override
    public void save(Post post) {
        postRepository.save(post);
    }

    @Override
    public void deleteById(int theId) {
        postRepository.deleteById(theId);
    }

    @Override
    public Tag findTagByName(String name) {
        return postRepository.findTagByName(name);
    }

    @Override
    public List<Post> findPostsByAuthorFirstName(String firstName) {
        return postRepository.findPostsByAuthorFirstName(firstName);
    }

    @Override
    public List<Post> findPostsByAuthorLastName(String lastName) {
        return postRepository.findPostsByAuthorLastName(lastName);
    }

    @Override
    public List<Post> findPostsByTitle(String title) {
        return postRepository.findPostsByTitle(title);
    }

    @Override
    public List<Post> findPostsByDateStartingWith(Date dateString) {
        return postRepository.findPostsByDateStartingWith(dateString);
    }

    @Override
    public List<Post> findPostsByDateEndingWith(Date dateString) {
        return postRepository.findPostsByDateEndingWith(dateString);
    }

    @Override
    public List<Post> findPostsByTagName(String tagName) {
        return postRepository.findPostsByTagName(tagName);
    }
}
