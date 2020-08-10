package net.croz.blog.blogweb.request;

import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.domain.Tag;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

public class PostRequest {
        private int id;

        @Valid
        private Author author;

        @NotNull(message = "is required")
        @Size(min = 1, max = 100, message = "is required")
        private String title;

        @NotNull(message = "is required")
        @Size(min = 1, message = "is required")
        @Size(max = 100, message = "The maximum number of characters is 100")
        private String content;

        @NotNull(message = "is required")
        private Date dateCreated;

        @Valid
        private Tag tag;

        public PostRequest() {
            // Can't be null, throws exception if not
            // specified upon creation
            this.dateCreated = new Date();
        }

        public PostRequest(Author author, String title, String content) {
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

        public PostRequest(Author author, String title, String content, Tag tag) {
            this.author = author;
            this.title = title;
            this.content = content;
            this.tag = tag;
            this.dateCreated = new Date();
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

        public Date getDateCreated() {
            return dateCreated;
        }

        public void setDateCreated(Date dateCreated) {
            this.dateCreated = dateCreated;
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
