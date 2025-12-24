package com.cuco.syzuser.dto;

import lombok.Data;

@Data
public class RegisterRequest {
    private String phone;
    private String password;
    private String verifyCode;
    private String username;
}
