package net.croz.blog.blogweb.validator;

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
        return value >= min && value <= max;
    }
}
