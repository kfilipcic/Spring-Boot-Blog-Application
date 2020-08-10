package net.croz.blog.blogweb.domain;

import net.croz.blog.blogweb.request.CommentRequest;

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
@Table(name = "comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(optional = false, cascade = {CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

    @ManyToOne(cascade = {CascadeType.DETACH,
            CascadeType.MERGE,
            CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinColumn(name = "author_id")
    @Valid
    private Author author;

    @NotNull(message = "is required")
    @Size(min=1, message = "is required")
    @Column(name = "content")
    private String content;

    @Column(name = "date_created")
    private Date dateCreated;

    public Comment() {
        dateCreated = new Date();
    }

    public Comment(String content) {
        this.content = content;

        dateCreated = new Date();
    }

    public Comment(Author author, String content) {
        this.author = author;
        this.content = content;
        dateCreated = new Date();
    }

    public Comment(CommentRequest commentRequest) {
        this.author = commentRequest.getAuthor();
        this.content = commentRequest.getContent();
        this.post = commentRequest.getPost();
        this.dateCreated = commentRequest.getDateCreated();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", post=" + post +
                ", author=" + author +
                ", content='" + content + '\'' +
                ", dateCreated=" + dateCreated +
                '}';
    }
}
