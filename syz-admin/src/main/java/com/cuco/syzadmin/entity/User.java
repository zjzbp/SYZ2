package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户实体类
 */
@Data
@TableName("user")
public class User {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String name;
    
    private String phone;
    
    private String gridCode;
    
    private String twoFactorCode;
    
    private String password;
    
    private Integer isFillin;
    
    private LocalDateTime createTime;
    
    private Integer modalId;
}
