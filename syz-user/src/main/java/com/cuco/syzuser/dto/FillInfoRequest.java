package com.cuco.syzuser.dto;

import lombok.Data;

@Data
public class FillInfoRequest {
    private Long userId;
    private String gridCode;
    private String twoFactorCode;
}
