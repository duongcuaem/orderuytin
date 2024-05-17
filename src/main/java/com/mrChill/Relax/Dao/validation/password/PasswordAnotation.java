package com.mrChill.Relax.Dao.validation.password;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = PasswordValidation.class)
@Target( { ElementType.TYPE} )
@Retention(RetentionPolicy.RUNTIME)
public @interface PasswordAnotation {
    //error message
    public String message() default "Không khớp mật khẩu";
    //represents group of constraints
    public Class<?>[] groups() default {};
    //represents additional information about annotation
    public Class<? extends Payload>[] payload() default {};
}
