package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 用户实体类
 */
@Data
@TableName("biz_user")
public class User {
    
    @TableId(value = "user_id", type = IdType.AUTO)
    private Long userId;
    
    @TableField("user_type")
    private String userType;
    
    @TableField("phone")
    private String phone;
    
    @TableField("grid_code")
    private String gridCode;
    
    @TableField("two_factor_code")
    private String twoFactorCode;
    
    @TableField("password")
    private String password;
    
    @TableField("is_fillin")
    private Integer isFillin;
    
    @TableField("create_time")
    private String createTime;
    
    @TableField("modal_id")
    private Integer modalId;
    
    @TableField("status")
    private String status;

}