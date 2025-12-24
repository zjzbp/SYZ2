package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 项目信息实体类
 */
@Data
@TableName("biz_project_info")
public class ProjectInfo {

    @TableId(type = IdType.AUTO)
    private Long projectId;

    @TableField("modal_id")
    private Long modalId; // 关联模态标识ID

    @TableField("user_id")
    private Long userId; // 用户ID

    @TableField("project_name")
    private String projectName; // 项目名称

    @TableField("byte_size")
    private Long byteSize; // 文件大小（字节）

    @TableField("project_type")
    private String projectType; // 项目类型：口述历史、非遗记录、文档存档等

    @TableField("cloud_storage_url")
    private String cloudStorageUrl; // 云仓库存储URL

    @TableField("project_desc")
    private String projectDesc; // 项目描述

    @TableField("upload_time")
    private String uploadTime; // 上传时间

    @TableField("project_status")
    private String projectStatus; // 项目状态：ONLINE-上线、OFFLINE-下架

    @TableField("create_time")
    private String createTime; // 创建时间
}