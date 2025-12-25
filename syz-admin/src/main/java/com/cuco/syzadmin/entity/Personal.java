package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 个人实体类
 */
@Data
@TableName("biz_personal")
public class Personal {

    @TableId(type = IdType.AUTO)
    private Long personalId;

    @TableField("user_id")
    private Long userId;

    @TableField("real_name")
    private String realName; // 真实姓名

    @TableField("id_card")
    private String idCard; // 身份证号

    @TableField("id_card_front_url")
    private String idCardFrontUrl; // 身份证正面照片

    @TableField("id_card_back_url")
    private String idCardBackUrl; // 身份证背面照片

    @TableField("gender")
    private String gender; // 性别

    @TableField("birth_date")
    private LocalDate birthDate; // 出生日期

    @TableField("nationality")
    private String nationality; // 国籍

    @TableField("address")
    private String address; // 地址

    @TableField("email")
    private String email; // 邮箱

    @TableField("occupation")
    private String occupation; // 职业

    @TableField("education_level")
    private String educationLevel; // 学历

    @TableField("emergency_contact_name")
    private String emergencyContactName; // 紧急联系人姓名

    @TableField("emergency_contact_phone")
    private String emergencyContactPhone; // 紧急联系人电话

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