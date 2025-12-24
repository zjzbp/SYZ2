package com.cuco.syzadmin.entity;

import lombok.Data;

/**
 * 统计数据实体类
 */
@Data
public class StatisticsData {
    private Long totalUsers;
    private Long totalGridCodes;
    private Long totalTwoFactorCodes;
    private Long totalModalIdentifiers;
    private Long totalProjects;
}