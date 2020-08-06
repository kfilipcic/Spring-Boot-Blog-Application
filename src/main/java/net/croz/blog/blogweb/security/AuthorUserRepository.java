package net.croz.blog.blogweb.security;

import net.croz.blog.blogweb.author.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

public interface AuthorUserRepository extends JpaRepository<Author, Integer>, JpaSpecificationExecutor<Author> {
    Optional<Author> findByUserName(String userName);
}
