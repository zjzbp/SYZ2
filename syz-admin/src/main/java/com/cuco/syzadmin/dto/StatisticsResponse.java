package com.cuco.syzadmin.dto;

import lombok.Data;

/**
 * 统计数据响应DTO
 */
@Data
public class StatisticsResponse {
    private Long totalUsers;
    private Long totalGridCodes;
    private Long totalTwoFactorCodes;
    private Long totalModalIdentifiers;
    private Long totalProjects;
    private String message;
}