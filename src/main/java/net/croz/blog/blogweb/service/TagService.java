package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Tag;

public interface TagService {
    Tag findByName(String name);
}
