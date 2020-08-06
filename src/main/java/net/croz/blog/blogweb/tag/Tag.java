package net.croz.blog.blogweb.tag;

import net.croz.blog.blogweb.post.Post;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tag")
public class Tag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @OneToMany(mappedBy = "tag", fetch = FetchType.LAZY,
            cascade = {CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH})
    @NotFound(action = NotFoundAction.IGNORE)
    private List<Post> posts;

    @Column(name = "name")
    @Size(min=3, max=30, message = "has to be between 3 and 30 characters")
    private String name;

    public Tag() {

    }

    public Tag(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Tag{" +
                "id=" + id +
            //    ", posts=" + posts +
                ", name='" + name + '\'' +
                '}';
    }

    public void addPost(Post post) {
        if(posts == null) {
            posts = new ArrayList<>();
        }
        posts.add(post);
    }
}
