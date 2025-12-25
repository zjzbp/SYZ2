package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

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

    @TableField("unified_social_credit_code")
    private String unifiedSocialCreditCode; // 统一社会信用代码

    @TableField("business_license_url")
    private String businessLicenseUrl; // 营业执照照片

    @TableField("legal_person_name")
    private String legalPersonName; // 法人姓名

    @TableField("legal_person_id_card")
    private String legalPersonIdCard; // 法人身份证号

    @TableField("legal_person_id_front_url")
    private String legalPersonIdFrontUrl; // 法人身份证正面

    @TableField("legal_person_id_back_url")
    private String legalPersonIdBackUrl; // 法人身份证背面

    @TableField("contact_phone")
    private String contactPhone; // 联系电话

    @TableField("contact_email")
    private String contactEmail; // 联系邮箱

    @TableField("enterprise_address")
    private String enterpriseAddress; // 企业地址

    @TableField("business_scope")
    private String businessScope; // 经营范围

    @TableField("registered_capital")
    private BigDecimal registeredCapital; // 注册资本

    @TableField("establishment_date")
    private LocalDate establishmentDate; // 成立日期

    @TableField("verification_status")
    private String verificationStatus; // 认证状态

    @TableField("verification_time")
    private LocalDateTime verificationTime; // 认证时间

    @TableField("remark")
    private String remark; // 备注

    @TableField("create_time")
    private LocalDateTime createTime; // 创建时间

    @TableField("update_time")
    private LocalDateTime updateTime; // 更新时间

    @TableLogic
    @TableField("deleted")
    private Integer deleted; // 是否删除
}