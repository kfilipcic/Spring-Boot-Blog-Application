package net.croz.blog.blogweb.comment;

import net.croz.blog.blogweb.comment.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer>, JpaSpecificationExecutor<Comment> {
    @Query("SELECT c FROM Comment c WHERE c.post.id = ?1")
    List<Comment> findAllByPostId(int postId);
}
