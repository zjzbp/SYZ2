package com.cuco.syzadmin.dto;

import com.cuco.syzadmin.entity.*;
import lombok.Data;

import java.util.List;

/**
 * 用户完整详情DTO
 * 包含用户基本信息、个人/企业详情、双因子码、模态标识列表、项目类别统计和分数
 */
@Data
public class UserFullDetailDTO {
    
    // 用户基本信息
    private User user;
    
    // 个人详情（当用户类型为PERSONAL时）
    private Personal personalDetail;
    
    // 企业详情（当用户类型为ENTERPRISE时）
    private Enterprise enterpriseDetail;
    
    // 双因子码信息
    private TwoFactorCode twoFactorCode;
    
    // 模态标识列表
    private List<ModalIdentifier> modalIdentifiers;
    
    // 模态标识总数
    private Integer modalIdentifierCount;
    
    // 项目信息列表
    private List<ProjectInfo> projectInfos;
    
    // 项目类别统计列表
    private List<ProjectTypeStat> projectTypeStats;
    
    // 总分
    private Double totalScore;
    
    /**
     * 项目类别统计内部类
     */
    @Data
    public static class ProjectTypeStat {
        // 项目类别名称
        private String projectType;
        
        // 项目类别显示名称
        private String projectTypeName;
        
        // 该类别下的项目数量
        private Integer count;
        
        // 该类别的分数
        private Double score;
        
        // 占总数的百分比
        private Double percentage;
        
        public ProjectTypeStat() {}
        
        public ProjectTypeStat(String projectType, Integer count) {
            this.projectType = projectType;
            this.projectTypeName = getProjectTypeDisplayName(projectType);
            this.count = count;
        }
        
        /**
         * 获取项目类型显示名称
         */
        private String getProjectTypeDisplayName(String type) {
            if (type == null) return "未知类型";
            switch (type) {
                case "ORAL_HISTORY": return "口述历史";
                case "INTANGIBLE_HERITAGE": return "非遗记录";
                case "DOCUMENT_ARCHIVE": return "文档存档";
                case "ART_WORK": return "艺术作品";
                case "ACADEMIC_RESEARCH": return "学术研究";
                default: return type; // 直接返回原始值（中文类型名）
            }
        }
    }
}
