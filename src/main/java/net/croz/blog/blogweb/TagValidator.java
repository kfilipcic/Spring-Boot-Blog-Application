package net.croz.blog.blogweb;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = TagValidatorImpl.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface TagValidator {
    public int min() default 3;
    public int max() default 30;
    public String message() default "must be between x and y";

    public Class<?>[] groups() default {};
    public Class<? extends Payload>[] payload() default {};
}
