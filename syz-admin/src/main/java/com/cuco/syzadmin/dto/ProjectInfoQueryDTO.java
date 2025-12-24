package com.cuco.syzadmin.dto;

import lombok.Data;

/**
 * 项目信息查询DTO
 */
@Data
public class ProjectInfoQueryDTO {
    
    /**
     * 双因子码值
     */
    private String twoFactorValue;
    
    /**
     * 创建时间开始（格式：yyyy-MM-dd HH:mm:ss）
     */
    private String createTimeStart;
    
    /**
     * 创建时间结束（格式：yyyy-MM-dd HH:mm:ss）
     */
    private String createTimeEnd;
    
    /**
     * 项目名称（用于模糊查询）
     */
    private String projectName;
    
    /**
     * 项目类型
     */
    private String projectType;
    
    /**
     * 当前页
     */
    private Integer currentPage = 1;
    
    /**
     * 每页大小
     */
    private Integer pageSize = 10;
}
