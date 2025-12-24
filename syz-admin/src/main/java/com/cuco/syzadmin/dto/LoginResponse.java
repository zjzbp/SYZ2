package com.cuco.syzadmin.dto;

import lombok.Data;

/**
 * 登录响应DTO
 */
@Data
public class LoginResponse {
    
    /**
     * JWT token
     */
    private String token;
    
    /**
     * 用户信息（仅包含id和name）
     */
    private UserInfoDTO user;
    
    public LoginResponse(String token, UserInfoDTO user) {
        this.token = token;
        this.user = user;
    }
}
