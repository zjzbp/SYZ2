package com.cuco.syzuser.entity;

import lombok.Data;
import java.util.Date;

@Data
public class ProjectInfo {
    private Long projectId;          // 项目唯一标识
    private Long modalId;            // 关联模态标识ID
    private String modalValue;       // 模态标识值（雪花算法生成）
    private Long userId;             // 关联用户ID（逻辑外键）
    private String projectName;      // 项目名称
    private String projectType;      // 项目类型
    private Long byteSize;           // 字节码大小
    private String cloudStorageUrl;  // 云仓库存储URL
    private String projectDesc;      // 项目描述
    private Date uploadTime;         // 上传时间
    private String projectStatus;    // 项目状态：ONLINE-上线、OFFLINE-下架
    private Integer deleted;         // 逻辑删除：0-正常、1-已删除
}
