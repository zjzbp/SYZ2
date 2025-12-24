package com.cuco.syzuser.dto;

import lombok.Data;

@Data
public class ResetPasswordRequest {
    private String phone;
    private String verifyCode;
    private String newPassword;
    private String confirmPassword;
}
