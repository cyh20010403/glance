package com.glance.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Base64;
import java.util.Date;

@Component
public class JwtTokenProvider {

    private final SecretKey key;
    private final long expiration;

    public JwtTokenProvider(
            @Value("${jwt.secret}") String secret,
            @Value("${jwt.expiration}") long expiration) {
        byte[] keyBytes = Base64.getEncoder().encode(secret.getBytes());
        this.key = Keys.hmacShaKeyFor(keyBytes);
        this.expiration = expiration;
    }

    /** 生成 JWT Token */
    public String generateToken(Long userId, String phone) {
        Date now = new Date();
        return Jwts.builder()
                .subject(String.valueOf(userId))
                .claim("phone", phone)
                .issuedAt(now)
                .expiration(new Date(now.getTime() + expiration))
                .signWith(key)
                .compact();
    }

    /** 从 Token 中提取用户 ID */
    public Long getUserId(String token) {
        return Long.parseLong(
                Jwts.parser()
                        .verifyWith(key)
                        .build()
                        .parseSignedClaims(token)
                        .getPayload()
                        .getSubject()
        );
    }

    /** 验证 Token 是否有效 */
    public boolean validateToken(String token) {
        try {
            Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }
}
