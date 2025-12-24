package com.cuco.syzadmin.dto;

import lombok.Data;

/**
 * 登录请求DTO
 */
@Data
public class LoginRequest {
    
    /**
     * 手机号
     */
    private String phone;
    
    /**
     * 密码
     */
    private String password;
}
