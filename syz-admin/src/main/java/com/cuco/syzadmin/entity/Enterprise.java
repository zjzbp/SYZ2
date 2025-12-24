package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 企业实体类
 */
@Data
@TableName("biz_enterprise")
public class Enterprise {

    @TableId(type = IdType.AUTO)
    private Long enterpriseId;

    @TableField("user_id")
    private Long userId;

    @TableField("enterprise_name")
    private String enterpriseName; // 企业名称

    @TableField("legal_person_name")
    private String legalPersonName; // 法人姓名

    @TableField("contact_phone")
    private String contactPhone; // 联系电话

    @TableField("verification_status")
    private String verificationStatus; // 认证状态
}