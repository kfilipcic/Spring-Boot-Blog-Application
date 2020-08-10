package net.croz.blog.blogweb.request;

import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.domain.Post;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

public class CommentRequest {
        private int id;

        private Post post;

        private Author author;

        @NotNull(message = "is required")
        @Size(min=1, message = "is required")
        private String content;

        private Date dateCreated;

        public CommentRequest() {
            dateCreated = new Date();
        }

        public CommentRequest(String content) {
            this.content = content;

            dateCreated = new Date();
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
