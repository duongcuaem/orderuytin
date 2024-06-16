package com.mrChill.Relax.serviceBase.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrChill.Relax.entity.Token;
import com.mrChill.Relax.repoBase.TokenRepository;
import com.mrChill.Relax.serviceBase.TokenService;


@Service
public class TokenServiceImpl implements TokenService {

    @Autowired
    private TokenRepository tokenRepository;

    public Token createToken(Token token) {
        return tokenRepository.saveAndFlush(token);
    }

    @Override
    public Token findByToken(String token) {
        return tokenRepository.findByToken(token);
    }
}
