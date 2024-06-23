package com.mrChill.Relax.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtUtil {

    private static final Logger logger = LoggerFactory.getLogger(JwtUtil.class);
    private static final String USER = "user";
    private static final String USER_ID = "userId";
    private static final String SECRET = "daycaidaynaychinhlachukycuabandungdelorangoaidaynhenguyhiemchetnguoidayhihihi";
    private static final long EXPIRATION_TIME = 864000000L; // 10 ngày tính bằng milliseconds

    private final ObjectMapper objectMapper = new ObjectMapper();

    // Tạo token với thông tin người dùng
    public String generateToken(UserPrincipal user) {
        String token = null;
        try {
            Map<String, Object> userMap = objectMapper.convertValue(user, Map.class);

            JWTClaimsSet.Builder builder = new JWTClaimsSet.Builder();
            builder.claim(USER, userMap); // Đặt thông tin người dùng vào claims
            builder.claim(USER_ID, user.getUserId().toString()); // Đặt userId vào claims dưới dạng String
            builder.expirationTime(generateExpirationDate()); // Đặt thời gian hết hạn cho token
            JWTClaimsSet claimsSet = builder.build();

            // Ký token với thuật toán HS256 và secret
            SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS256), claimsSet);
            JWSSigner signer = new MACSigner(SECRET.getBytes());
            signedJWT.sign(signer);

            // Chuyển token sang dạng chuỗi
            token = signedJWT.serialize();
        } catch (Exception e) {
            logger.error("Error generating token: " + e.getMessage(), e);
        }
        return token;
    }

    // Tạo ngày hết hạn cho token
    public Date generateExpirationDate() {
        return new Date(System.currentTimeMillis() + EXPIRATION_TIME);
    }

    // Lấy JWT claims từ token
    private JWTClaimsSet getClaimsFromToken(String token) {
        JWTClaimsSet claims = null;
        try {
            // Phân tích token
            SignedJWT signedJWT = SignedJWT.parse(token);
            // Xác thực token với secret
            JWSVerifier verifier = new MACVerifier(SECRET.getBytes());
            if (signedJWT.verify(verifier)) {
                claims = signedJWT.getJWTClaimsSet();
            }
        } catch (ParseException | JOSEException e) {
            logger.error("Error parsing token: " + e.getMessage(), e);
        }
        return claims;
    }

    // Lấy đối tượng UserPrincipal từ token
    public UserPrincipal getUserFromToken(String token) {
        UserPrincipal user = null;
        try {
            JWTClaimsSet claims = getClaimsFromToken(token);
            if (claims != null && !isTokenExpired(claims)) {
                // Lấy thông tin người dùng từ claims
                Map<String, Object> userMap = (Map<String, Object>) claims.getClaim(USER);
                if (userMap != null) {
                    // Chuyển đổi Map thành đối tượng UserPrincipal
                    user = objectMapper.convertValue(userMap, UserPrincipal.class);
                    // Nếu attributes là null, khởi tạo nó như một Map trống
                    if (user.getAttributes() == null) {
                        user.setAttributes(new HashMap<>());
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Error getting user from token: " + e.getMessage(), e);
        }
        return user;
    }

    // Lấy ngày hết hạn từ claims
    private Date getExpirationDateFromToken(JWTClaimsSet claims) {
        return claims != null ? claims.getExpirationTime() : null;
    }

    // Kiểm tra xem token có hết hạn không
    private boolean isTokenExpired(JWTClaimsSet claims) {
        Date expirationDate = getExpirationDateFromToken(claims);
        return expirationDate != null && expirationDate.before(new Date());
    }

    // Lấy userId từ token
    public Integer getUserIdFromJWT(String token) {
        try {
            JWTClaimsSet claims = getClaimsFromToken(token);
            if (claims != null) {
                return Integer.parseInt(claims.getStringClaim(USER_ID)); // Chuyển đổi userId từ String sang Long
            }
        } catch (Exception e) {
            logger.error("Error getting user ID from token: " + e.getMessage(), e);
        }
        return null;
    }
}
