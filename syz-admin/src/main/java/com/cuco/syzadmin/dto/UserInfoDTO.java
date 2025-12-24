package com.cuco.syzadmin.dto;

import lombok.Data;

/**
 * 用户信息DTO（简化版，仅包含基本信息）
 */
@Data
public class UserInfoDTO {
    
    /**
     * 用户ID
     */
    private Long id;
    
    /**
     * 用户姓名
     */
    private String name;
    
    public UserInfoDTO(Long id, String name) {
        this.id = id;
        this.name = name;
    }
}
