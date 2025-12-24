package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

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

    @TableField("gender")
    private String gender; // 性别

    @TableField("email")
    private String email; // 邮箱

    @TableField("verification_status")
    private String verificationStatus; // 认证状态
}