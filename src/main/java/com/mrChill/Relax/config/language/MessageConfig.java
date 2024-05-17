
package com.mrChill.Relax.config.language;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

@Component
public class MessageConfig {

    @Autowired
    MessageSource messageSource;

    public String getMessage(String property) {
        return messageSource.getMessage(property,null, LocaleContextHolder.getLocale());
    }
}
