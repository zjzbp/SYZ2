package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 模态标识实体类
 */
@Data
@TableName("biz_modal_identifier")
public class ModalIdentifier {

    @TableId(type = IdType.AUTO)
    private Long modalId;

    @TableField("modal_value")
    private String modalValue; // 模态标识唯一值

    @TableField("two_factor_value")
    private String twoFactorValue; // 关联双因子码值

    @TableField("identifier_type")
    private String identifierType; // 标识类型：PROJECT-项目类（如口述历史）

    @TableField("status")
    private String status; // 状态：VALID-有效、INVALID-失效

    @TableField("hash_value")
    private String hashValue; // 区块钾存证哈希值

    @TableField("create_time")
    private String createTime; // 创建时间
}