package com.cuco.syzadmin.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * JWT 工具类
 */
@Component
public class JwtUtil {
    
    // 密钥（实际项目应该放在配置文件中）
    private static final String SECRET_KEY = "syzAdminJwtSecretKey2025ShuangYinZiSystemVerySecure";
    
    // token 有效期：7天（单位：毫秒）
    private static final long EXPIRATION_TIME = 7 * 24 * 60 * 60 * 1000;
    
    private final SecretKey key;
    
    public JwtUtil() {
        this.key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
    }
    
    /**
     * 生成 token
     * @param userId 用户ID
     * @param phone 手机号
     * @return token字符串
     */
    public String generateToken(Long userId, String phone) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", userId);
        claims.put("phone", phone);
        
        return Jwts.builder()
                .claims(claims)
                .subject(phone)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(key)
                .compact();
    }
    
    /**
     * 解析 token
     * @param token token字符串
     * @return Claims
     */
    public Claims parseToken(String token) {
        return Jwts.parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
    
    /**
     * 验证 token 是否有效
     * @param token token字符串
     * @return 是否有效
     */
    public boolean validateToken(String token) {
        try {
            Claims claims = parseToken(token);
            return !claims.getExpiration().before(new Date());
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * 从 token 中获取用户ID
     * @param token token字符串
     * @return 用户ID
     */
    public Long getUserIdFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.get("userId", Long.class);
    }
    
    /**
     * 从 token 中获取手机号
     * @param token token字符串
     * @return 手机号
     */
    public String getPhoneFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.get("phone", String.class);
    }
}
