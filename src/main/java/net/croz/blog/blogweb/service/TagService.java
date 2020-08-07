package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.tag.Tag;
import org.springframework.stereotype.Service;

public interface TagService {
    Tag findByName(String name);
}
