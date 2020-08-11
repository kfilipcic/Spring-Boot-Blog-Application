package net.croz.blog.blogweb.service;

import lombok.extern.log4j.Log4j2;
import net.croz.blog.blogweb.domain.Author;
import net.croz.blog.blogweb.domain.Post;
import net.croz.blog.blogweb.repository.PostRepository;
import net.croz.blog.blogweb.search.SearchParams;
import net.croz.blog.blogweb.security.AuthorUserDetails;
import net.croz.blog.blogweb.repository.AuthorUserRepository;
import net.croz.blog.blogweb.domain.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Log4j2
public class PostServiceImpl implements PostService {
    @Autowired
    private EntityManager entityManager;

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
    public List<Post> findAllReversed() {
        List<Post> posts = postRepository.findAll();
        Collections.reverse(posts);
        return posts;
    }

    @Override
    public List<Integer> everyPostCommentsCount() {
        List<Integer> list = new ArrayList<>();
        List<Post> posts = findAllReversed();
        for (Post p : posts) {
            list.add(commentService.findAllByPostId(p.getId()).size());
        }
        return list;
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

    public PostsLong getCurrentPagePosts(Optional<Date> dateFrom,
                                         Optional<Date> dateTo,
                                         Optional<String> authorName,
                                         Optional<String> title,
                                         Optional<String> tagName,
                                         int currentPageNumber,
                                         int itemsPerPage) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Post> cq = cb.createQuery(Post.class);

        Root<Post> root = cq.from(Post.class);
        List<Predicate> p = new ArrayList<>();

        if (Objects.nonNull(dateFrom) && Objects.nonNull(dateTo) && dateFrom.get().before(dateTo.get())) {
            p.add(cb.between(root.get("dateCreated"), dateFrom.get(), dateTo.get()));
        } else if (Objects.isNull(dateFrom) && Objects.nonNull(dateTo)) {
            p.add(cb.lessThanOrEqualTo(root.get("dateCreated"), dateTo.get()));
        } else if (Objects.isNull(dateTo) && Objects.nonNull(dateFrom)) {
            p.add(cb.greaterThanOrEqualTo(root.get("dateCreated"), dateFrom.get()));
        }
        if (authorName != null && authorName.isPresent() && !authorName.get().isEmpty()) {
            Matcher matcher = r.matcher(authorName.get());
            if (matcher.find() && matcher.groupCount() == 2) {
                p.add(cb.like(root.get("author").get("firstName"), matcher.group(1)));
                p.add(cb.like(root.get("author").get("lastName"), matcher.group(2)));
            } else {
                p.add(cb.like(root.get("author").get("firstName"), authorName.get()));
                p.add(cb.like(root.get("author").get("lastName"), authorName.get()));
            }
        }
        if (title != null && title.isPresent() && !title.get().isEmpty()) {
            p.add(cb.like(root.get("title"), "%" + title.get() + "%"));
        }
        if (tagName != null && tagName.isPresent() && !tagName.get().isEmpty()) {
            p.add(cb.like(root.get("tag").get("name"), tagName.get()));
        }

        cq.where(p.toArray(new Predicate[0]));

        // Sort by date (show newest posts first)
        cq.orderBy(cb.desc(root.get("id")));

        CriteriaQuery<Long> cql = cb.createQuery(Long.class);
        cql.select(cb.count(cql.from(Post.class)));
        cql.where(p.toArray(new Predicate[0]));

        return new PostsLong(entityManager
                .createQuery(cq)
                .setFirstResult(currentPageNumber * itemsPerPage)
                .setMaxResults(itemsPerPage)
                .getResultList(),
                entityManager
                        .createQuery(cql)
                        .getSingleResult());
    }

    @Override
    public Boolean createNewPost(Post post, AuthorUserDetails authorUserDetails, BindingResult result) {
        Author currentAuthor = authorUserRepository.findByUserName(authorUserDetails.getUsername()).orElse(null);

        post.setAuthor(currentAuthor);

        String tagName = post.getTag().getName();

        // Set the current date (it can't be null)
        post.setDateCreated(new Date());

        Tag existingTag = this.tagService.findByName(tagName);
        if (existingTag != null) {
            // If the tag already exists, just make a reference to it
            post.setTag(existingTag);
        }
        if (result.hasErrors()) {
            return false;
        } else {
            this.save(post);
            return true;
        }
    }

    public Long getPostsCount(CriteriaBuilder criteriaBuilder) {
        CriteriaQuery<Long> countQuery = criteriaBuilder
                .createQuery(Long.class);
        countQuery.select(criteriaBuilder.count(
                countQuery.from(Post.class)));
        Long count = entityManager.createQuery(countQuery)
                .getSingleResult();

        return count;
    }

    @Override
    public String processSearchForm(Model model, AuthorUserDetails loggedUser, SearchParams searchParams) {
        model.addAttribute("currentUsername", loggedUser.getUsername());

        // For autocompletion - not memory efficient!
        model.addAttribute("allPosts", this.findAllReversed());

        //Pagination implementation
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();

        int itemsPerPage = 5;
        int currentPageNumber = 0;

        try {
            itemsPerPage = searchParams.getItemsNum().orElse(5);
        } catch (Exception e) {
            log.error("Error while getting items per page number - using 5 instead...");
        }

        try {
            currentPageNumber = searchParams.getPage().orElse(0);
        } catch (Exception e) {
            log.error("Error while getting page number - using 0 instead...");
        }

        PostsLong postsInteger = getCurrentPagePosts(
                searchParams.getDateFrom(),
                searchParams.getDateTo(),
                searchParams.getAuthorName(),
                searchParams.getTitle(),
                searchParams.getTagName(),
                currentPageNumber,
                itemsPerPage
        );

        int totalPages = (int) -Math.floor(-((double)postsInteger.getCount() / (double) itemsPerPage));

        model.addAttribute("posts", postsInteger.getPosts());
        model.addAttribute("totalPages", String.valueOf(totalPages + 1));
        model.addAttribute("currentPageNum", String.valueOf(currentPageNumber + 1));

        return "search";
    }
}
