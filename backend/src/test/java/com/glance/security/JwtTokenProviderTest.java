package com.glance.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class JwtTokenProviderTest {

    private JwtTokenProvider provider;

    @BeforeEach
    void setUp() {
        // 使用 64+ 字符密钥以支持 HS512
        provider = new JwtTokenProvider(
                "glance-jwt-test-secret-key-2026-must-be-long-enough-for-hs512!!!",
                3600000L // 1 小时
        );
    }

    @Test
    void shouldGenerateValidToken() {
        String token = provider.generateToken(1L, "13800001111");
        assertNotNull(token);
        assertTrue(token.split("\\.").length == 3, "JWT 应有 3 段");
    }

    @Test
    void shouldExtractUserId() {
        String token = provider.generateToken(42L, "13800001111");
        Long userId = provider.getUserId(token);
        assertEquals(42L, userId);
    }

    @Test
    void shouldValidateToken() {
        String token = provider.generateToken(1L, "13800001111");
        assertTrue(provider.validateToken(token));
    }

    @Test
    void shouldRejectInvalidToken() {
        assertFalse(provider.validateToken("invalid.token.here"));
        assertFalse(provider.validateToken(""));
        assertFalse(provider.validateToken(null));
    }

    @Test
    void shouldRejectTamperedToken() {
        String token = provider.generateToken(1L, "13800001111");
        String tampered = token.substring(0, token.length() - 5) + "xxxxx";
        assertFalse(provider.validateToken(tampered));
    }

    @Test
    void differentUsersShouldHaveDifferentTokens() {
        String tokenA = provider.generateToken(1L, "13800001111");
        String tokenB = provider.generateToken(2L, "13800002222");
        assertNotEquals(tokenA, tokenB);
    }

    @Test
    void tokenShouldContainPhoneClaim() {
        // 验证 token 生成不抛异常且可解析
        String token = provider.generateToken(1L, "13800001111");
        assertDoesNotThrow(() -> provider.getUserId(token));
    }
}
