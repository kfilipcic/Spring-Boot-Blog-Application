package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.repository.TagRepository;
import net.croz.blog.blogweb.domain.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TagServiceImpl implements TagService {
    private TagRepository tagRepository;

    @Autowired
    public TagServiceImpl(TagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    @Override
    public Tag findByName(String name) {
        return tagRepository.findByName(name);
    }
}