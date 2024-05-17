package com.mrChill.Relax.Dao.validation.password;


import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.mrChill.Relax.Dao.UsersDAO;

public class PasswordValidation implements ConstraintValidator<PasswordAnotation, UsersDAO> {
    @Override
    public boolean isValid(UsersDAO  value, ConstraintValidatorContext context) {
        return value.getPassword().equals(value.getRePassword());
    }
}
