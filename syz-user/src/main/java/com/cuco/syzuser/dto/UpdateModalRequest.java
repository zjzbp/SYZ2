package com.cuco.syzuser.dto;

import lombok.Data;

@Data
public class UpdateModalRequest {
    private Long userId;
    private Integer modalId;  // 用户选择的模态标识（0-99999999）
}
