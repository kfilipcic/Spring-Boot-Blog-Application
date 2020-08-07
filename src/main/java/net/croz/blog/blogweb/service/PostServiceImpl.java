package net.croz.blog.blogweb.service;

import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.domain.Comment;
import net.croz.blog.blogweb.domain.Post;
import net.croz.blog.blogweb.repository.PostRepository;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.repository.AuthorUserRepository;
import net.croz.blog.blogweb.domain.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import javax.persistence.criteria.Predicate;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private AuthorUserRepository authorUserRepository;

    private TagService tagService;
    private CommentService commentService;

    private PostRepository postRepository;
    private final static String namePattern = "(\\S+)?\\s(\\S+)";
    private final static Pattern r = Pattern.compile(namePattern);

    @Autowired
    public void setTagService(TagService tagService) {
        this.tagService = tagService;
    }

    @Autowired
    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }

    @Autowired
    public PostServiceImpl(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    @Override
    public List<Post> findAll() {
        return postRepository.findAll();
    }

    @Override
    public Post findById(int theId) {
        Optional<Post> result = postRepository.findById(theId);
        Post post = null;
        if (result.isPresent()) {
            post = result.get();
        }
        return post;
    }

    @Override
    public void save(Post post) {
        postRepository.save(post);
    }

    @Override
    public void deleteById(int theId) {
        postRepository.deleteById(theId);
    }

    public List<Post> getPosts(Optional<Date> dateFrom, Optional<Date> dateTo, Optional<String> authorName, Optional<String> title, Optional<String> tagName) {
        List<Post> posts = postRepository.findAll((Specification<Post>) (root, cq, cb) -> {
            Predicate p = cb.conjunction();
            if(Objects.nonNull(dateFrom) && Objects.nonNull(dateTo) && dateFrom.get().before(dateTo.get())) {
                p = cb.and(p, cb.between(root.get("dateCreated"), dateFrom.get(), dateTo.get()));
            }
            else if (Objects.isNull(dateFrom) && Objects.nonNull(dateTo)) {
                p = cb.and(p, cb.lessThanOrEqualTo(root.get("dateCreated"), dateTo.get()));
            }
            else if (Objects.isNull(dateTo) && Objects.nonNull(dateFrom)) {
                p = cb.and(p, cb.greaterThanOrEqualTo(root.get("dateCreated"), dateFrom.get()));
            }
            if(authorName != null && authorName.isPresent() && !authorName.get().isEmpty()) {
                Matcher matcher = r.matcher(authorName.get());
                if (matcher.find() && matcher.groupCount() == 2) {
                    p = cb.and(p, cb.like(root.get("author").get("firstName"), matcher.group(1)));
                    p = cb.and(p, cb.like(root.get("author").get("lastName"), matcher.group(2)));
                } else {
                    p = cb.and(p, cb.like(root.get("author").get("firstName"), authorName.get()));
                    p = cb.or(p, cb.like(root.get("author").get("lastName"), authorName.get()));
                }
            }
            if(title != null && title.isPresent() && !title.get().isEmpty()) {
                p = cb.and(p, cb.like(root.get("title"), "%" + title.get() + "%"));
            }
            if(tagName != null && tagName.isPresent() && !tagName.get().isEmpty()) {
                p = cb.and(p, cb.like(root.get("tag").get("name"), tagName.get()));
            }
            return p;
        });
        return posts;
    }

    @Override
    public String createNewPost(Post post, AuthorUserDetails authorUserDetails, BindingResult result) {
        Author currentAuthor = authorUserRepository.findByUserName(authorUserDetails.getUsername()).orElse(null);

        post.setAuthor(currentAuthor);

        String tagName = post.getTag().getName();

        // Set the current date (it can't be null)
        post.setDateCreated(new Date());

        // Check if tag already exists in database
        System.out.println("tagService: " + tagService);

        Tag existingTag = this.tagService.findByName(tagName);
        if (existingTag != null) {
            // If the tag already exists, just make a reference to it
            post.setTag(existingTag);
        }
        if (result.hasErrors()) {
            return "new_post";
        } else {
            this.save(post);
            return "redirect:/";
        }
    }

    @Override
    public String indexPage(Model model, AuthorUserDetails loggedUser) {
        model.addAttribute("currentUsername", loggedUser.getUsername());

        List<Post> posts = this.findAll();

        //Show newest posts first
        Collections.reverse(posts);

        model.addAttribute("posts", posts);

        return "index";
    }

    @Override
    public String prepareNewPostForm(Model model, AuthorUserDetails loggedUser) {

        model.addAttribute("currentUsername", loggedUser.getUsername());
        model.addAttribute("post", new Post());

        return "new_post";
    }

    @Override
    public String processSearchForm(Model model, AuthorUserDetails loggedUser, SearchParams searchParams) {
        model.addAttribute("currentUsername", loggedUser.getUsername());

        // For autocompletion - not memory efficient!
        model.addAttribute("allPosts", this.findAll());

        List<Post> posts = this.getPosts(
                searchParams.getDateFrom(),
                searchParams.getDateTo(),
                searchParams.getAuthorName(),
                searchParams.getTitle(),
                searchParams.getTagName()
        );

        // Newest posts are shown first
        Collections.reverse(posts);

        //Pagination implementation
        int itemsPerPage = 5;
        int currentPageNumber = 0;

        PagedListHolder<Post> page = new PagedListHolder<>(posts);

        try {
            itemsPerPage = searchParams.getItemsNum().orElse(5);
        } catch (Exception e) {
            System.err.println("Error while getting items per page number - using 5 instead...");
        }

        page.setPageSize(itemsPerPage);

        try {
            currentPageNumber = searchParams.getPage().orElse(0);
        } catch (Exception e) {
            System.err.println("Error while getting page number - using 0 instead...");
        }

        page.setPage(currentPageNumber);

        int totalPages = page.getPageCount();
        List<Post> currentPosts = page.getPageList();

        model.addAttribute("posts", currentPosts);
        model.addAttribute("totalPages", String.valueOf(totalPages + 1));
        model.addAttribute("currentPageNum", String.valueOf(currentPageNumber + 1));

        return "search";
    }

    private String openBlogPost(Model model, AuthorUserDetails loggedUser, String pathVariable) {
        authorUserRepository.findByUserName(loggedUser.getUsername()).orElse(null);

        model.addAttribute("currentUsername", loggedUser.getUsername());

        Post post = findById(Integer.valueOf(pathVariable));
        model.addAttribute("blogPost", post);
        if (!model.containsAttribute("comment")) {
            model.addAttribute("comment", new Comment());
        }
        model.addAttribute("comments", commentService.findAllByPostId(post.getId()));

        return "blog_post";
    }
}
