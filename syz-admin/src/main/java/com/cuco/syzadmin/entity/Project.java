package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("project")
public class Project {
    @TableId(type = IdType.AUTO)
    private Integer id;           // 项目ID
    
    @TableField("project_type")
    private String projectType;   // 项目类型
    
    @TableField("create_time")
    private LocalDateTime createTime;  // 创建时间
    
    @TableField("update_time")
    private LocalDateTime updateTime;  // 更新时间
    
    @TableLogic
    @TableField("is_delete")
    private Integer isDelete;     // 是否删除 0-未删除 1-已删除
    
    @TableField("score")
    private Double score;         // 项目类别分数
}
