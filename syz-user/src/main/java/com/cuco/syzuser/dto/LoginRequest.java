package com.cuco.syzuser.dto;
import lombok.Data;

@Data
public class LoginRequest {
    private String loginType;       // 登录方式: "phone" 或 "twoFactorCode" 或 "gridCode"
    
    // 登录账号（可能是手机号、双因子码或网格码）
    private String account;
    
    // 密码（所有登录方式都需要）
    private String password;
}