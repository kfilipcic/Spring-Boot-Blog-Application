package net.croz.blog.blogweb.search;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Optional;

public class SearchParams {
    private Optional<String> dateFrom;
    private Optional<String> dateTo;
    private Optional<String> authorName;
    private Optional<String> title;
    private Optional<String> tagName;
    private Optional<Integer> page;

    private static DateFormat format = new SimpleDateFormat("dd.MM.yyyy", Locale.ENGLISH);

    public Optional<String> getDateFromString() {
        return dateFrom;
    }

    public void setDateFrom(Optional<String> dateFrom) {
        this.dateFrom = dateFrom;
    }

    public Optional<String> getDateToString() {
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

    public Optional<Integer> getPage() {
        return page;
    }

    public void setPage(Optional<Integer> page) {
        this.page = page;
    }

    public Optional<Integer> getItemsNum() {
        return itemsNum;
    }

    public void setItemsNum(Optional<Integer> itemsNum) {
        this.itemsNum = itemsNum;
    }

    private Optional<Integer> itemsNum;

    public Optional<Date> getDateFrom() {
        if (dateFrom == null) return null;
        if (!dateFrom.isPresent()) return null;
        try {
            return Optional.ofNullable(format.parse(dateFrom.get()));
        } catch (ParseException e) {
            System.err.println("Error parsing starting date.");
        }
        return null;
    }

    public Optional<Date> getDateTo() {
        if (dateTo == null) return null;
        if (!dateTo.isPresent()) return null;
        try {
            return Optional.ofNullable(format.parse(dateTo.get()));
        } catch (ParseException e) {
            System.err.println("Error parsing ending date.");
        }
        return null;
    }
}
