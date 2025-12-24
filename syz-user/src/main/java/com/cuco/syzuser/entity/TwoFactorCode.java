package com.cuco.syzuser.entity;

import lombok.Data;

@Data
public class TwoFactorCode {
    private Long twoFactorId;        // 表内唯一标识
    private String twoFactorValue;   // 双因子码唯一值
    private Long userId;             // 关联用户ID（逻辑外键）
    private String gridCodeValue;    // 关联网格码值（初始为NULL）
    private String codeType;         // 码类型：ASSET-资产类、PERSONAL-个人类
    private String status;           // 状态：ACTIVATED-已激活、FROZEN-冻结、INVALID-失效
    private Long remainingModals;    // 剩余模态标识数量（默认1亿）
}
