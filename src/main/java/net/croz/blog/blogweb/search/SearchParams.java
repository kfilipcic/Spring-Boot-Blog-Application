package net.croz.blog.blogweb.search;

import javax.persistence.Entity;
import java.util.Optional;

public class SearchParams {
    private Optional<String> dateFrom;
    private Optional<String> dateTo;
    private Optional<String> authorName;
    private Optional<String> title;
    private Optional<String> tagName;
    private Optional<Integer> pageNumber;

    public Optional<String> getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(Optional<String> dateFrom) {
        this.dateFrom = dateFrom;
    }

    public Optional<String> getDateTo() {
        return dateTo;
    }

    public void setDateTo(Optional<String> dateTo) {
        this.dateTo = dateTo;
    }

    public Optional<String> getAuthorName() {
        return authorName;
    }

    public void setAuthorName(Optional<String> authorName) {
        this.authorName = authorName;
    }

    public Optional<String> getTitle() {
        return title;
    }

    public void setTitle(Optional<String> title) {
        this.title = title;
    }

    public Optional<String> getTagName() {
        return tagName;
    }

    public void setTagName(Optional<String> tagName) {
        this.tagName = tagName;
    }

    public Optional<Integer> getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Optional<Integer> pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Optional<Integer> getItemsNum() {
        return itemsNum;
    }

    public void setItemsNum(Optional<Integer> itemsNum) {
        this.itemsNum = itemsNum;
    }

    private Optional<Integer> itemsNum;
}
