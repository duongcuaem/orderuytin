package com.mrChill.Relax.serviceBase;

import com.mrChill.Relax.entity.Token;

public interface TokenService {

    Token createToken(Token token);

    Token findByToken(String token);
}
