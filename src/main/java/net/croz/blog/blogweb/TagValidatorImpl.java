package net.croz.blog.blogweb;

import org.springframework.beans.BeanWrapperImpl;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class TagValidatorImpl implements ConstraintValidator<TagValidator, String> {
    private int min;
    private int max;

    @Override
    public void initialize(TagValidator constraintAnnotation) {
        this.min = constraintAnnotation.min();
        this.max = constraintAnnotation.max();
    }

    @Override
    public boolean isValid(String string, ConstraintValidatorContext constraintValidatorContext) {
        int value = string.length();
        boolean v =  value >= min && value <= max;
        System.out.println(v);
        System.out.println("Tag name length: " + value);
        return value >= min && value <= max;
    }
}
