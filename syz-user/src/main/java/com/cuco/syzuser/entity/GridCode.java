package com.cuco.syzuser.entity;

import lombok.Data;

@Data
public class GridCode {
    private Long gridCodeId;        // 表内唯一标识
    private String gridCodeValue;   // 网格码唯一值
    private Long userId;            // 关联用户ID（逻辑外键）
    private String status;          // 状态：VALID-有效、INVALID-失效
    private String hashValue;       // 区块链存证哈希值
    private String depositRecordId; // 区块链存证记录ID
}
