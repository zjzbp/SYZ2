package com.cuco.syzuser.entity;
import lombok.Data;
import java.util.Date;

@Data
public class ModalIdentifier {
    private Long modalId;           // 表内唯一标识（确权最小单元ID）
    private String modalValue;      // 模态标识值（雪花算法生成）
    private String twoFactorValue;  // 关联双因子码值
    private Long userId;            // 关联用户ID（逻辑外键）
    private String identifierType;  // 标识类型：PROJECT-项目类（如口述历史）
    private String status;          // 状态：VALID-有效、INVALID-失效
    private String hashValue;       // 区块链存证哈希值（用于验真）
    private Date createTime;        // 创建时间
}