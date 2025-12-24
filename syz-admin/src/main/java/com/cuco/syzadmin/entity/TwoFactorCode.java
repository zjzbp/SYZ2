package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 双因子码实体类
 */
@Data
@TableName("biz_two_factor_code")
public class TwoFactorCode {

    @TableId(type = IdType.AUTO)
    private Long twoFactorId;

    @TableField("two_factor_value")
    private String twoFactorValue; // 双因子码唯一值

    @TableField("grid_code_value")
    private String gridCodeValue; // 关联网格码值

    @TableField("code_type")
    private String codeType; // 码类型：ASSET-资产类、PERSONAL-个人类

    @TableField("status")
    private String status; // 状态：ACTIVATED-已激活、FROZEN-冻结、INVALID-失效

    @TableField("create_time")
    private Date createTime; // 创建时间

    @TableField("remaining_modals")
    private Long remainingModals; // 剩余模态标识数量
}