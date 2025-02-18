package net.croz.blog.blogweb.domain;

import net.croz.blog.blogweb.request.PostRequest;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.Entity;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GeneratedValue;
import javax.persistence.Column;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.CascadeType;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

@Entity
@Table(name = "post")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(cascade = {CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinColumn(name = "author_id")
    @Valid
    private Author author;

    @NotNull(message = "is required")
    @Size(min = 1, max = 100, message = "is required")
    @Column(name = "title")
    private String title;

    @NotNull(message = "is required")
    @Size(min = 1, message = "is required")
    @Column(name = "content")
    @Size(max = 100, message = "The maximum number of characters is 100")
    private String content;

    @NotNull(message = "is required")
    @Column(name = "date_created")
    private Date dateCreated;

    @ManyToOne(cascade = {CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH})

    // Custom annotation for checking tag length
    //@Size(min=3, max=30, message = "has to be between 3 and 30 characters")

    @JoinColumn(name = "tag_id")
    @NotFound(action = NotFoundAction.IGNORE)
    @Valid
    private Tag tag;

    public Post() {
        // Can't be null, throws exception if not
        // specified upon creation
        this.dateCreated = new Date();
    }

    public Post(Author author, String title, String content) {
        this.author = author;
        this.title = title;
        this.content = content;
        this.dateCreated = new Date();
    }

    public Tag getTag() {
        return tag;
    }

    public void setTag(Tag tag) {
        this.tag = tag;
    }

    public Post(Author author, String title, String content, Tag tag) {
        this.author = author;
        this.title = title;
        this.content = content;
        this.tag = tag;
        this.dateCreated = new Date();
    }

    public Post(PostRequest postRequest) {
        this.author = postRequest.getAuthor();
        this.title = postRequest.getTitle();
        this.content = postRequest.getContent();
        this.tag = postRequest.getTag();
        this.dateCreated = postRequest.getDateCreated();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
//                ", author=" + author +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", dateCreated=" + dateCreated +
                ", tag=" + tag +
                '}';
    }
}
